
import 'package:cook/features/home/widgets/homeCards.dart';
import 'package:cook/features/home/widgets/restaurantHomeCard.dart';
import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int cartCount = 2;
  final FoodService _foodService = FoodService();

  List<FoodItem> _products = [];
  List<FoodItem> _restaurants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    final data = await _foodService.getProducts();

    final Map<String, FoodItem> uniqueCategories = {};
    final Map<String, FoodItem> uniqueRestaurants = {};

    for (var item in data) {
      if (!uniqueCategories.containsKey(item.category)) {
        uniqueCategories[item.category] = item;
      }
      if (!uniqueRestaurants.containsKey(item.restaurantName)) {
        uniqueRestaurants[item.restaurantName] = item;
      }
    }

    if (mounted) {
      setState(() {
        _products = uniqueCategories.values.toList();
        _restaurants = uniqueRestaurants.values.toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(74),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    context.go('/settings');
                  },
                  child:                 Image.asset(
                  'assets/icons/BurgerMenu.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color(0xFFECF0F4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notes, color: Color(0xFF181C2E)),
                    );
                  },
                ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'DELIVER TO',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xFFFC6E2A),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Halal Lab office',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF676767),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      
                      GestureDetector(
                        onTap: (){
                          context.go('/cart');
                        },
child:                       Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Color(0xFF181C2E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      ),
                      if (cartCount > 0)
                        Positioned(
                          top: -2,
                          right: -2,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(
                              minWidth: 22,
                              minHeight: 22,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF7622),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                cartCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Hey Halal,',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ' Good Afternoon!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                    context.push('/search',extra: cartCount);
                },
                child: Container(
                  height: 62,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xFFA0A5BA),
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Search dishes, restaurants',
                        style: TextStyle(
                          color: Color(0xFFA0A5BA),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/category');
                    },
                    child: const Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Color(0xFFA0A5BA),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const SizedBox(
                      height: 170,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFF7622),
                        ),
                      ),
                    )
                  : Homecards(products: _products),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Open Restaurants',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/restaurants');
                    },
                    child: const Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Color(0xFFA0A5BA),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFF7622),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _restaurants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: RestaurantHomeCard(item: _restaurants[index]),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}