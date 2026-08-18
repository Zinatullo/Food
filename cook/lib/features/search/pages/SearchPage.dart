import 'package:cook/features/home/widgets/restaurantHomeCard.dart';
import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  final int cartCount;

  const SearchPage({
    super.key,
    required this.cartCount,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FoodService _foodService = FoodService();

  List<FoodItem> _allProducts = [];
  List<FoodItem> _searchResults = [];
  bool _isLoading = true;

  final List<String> _recentKeywords = [
    'Burger',
    'Sandwich',
    'Pizza',
    'Sanwich',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final data = await _foodService.getProducts();
    if (mounted) {
      setState(() {
        _allProducts = data;
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    final cleanQuery = query.trim().toLowerCase();

    if (cleanQuery.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchResults = _allProducts.where((item) {
        final nameMatch = item.name.toLowerCase().contains(cleanQuery);
        final restMatch = item.restaurantName.toLowerCase().contains(cleanQuery);
        final catMatch = item.category.toLowerCase().contains(cleanQuery);
        return nameMatch || restMatch || catMatch;
      }).toList();
    });
  }

  void _selectKeyword(String keyword) {
    _searchController.text = keyword;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: keyword.length),
    );
    _onSearchChanged(keyword);
  }

  void _navigateToDetails(FoodItem item) {
    context.push('/details', extra: item);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, FoodItem> uniqueRestaurants = {};
    for (var item in _allProducts) {
      if (!uniqueRestaurants.containsKey(item.restaurantName)) {
        uniqueRestaurants[item.restaurantName] = item;
      }
    }
    final suggestedRestaurants = uniqueRestaurants.values.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECF0F4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF181C2E),
                      size: 18,
                    ),
                  ),
                ),
                const Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF181C2E),
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Color(0xFF181C2E),
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: (){
                            context.go('/cart');
                          },
                          child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        )
                      ),
                      if (widget.cartCount > 0)
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
                                widget.cartCount.toString(),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF7622)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Поисковая строка
                  Container(
                    height: 62,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFFA0A5BA),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF181C2E),
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Search dishes, restaurants...',
                              hintStyle: TextStyle(
                                color: Color(0xFFA0A5BA),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Color(0xFFA0A5BA),
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Вывод результатов поиска
                  if (_searchController.text.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    if (_searchResults.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            'Nothing found',
                            style: TextStyle(
                              color: Color(0xFFA0A5BA),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: RestaurantHomeCard(item: _searchResults[index]),
                          );
                        },
                      ),
                  ] else ...[
                    // Recent Keywords
                    const SizedBox(height: 24),
                    const Text(
                      'Recent Keywords',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF181C2E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _recentKeywords.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final keyword = _recentKeywords[index];
                          return GestureDetector(
                            onTap: () => _selectKeyword(keyword),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFFEDEDED),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  keyword,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF181C2E),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Suggested Restaurants (клики ведут на детали)
                    const SizedBox(height: 28),
                    const Text(
                      'Suggested Restaurants',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF181C2E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: suggestedRestaurants.length,
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(
                          color: Color(0xFFEBEBEB),
                          height: 1,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        final item = suggestedRestaurants[index];
                        return GestureDetector(
                          onTap: () => _navigateToDetails(item),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF98A8B8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.restaurantName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF181C2E),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_border_rounded,
                                          color: Color(0xFFFF7622),
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          item.rating.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF181C2E),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // Popular Fast Food (клики ведут на детали)
                    const SizedBox(height: 28),
                    const Text(
                      'Popular Fast Food',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF181C2E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 210,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _allProducts.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final item = _allProducts[index];
                          return GestureDetector(
                            onTap: () => _navigateToDetails(item),
                            child: SizedBox(
                              width: 154,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 154,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF98A8B8),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    item.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF181C2E),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.restaurantName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFA0A5BA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}