import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantHomeCard extends StatelessWidget {
  final FoodItem item;

  const RestaurantHomeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   context.push('/rest?name=${Uri.encodeComponent(item.restaurantName)}',extra: item);
      // },
      onTap: () {
  context.push(
    Uri(
      path: '/rest',
      queryParameters: {
        'name': item.restaurantName,
      },
    ).toString(),
    extra: item,
  );
},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFF98A8B8),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.restaurantName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF181C2E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.category,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA0A5BA),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.star_border_rounded,
                color: Color(0xFFFF7622),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                item.rating.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF181C2E),
                ),
              ),
              const SizedBox(width: 24),
              const Icon(
                Icons.local_shipping_outlined,
                color: Color(0xFFFF7622),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                item.isDelivery ? 'Free' : 'Paid',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF181C2E),
                ),
              ),
              const SizedBox(width: 24),
              const Icon(
                Icons.access_time_rounded,
                color: Color(0xFFFF7622),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                item.deliveryTime,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF181C2E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}