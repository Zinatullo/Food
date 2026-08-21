import 'package:cook/features/home/widgets/restaurantHomeCard.dart';
import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Restaurantpage extends StatefulWidget {
  final String restaurantName;
  final FoodItem? item;

  const Restaurantpage({super.key, required this.restaurantName, this.item});

  @override
  State<Restaurantpage> createState() => _RestaurantpageState();
}

class _RestaurantpageState extends State<Restaurantpage> {
  final FoodService _foodService = FoodService();
  late Future<List<FoodItem>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _foodService.getProductsByRestaurant(widget.restaurantName);
  }

  @override
  void didUpdateWidget(covariant Restaurantpage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.restaurantName != widget.restaurantName) {
      setState(() {
        _itemsFuture = _foodService.getProductsByRestaurant(widget.restaurantName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> restaurants = FoodService.getRestaurants();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push('/home');
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: const Color(0xffECF0F4),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 17),

                PopupMenuButton<String>(
                  initialValue: widget.restaurantName,
                  onSelected: (String newRestaurant) {
                    if (newRestaurant == widget.restaurantName) return;

                    context.pushReplacement(
                      '/restaurants?name=${Uri.encodeComponent(newRestaurant)}',
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (BuildContext context) {
                    return restaurants.map((String rest) {
                      return PopupMenuItem<String>(
                        value: rest,
                        child: Text(
                          rest,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: rest == widget.restaurantName
                                ? FontWeight.w700
                                : FontWeight.normal,
                            color: rest == widget.restaurantName
                                ? const Color(0xffF58D1D)
                                : Colors.black,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffECF0F4),
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.restaurantName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xffF58D1D),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push('/search');
                  },
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xff121223),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xffECF0F4),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Image.asset('assets/images/filtter-category.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<FoodItem>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Нет товаров у этого ресторана'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - 12) / 2;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: items.map((food) {
                        return Container(
                          width: itemWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 15,
                                offset: const Offset(2, 9),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child:GestureDetector(

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
child:                              Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 84,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff98A8B8),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  food.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  food.restaurantName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xff646982),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${food.price}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff32343E),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF58D1D),
                                          borderRadius: BorderRadius.circular(45),
                                        ),
                                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            )
                            



                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Open Restaurants',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/rest');
                      },
                      child: const Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Icon(Icons.keyboard_arrow_right_sharp, color: Color(0xFFA0A5BA)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Builder(
                  builder: (context) {
                    final Map<String, FoodItem> uniqueByRestaurant = {
                      for (final food in items) food.restaurantName: food,
                    };
                    final restaurantCards = uniqueByRestaurant.values.toList();

                    if (restaurantCards.isEmpty) {
                      return const Text('Рестораны не найдены');
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurantCards.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: RestaurantHomeCard(item: restaurantCards[index]),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}