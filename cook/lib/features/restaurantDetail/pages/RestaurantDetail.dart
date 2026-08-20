import 'package:cook/features/restaurantDetail/widgets/RestaurantDetailCategory.dart';
import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Restaurantdetail extends StatefulWidget {
  final FoodItem? item;
  final String restaurantName;

  const Restaurantdetail({
    super.key,
    required this.item,
    required this.restaurantName,
  });

  @override
  State<Restaurantdetail> createState() => _RestaurantdetailState();
}

class _RestaurantdetailState extends State<Restaurantdetail> {
  final FoodService _foodService = FoodService();
  late Future<List<FoodItem>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _foodService.getProductsByRestaurant(widget.restaurantName);
  }

  @override
  void didUpdateWidget(covariant Restaurantdetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.restaurantName != widget.restaurantName) {
      setState(() {
        _itemsFuture = _foodService.getProductsByRestaurant(widget.restaurantName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,

        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
children: [
              GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(color: Color(0xffECF0F4),
                  borderRadius: BorderRadius.circular(45)
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xff181C2E),
                ),
              ),
            ),
            SizedBox(width: 16),
            Text('Restaurant View', style: TextStyle(fontSize: 17)),
],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xffECF0F4),
                  borderRadius: BorderRadius.circular(45)
                ),
              child: Icon(
                Icons.more_horiz,

              ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(
            height: 24,
          )
          ,Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xff98A8B8),
                    borderRadius: BorderRadius.circular(30),


            ),
          ),
          SizedBox(height: 24,),
          Text(
            '${widget.item?.restaurantName}',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20
            ),
            
          ),
          SizedBox(height: 6,),
          Text(
            '${widget.item?.description}',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xffA0A5BA)
            ),
          ),
          SizedBox(height: 22,),





          
          Row(
            children: [
              const Icon(
                Icons.star_border_rounded,
                color: Color(0xFFFF7622),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                '${widget.item?.rating}'.toString(),
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
                // ignore: unrelated_type_equality_checks
                '${widget.item?.isDelivery}'== true ? 'Free' : 'Paid',
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
                '${widget.item?.deliveryTime}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF181C2E),
                ),
              ),
            ],
          ),
      SizedBox(height: 30,),
        FutureBuilder<List<FoodItem>>(
          future: _itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const SizedBox.shrink();
            }
            final items = snapshot.data!;
            return RestaurantDetailCategory(
              allRestaurantItems: items,
              currentItem: widget.item!,
            );
          },
        )
        ],

      ),
      ),
    );
  }
}