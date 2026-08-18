class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String restaurantName;
  final String category;       // Burgers, Pizza, Asian & Sushi, Breakfast & Coffee, Chicken
  final double rating;         // Например, 4.8
  final int reviewsCount;      // Количество отзывов
  final String deliveryTime;   // '10-15 min', '20-30 min'
  final String priceCategory;  // '$', '$$', '$$$'
  final bool isDelivery;
  final bool isPickUp;
  final bool hasOffer;         // Акция / Скидка
  final bool isOnlinePayment;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.restaurantName,
    required this.category,
    required this.rating,
    required this.reviewsCount,
    required this.deliveryTime,
    required this.priceCategory,
    this.isDelivery = true,
    this.isPickUp = true,
    this.hasOffer = false,
    this.isOnlinePayment = true,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      restaurantName: json['restaurant_name'] as String,
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviews_count'] as int,
      deliveryTime: json['delivery_time'] as String,
      priceCategory: json['price_category'] as String,
      isDelivery: json['is_delivery'] ?? true,
      isPickUp: json['is_pick_up'] ?? true,
      hasOffer: json['has_offer'] ?? false,
      isOnlinePayment: json['is_online_payment'] ?? true,
    );
  }
}

class FoodService {
  static final List<Map<String, dynamic>> _rawFoodData = [
    {
      'id': '101',
      'name': 'Чизбургер Гранд',
      'description': 'Сочная говяжья котлета, двойной сыр чеддер, маринованные огурчики и фирменный соус.',
      'price': 8.99,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Burgers',
      'rating': 4.8,
      'reviews_count': 1240,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '102',
      'name': 'Воппер с беконом',
      'description': 'Булка с кунжутом, приготовленная на огне 100% говядина, хрустящий бекон и свежие томаты.',
      'price': 11.50,
      'restaurant_name': 'Burger King',
      'category': 'Burgers',
      'rating': 4.6,
      'reviews_count': 890,
      'delivery_time': '20-30 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '103',
      'name': 'Трюфельный Блэк Бургер',
      'description': 'Мраморная говядина Black Angus, трюфельный майонез, карамелизованный лук и сыр Бри.',
      'price': 17.80,
      'restaurant_name': 'Farш',
      'category': 'Burgers',
      'rating': 4.9,
      'reviews_count': 420,
      'delivery_time': '30+ min',
      'price_category': '\$\$\$',
      'has_offer': false,
    },

    // --- 2. ПИЦЦА (Pizza) ---
    {
      'id': '201',
      'name': 'Пепперони Фреш',
      'description': 'Пикантная пепперони, увеличенная порция моцареллы, томаты и фирменный томатный соус.',
      'price': 14.99,
      'restaurant_name': 'Додо Пицца',
      'category': 'Pizza',
      'rating': 4.9,
      'reviews_count': 2100,
      'delivery_time': '20-30 min',
      'price_category': '\$\$',
      'has_offer': true,
    },
    {
      'id': '202',
      'name': 'Четыре Сыра Premium',
      'description': 'Сырный соус, моцарелла, смесь сыров чеддер, пармезан и сыр с голубой плесенью.',
      'price': 18.20,
      'restaurant_name': 'Papa John\'s',
      'category': 'Pizza',
      'rating': 4.7,
      'reviews_count': 650,
      'delivery_time': '30+ min',
      'price_category': '\$\$\$',
      'has_offer': false,
    },
    {
      'id': '203',
      'name': 'Маргарита Неаполитана',
      'description': 'Традиционное пышное тесто, томатный соус San Marzano, свежая моцарелла Di Bufala и базилик.',
      'price': 12.00,
      'restaurant_name': 'Pizza 22 см',
      'category': 'Pizza',
      'rating': 4.8,
      'reviews_count': 1120,
      'delivery_time': '15-25 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- 3. СУШИ И АЗИЯ (Asian & Sushi) ---
    {
      'id': '301',
      'name': 'Филадельфия XL',
      'description': 'Свежий лосось, сливочный сыр, огурец, рис для суши и нори. 8 больших кусочков.',
      'price': 16.50,
      'restaurant_name': 'Много Лосося',
      'category': 'Asian & Sushi',
      'rating': 4.9,
      'reviews_count': 3400,
      'delivery_time': '20-30 min',
      'price_category': '\$\$',
      'has_offer': true,
    },
    {
      'id': '302',
      'name': 'Том Ям с креветками',
      'description': 'Остро-кислый суп на кокосовом молоке с тигровыми креветками, грибами цаогу, черри и кинзой.',
      'price': 13.90,
      'restaurant_name': 'Jappan Ramen Bar',
      'category': 'Asian & Sushi',
      'rating': 4.7,
      'reviews_count': 530,
      'delivery_time': '30+ min',
      'price_category': '\$\$',
      'has_offer': false,
    },
    {
      'id': '303',
      'name': 'Запеченный сет "Сакура"',
      'description': '24 кусочка: запеченный ролл с угрем, ролл с крабом под спайси соусом и суши со спайси лососем.',
      'price': 24.99,
      'restaurant_name': 'Якитория',
      'category': 'Asian & Sushi',
      'rating': 4.6,
      'reviews_count': 1890,
      'delivery_time': '30+ min',
      'price_category': '\$\$\$',
      'has_offer': true,
    },

    // --- 4. ЗАВТРАКИ И КОФЕ (Breakfast & Coffee) ---
    {
      'id': '401',
      'name': 'Капучино Grand + Синнабон',
      'description': 'Ароматный эспрессо с пышной молочной пеной и свежеиспеченная булочка с корицей.',
      'price': 6.80,
      'restaurant_name': 'Кофемания',
      'category': 'Breakfast & Coffee',
      'rating': 4.9,
      'reviews_count': 1800,
      'delivery_time': '10-15 min',
      'price_category': '\$\$\$',
      'has_offer': false,
    },
    {
      'id': '402',
      'name': 'Скрембл с авокадо и лососем',
      'description': 'Нежная яичница-скрембл на ремесленном бриоше с слабосоленым лососем и спелым авокадо.',
      'price': 12.40,
      'restaurant_name': 'Азбука Вкуса Экспресс',
      'category': 'Breakfast & Coffee',
      'rating': 4.7,
      'reviews_count': 310,
      'delivery_time': '15-20 min',
      'price_category': '\$\$\$',
      'has_offer': true,
    },
    {
      'id': '403',
      'name': 'Сырники со сметаной и джемом',
      'description': '3 домашние сырники из фермерского творога со свежей сметаной и малиновым конфитюром.',
      'price': 5.50,
      'restaurant_name': 'Шоколадница',
      'category': 'Breakfast & Coffee',
      'rating': 4.5,
      'reviews_count': 940,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },

    // --- 5. КУРИЦА И КРИСПИ (Chicken) ---
    {
      'id': '501',
      'name': 'Баскет Дуэт Острый',
      'description': '4 острых крылышка, 4 стрипса, 2 куриные голени и две порции картофеля фри.',
      'price': 15.90,
      'restaurant_name': 'Rostic\'s',
      'category': 'Chicken',
      'rating': 4.6,
      'reviews_count': 1520,
      'delivery_time': '15-25 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '502',
      'name': 'Чикен Наггетс (12 шт)',
      'description': 'Хрустящие кусочки сочного куриного филе в панировке соуса на выбор.',
      'price': 6.20,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Chicken',
      'rating': 4.8,
      'reviews_count': 2300,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '503',
      'name': 'Куриные крылышки Buffalo',
      'description': 'Сочные крылья в оригинальном остро-сладком соусе Баффало с соусом Блю Чиз.',
      'price': 11.00,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Chicken',
      'rating': 4.7,
      'reviews_count': 410,
      'delivery_time': '20-30 min',
      'price_category': '\$\$',
      'has_offer': true,
    },
  ];

  Future<List<FoodItem>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 400)); 
    return _rawFoodData.map((e) => FoodItem.fromJson(e)).toList();
  }

  Future<List<FoodItem>> getProductsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final items = _rawFoodData.map((e) => FoodItem.fromJson(e)).toList();
    if (category == 'All') return items;
    return items.where((item) => item.category == category).toList();
  }

  Future<List<FoodItem>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final items = _rawFoodData.map((e) => FoodItem.fromJson(e)).toList();
    return items.where((item) {
      final nameLower = item.name.toLowerCase();
      final restLower = item.restaurantName.toLowerCase();
      final q = query.toLowerCase();
      return nameLower.contains(q) || restLower.contains(q);
    }).toList();
  }
  static List<String> getCategories() {
  // Собираем все категории из raw-данных и убираем дубликаты
  final categories = _rawFoodData
      .map((e) => e['category'] as String)
      .toSet()
      .toList();
  
  // В начало добавляем 'All' для сброса фильтра
  return ['All', ...categories];
}
// В food_services.dart, рядом с getProductsByCategory
Future<List<FoodItem>> getProductsByRestaurant(String restaurantName) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final items = _rawFoodData.map((e) => FoodItem.fromJson(e)).toList();
    if (restaurantName == 'All') return items;
    return items.where((item) => item.restaurantName == restaurantName).toList();
  }

  static List<String> getRestaurants() {
    final restaurants = _rawFoodData
        .map((e) => e['restaurant_name'] as String)
        .toSet()
        .toList();
    return ['All', ...restaurants];
  }
}
