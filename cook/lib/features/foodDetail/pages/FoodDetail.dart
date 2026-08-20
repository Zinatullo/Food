import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodDetail extends StatefulWidget {
  final FoodItem item;
  final String foodName;
  const FoodDetail({super.key, required this.foodName, required this.item});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  bool isLiked = false;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
                    decoration: BoxDecoration(
                      color: Color(0xffECF0F4),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xff181C2E),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Detail',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 184,
                  decoration: BoxDecoration(
                    color: const Color(0xff98A8B8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    icon: Container(
                      width: 37,
                      height: 37,

                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),  
            SizedBox(height: 24,),

            Container(
              height: 47,
              padding: EdgeInsets.symmetric(horizontal: 20,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Color(0xffE9E9E9)),
              ),
              child: Row(
                children: [
                  Image.asset('assets/icons/RestaurantIcon.png'),
                  SizedBox(width: 12,),
                  Text(widget.item.restaurantName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(widget.item.name,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),SizedBox(height: 7,),
            Text(widget.item.description,style: TextStyle(fontSize: 14,color: Color(0xffA0A5BA)),)
          ,SizedBox(height: 20,),
                    Row(
            children: [
              const Icon(
                Icons.star_border_rounded,
                color: Color(0xFFFF7622),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                '${widget.item.rating}'.toString(),
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
                '${widget.item.isDelivery}'== true ? 'Free' : 'Paid',
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
                widget.item.deliveryTime,
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
      ),

      // --- НИЖНЯЯ ПЛАШКА С ЦЕНОЙ И СЧЁТЧИКОМ (прибита к низу, во всю ширину) ---
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xffF0F5FA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${(widget.item.price * (quantity == 0 ? 1 : quantity)).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                    ),
                  ),
                  if (quantity > 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xff121223),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity--;
                              });
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    quantity++;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added ${quantity == 0 ? 1 : quantity} x ${widget.item.name} to cart'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Color(0xffFF7622),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}