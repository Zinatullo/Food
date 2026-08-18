import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  /// Маршрут следующей страницы.
  /// Добавьте его в app_router (app/config/app_router.dart) сами.
  static const String _nextRoute = '/home';

  /// Включает/выключает реальное определение геолокации.
  /// false — геолокация не запрашивается, страница просто пропускается
  ///         (переход на следующий экран сразу по нажатию кнопки).
  /// true  — включается обычный запрос геолокации и адреса.
  static const bool _isVisLocation = false;

  bool _loading = false;
  String? _error;
  Position? _position;
  String? _address;

  Future<Position> _determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Служба геолокации выключена. Включите GPS.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Вы отклонили доступ к геолокации.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Доступ к геолокации запрещён навсегда.');
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  Future<void> _getLocation() async {
    // Геолокация временно выключена — просто пропускаем экран.
    if (!_isVisLocation) {
      _goToNextPage();
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _position = null;
      _address = null;
    });

    try {
      final position = await _determinePosition();

      final geocoding = Geocoding();
      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final placemark = placemarks.isNotEmpty ? placemarks.first : null;

      final address = [
        placemark?.street,
        placemark?.subLocality,
        placemark?.locality,
        placemark?.administrativeArea,
        placemark?.country,
      ].whereType<String>().where((s) => s.trim().isNotEmpty).join(', ');

      if (!mounted) return;
      setState(() {
        _position = position;
        _address = address.isNotEmpty ? address : null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = '$e'.replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _loading = false);
        // После получения данных (или в любом случае) переходим дальше.
        _goToNextPage();
      }
    }
  }

  /// Переходит на следующую страницу. Если её маршрут ещё не добавлен
  /// в app_router, переносит на главную ('/').
  void _goToNextPage() {
    final GoRouter router = GoRouter.of(context);
    final bool nextExists =
        router.configuration.findMatch(Uri.parse(_nextRoute)).error == null;
    router.go(nextExists ? _nextRoute : '/');
  }

  void _openSettings() => Geolocator.openAppSettings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Сверху меньше свободного места, снизу больше —
              // за счёт этого кнопки стоят выше.
              const Spacer(flex: 1),

              // Серый блок-иллюстрация из макета Figma
              Container(
                width: 206,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFF98A8B8),
                  borderRadius: BorderRadius.circular(85),
                ),
              ),

              const SizedBox(height: 32),

              // Статусы и вывод координат/ошибки.
              // Пока _isVisLocation == false, этот блок никогда не
              // показывается — экран просто пропускается по кнопке.
              if (_loading) ...[
                const CircularProgressIndicator(color: Color(0xFFFF7622)),
                const SizedBox(height: 16),
                const Text(
                  'Определяем ваше местоположение...',
                  style: TextStyle(color: Color(0xFF646982)),
                ),
              ] else if (_error != null) ...[
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
                ),
                const SizedBox(height: 12),
                if (_error!.contains('навсегда'))
                  TextButton.icon(
                    onPressed: _openSettings,
                    icon: const Icon(Icons.settings),
                    label: const Text('Открыть настройки'),
                  ),
              ] else if (_position != null) ...[
                if (_address != null) ...[
                  const Icon(Icons.check_circle, color: Colors.green, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    _address!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF181C2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  '${_position!.latitude.toStringAsFixed(5)}, ${_position!.longitude.toStringAsFixed(5)}',
                  style: const TextStyle(color: Color(0xFFA0A5BA)),
                ),
              ],

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 62,
                child: ElevatedButton(
                  onPressed: _loading ? null : _getLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7622),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFFF7622).withValues(alpha: 0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text(
                        'ACCESS LOCATION',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'DFOOD WILL ACCESS YOUR LOCATION\nONLY WHILE USING THE APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF646982),
                  height: 1.4,
                ),
              ),

              // Основное свободное пространство снизу — кнопки выше.
              const Spacer(flex: 2),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}