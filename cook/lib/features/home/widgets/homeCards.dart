import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Homecards extends StatefulWidget {
  final List<FoodItem> products;

  const Homecards({super.key, required this.products});

  @override
  State<Homecards> createState() => _HomecardsState();
}

class _HomecardsState extends State<Homecards> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final item = widget.products[index];
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: HomeCard(item: item),
          );
        },
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final FoodItem item;

  const HomeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/category?name=${Uri.encodeComponent(item.category)}');
        
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 55,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Container(
              width: 96,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF98A8B8),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item.category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF32343E),
            ),
          ),
        ],
      ),
    );
  }
}