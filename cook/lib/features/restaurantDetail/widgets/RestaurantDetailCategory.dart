import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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

        // --- СПИСОК ТОВАРОВ ---
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final food = filteredProducts[index];

            return ListTile(
              title: Text(food.name),
              subtitle: Text(food.description, maxLines: 1),
              trailing: Text(
                '\$${food.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF68A1E),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}