



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      image: 'assets/images/grey.png',
      title: 'All your favorites',
      description:
          'Get all your loved foods in one place,\nyou just place the order we do the rest',
    ),
    OnboardingItem(
      image: 'assets/images/grey.png',
      title: 'Order from chosen chef',
      description:
          'Get all your loved foods in one place,\nyou just place the order we do the rest',
    ),
    OnboardingItem(
      image: 'assets/images/grey.png',
      title: 'Free delivery offers',
      description:
          'Get all your loved foods in one place,\nyou just place the order we do the rest',
    ),
        OnboardingItem(
      image: 'assets/images/grey.png',
      title: 'Free delivery offers',
      description:
          'Get all your loved foods in one place,\nyou just place the order we do the rest',
    ),
  ];

  void _onNextPressed() {
    if (_currentIndex < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnBoarding();
    }
  }

  void _finishOnBoarding() {
    context.go('/location');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == _items.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                              width: 240,
                              height: 292,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 240,
                                  height: 292,
                                  decoration: BoxDecoration(
                                    color: const   Color(0xFF98A8B8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E1D2E),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B6E82),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _items.length,
                  (index) => Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentIndex
                          ? const Color(0xFFFF7622)
                          : const Color(0xFFFFE1CE),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(

                width: double.infinity,
                height: 62,
                child: ElevatedButton(
                  onPressed: _onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7622),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isLastPage ? 'GET STARTED' : 'NEXT',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: _finishOnBoarding,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B6E82),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}