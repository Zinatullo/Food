import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantDetailCategory extends StatefulWidget {
  final FoodItem currentItem;
  final List<FoodItem> allRestaurantItems;

  const RestaurantDetailCategory({
    super.key,
    required this.currentItem,
    required this.allRestaurantItems,
  });

  @override
  State<RestaurantDetailCategory> createState() =>
      _RestaurantDetailCategoryState();
}

class _RestaurantDetailCategoryState extends State<RestaurantDetailCategory> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 1. Берем только те категории, которые действительно есть в блюдах этого ресторана
    final categories = [
      'All',
      ...widget.allRestaurantItems.map((e) => e.category).toSet(),
    ];

    // Защита от выхода за пределы массива при изменении списка
    if (_selectedIndex >= categories.length) {
      _selectedIndex = 0;
    }

    final currentCategory = categories[_selectedIndex];

    // 2. Фильтруем блюда
    final filteredProducts = currentCategory == 'All'
        ? widget.allRestaurantItems
        : widget.allRestaurantItems
            .where((item) => item.category == currentCategory)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- ЧИПСЫ КАТЕГОРИЙ ---
        SizedBox(
          height: 46,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF68A1E)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    border: isSelected
                        ? null
                        : Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        // --- ЗАГОЛОВОК КАТЕГОРИИ ---
        Text(
          '$currentCategory (${filteredProducts.length})',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: Color(0xff32343E),
          ),
        ),

        const SizedBox(height: 16),

        // --- СЕТКА ТОВАРОВ (2 колонки, без GridView/SliverGridDelegate) ---
        Column(
          children: [
              for (int i = 0; i < filteredProducts.length; i += 2)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _FoodCard(
                          food: filteredProducts[i],
                          onAddTap: () {},
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: i + 1 < filteredProducts.length
                            ? _FoodCard(
                                food: filteredProducts[i + 1],
                                onAddTap: () {},
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onAddTap;

  const _FoodCard({required this.food, required this.onAddTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(

                          onTap: () {
  context.push(
    Uri(
      path: '/food',
      queryParameters: {
        'name': food.name,
      },
    ).toString(),
    extra: food,
  );
},
child:       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xff98A8B8),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            food.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            food.restaurantName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff646982),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${food.price}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff32343E),
                ),
              ),
              GestureDetector(
                onTap: onAddTap,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: const Color(0xffF58D1D),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),


      )
      

    );
  }
}