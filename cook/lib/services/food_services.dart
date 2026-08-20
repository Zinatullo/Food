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
    // ======== РЕСТОРАН 1: Кофемания ========
    // --- Category: Burgers (2) ---
    {
      'id': '501',
      'name': 'Чизбургер Сытный',
      'description': 'Говяжий отборный язык, мордовский сыр, свежие огурцы, карамелизованный лук и фирменный соус.',
      'price': 12.99,
      'restaurant_name': 'Кофемания',
      'category': 'Burgers',
      'rating': 4.7,
      'reviews_count': 850,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '501_2',
      'name': 'Двойной Чизбургер Сытный',
      'description': 'Двойная порция говядины, расплавленный чеддер, маринованный лук и фирменный барбекю соус.',
      'price': 15.99,
      'restaurant_name': 'Кофемания',
      'category': 'Burgers',
      'rating': 4.8,
      'reviews_count': 420,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': false,
    },

    // --- Category: Pizza (2) ---
    {
      'id': '502',
      'name': 'Пицца Маргарита Премиум',
      'description': 'Свежий томатный соус, нежная моцарелла, базилик и оливковое масло на хрустящей корочке.',
      'price': 13.50,
      'restaurant_name': 'Кофемания',
      'category': 'Pizza',
      'rating': 4.5,
      'reviews_count': 640,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '502_2',
      'name': 'Пицца Пепперони Итальяно',
      'description': 'Пикантная пепперони, увеличение порции моцареллы, томатный соус и орегано.',
      'price': 14.99,
      'restaurant_name': 'Кофемания',
      'category': 'Pizza',
      'rating': 4.7,
      'reviews_count': 810,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- Category: Asian & Sushi (2) ---
    {
      'id': '503',
      'name': 'Ролл Спайси Тунцом',
      'description': 'Прямой соус с кунжутом, свежий тунец, острый перец чипотле и маринованный имбирь.',
      'price': 9.99,
      'restaurant_name': 'Кофемания',
      'category': 'Asian & Sushi',
      'rating': 4.6,
      'reviews_count': 430,
      'delivery_time': '10-15 min',
      'price_category': '\$\$',
      'has_offer': false,
    },
    {
      'id': '503_2',
      'name': 'Ролл Филадельфия с Лососем',
      'description': 'Нежный сливочный сыр, авокадо, огурец и свежий атлантический лосось.',
      'price': 12.50,
      'restaurant_name': 'Кофемания',
      'category': 'Asian & Sushi',
      'rating': 4.9,
      'reviews_count': 950,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- Category: Breakfast & Coffee (2) ---
    {
      'id': '504',
      'name': 'Завтрак Брюслион',
      'description': 'Три варёных яйца, копчёные беконы, домашний тост с авокадо и свежецедленый лимон.',
      'price': 11.99,
      'restaurant_name': 'Кофемания',
      'category': 'Breakfast & Coffee',
      'rating': 4.4,
      'reviews_count': 720,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '504_2',
      'name': 'Овсяная Каша с Ягодами и Кофе',
      'description': 'Нежная овсяная каша на миндальном молоке с черникой, малиной и чашкой американо.',
      'price': 8.50,
      'restaurant_name': 'Кофемания',
      'category': 'Breakfast & Coffee',
      'rating': 4.6,
      'reviews_count': 380,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },

    // --- Category: Chicken (2) ---
    {
      'id': '505',
      'name': 'Куриные Наггетс Соус Айсберг',
      'description': 'Хрустящие кусочки сочного куриного филе в панировке с соусом Айсберг и заправкой.',
      'price': 7.50,
      'restaurant_name': 'Кофемания',
      'category': 'Chicken',
      'rating': 4.3,
      'reviews_count': 980,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '505_2',
      'name': 'Куриные Стрипсы XL',
      'description': 'Крупные кусочки куриного филе в хрустящей панировке с чесночно-сливочным соусом.',
      'price': 9.20,
      'restaurant_name': 'Кофемания',
      'category': 'Chicken',
      'rating': 4.6,
      'reviews_count': 540,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },

    // ======== РЕСТОРАН 2: Вкусно & Точка ========
    // --- Category: Burgers (2) ---
    {
      'id': '506',
      'name': 'Супер Бургер Премиум',
      'description': 'Мраморная говядина Черного ТЛК, сыр Чеддер, карамелизованный лук, свежие огурцы и фирменный соус.',
      'price': 14.99,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Burgers',
      'rating': 4.8,
      'reviews_count': 1240,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '506_2',
      'name': 'Двойной Супер Бургер',
      'description': 'Две котлеты из мраморной говядины, двойной сыр Чеддер, бекон и соус гриль.',
      'price': 17.50,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Burgers',
      'rating': 4.9,
      'reviews_count': 890,
      'delivery_time': '10-15 min',
      'price_category': '\$\$',
      'has_offer': false,
    },

    // --- Category: Pizza (2) ---
    {
      'id': '507',
      'name': 'Пицца Острая Пепперони Премиум',
      'description': 'Пикантная пепперони, увеличенная порция моцареллы, свежие томаты и острый соус Чили.',
      'price': 15.99,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Pizza',
      'rating': 4.6,
      'reviews_count': 1100,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': false,
    },
    {
      'id': '507_2',
      'name': 'Пицца Ветчина и Грибы',
      'description': 'Сочная ветчина, шампиньоны, моцарелла и фирменный соус на пышном тесте.',
      'price': 14.20,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Pizza',
      'rating': 4.5,
      'reviews_count': 760,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': true,
    },

    // --- Category: Asian & Sushi (2) ---
    {
      'id': '508',
      'name': 'Ролл Тунец и Авокадо',
      'description': 'Свежий тунец, авокадо, морковь и кунжутный соус с рисом для суши и нори.',
      'price': 8.50,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Asian & Sushi',
      'rating': 4.5,
      'reviews_count': 560,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '508_2',
      'name': 'Запеченный Ролл с Угрем',
      'description': 'Угорь, сливочный сыр, огурец, запеченная шапочка из спайси соуса и унаги.',
      'price': 11.99,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Asian & Sushi',
      'rating': 4.8,
      'reviews_count': 640,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- Category: Breakfast & Coffee (2) ---
    {
      'id': '509',
      'name': 'Кофе Латте с Карамелью',
      'description': 'Нежное молочное латте с карамельным сиропом, топпингом карамели и ванильным ароматом.',
      'price': 4.99,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Breakfast & Coffee',
      'rating': 4.7,
      'reviews_count': 1500,
      'delivery_time': '5-10 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '509_2',
      'name': 'Капучино Гранде и Круассан',
      'description': 'Большая порция капучино с пышной пенкой и свежий френч-круассан с шоко-начинкой.',
      'price': 6.80,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Breakfast & Coffee',
      'rating': 4.8,
      'reviews_count': 910,
      'delivery_time': '5-10 min',
      'price_category': '\$',
      'has_offer': false,
    },

    // --- Category: Chicken (2) ---
    {
      'id': '510',
      'name': 'Куриные Крылышки Барбекю',
      'description': 'Сочные куриные крылышки в дымном соусе барбекю с домашней заправкой и картофелем фри.',
      'price': 9.99,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Chicken',
      'rating': 4.6,
      'reviews_count': 1350,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '510_2',
      'name': 'Острый Баскет Крыльев',
      'description': 'Большая порция куриных крыльев в хрустящей острой панировке с сырным соусом.',
      'price': 13.99,
      'restaurant_name': 'Вкусно & Точка',
      'category': 'Chicken',
      'rating': 4.7,
      'reviews_count': 1120,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // ======== РЕСТОРАН 3: Додо Пицца ========
    // --- Category: Burgers (2) ---
    {
      'id': '511',
      'name': 'Бургер Додо Спешиал',
      'description': 'Двойной сыр Чеддер, говяжий отбивной стейк, карамелизованный лук и секретный соус Додо.',
      'price': 13.50,
      'restaurant_name': 'Додо Пицца',
      'category': 'Burgers',
      'rating': 4.4,
      'reviews_count': 670,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '511_2',
      'name': 'Додо Чизбургер Гриль',
      'description': 'Сочная сочная говяжья котлета, томаты, соленый огурец, сыр и фирменный соус.',
      'price': 12.80,
      'restaurant_name': 'Додо Пицца',
      'category': 'Burgers',
      'rating': 4.5,
      'reviews_count': 410,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': true,
    },

    // --- Category: Pizza (2) ---
    {
      'id': '512',
      'name': 'Пицца Додо Четыре Сыра',
      'description': 'Моцарелла, Пармезан, Гауа и Чеддер на хрустящем тесте с ореховым соусом.',
      'price': 17.99,
      'restaurant_name': 'Додо Пицца',
      'category': 'Pizza',
      'rating': 4.8,
      'reviews_count': 1320,
      'delivery_time': '20-25 min',
      'price_category': '\$\$',
      'has_offer': true,
    },
    {
      'id': '512_2',
      'name': 'Пицца Додо Мясная',
      'description': 'Цыпленок, ветчина, пепперони, острая chorizo, моцарелла и фирменный соус.',
      'price': 18.50,
      'restaurant_name': 'Додо Пицца',
      'category': 'Pizza',
      'rating': 4.9,
      'reviews_count': 1580,
      'delivery_time': '20-25 min',
      'price_category': '\$\$',
      'has_offer': false,
    },

    // --- Category: Asian & Sushi (2) ---
    {
      'id': '513',
      'name': 'Ролл Филадельфия Додо',
      'description': 'Лосось, сливочный сыр Кремет, авокадо и икра с соусом умами на рисе для суши.',
      'price': 12.99,
      'restaurant_name': 'Додо Пицца',
      'category': 'Asian & Sushi',
      'rating': 4.7,
      'reviews_count': 780,
      'delivery_time': '20-25 min',
      'price_category': '\$\$',
      'has_offer': false,
    },
    {
      'id': '513_2',
      'name': 'Ролл Калифорния с Креветкой',
      'description': 'Тигровая креветка, авокадо, огурец, икра тобико и майонез в нори.',
      'price': 11.50,
      'restaurant_name': 'Додо Пицца',
      'category': 'Asian & Sushi',
      'rating': 4.6,
      'reviews_count': 530,
      'delivery_time': '20-25 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- Category: Breakfast & Coffee (2) ---
    {
      'id': '514',
      'name': 'Завтрак Додо Сытный',
      'description': 'Греческие овощи, варёные яйца, домашний хлеб с орехами и свежецедленый лимон.',
      'price': 8.99,
      'restaurant_name': 'Додо Пицца',
      'category': 'Breakfast & Coffee',
      'rating': 4.3,
      'reviews_count': 450,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '514_2',
      'name': 'Дэнвич с Ветчиной и Сыром',
      'description': 'Горячая запеченная лепешка с ветчиной, моцареллой и томатами + американо.',
      'price': 6.90,
      'restaurant_name': 'Додо Пицца',
      'category': 'Breakfast & Coffee',
      'rating': 4.7,
      'reviews_count': 820,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },

    // --- Category: Chicken (2) ---
    {
      'id': '515',
      'name': 'Куриные Стрипсы Соус Терияки',
      'description': 'Хрустящие стрипсы из куриного филе в сладко-солёном соусе Терияки с рисом и овощами.',
      'price': 8.50,
      'restaurant_name': 'Додо Пицца',
      'category': 'Chicken',
      'rating': 4.5,
      'reviews_count': 690,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '515_2',
      'name': 'Запеченные Крылышки Сладкий Чили',
      'description': 'Нежные куриные крылышки в сладко-остром соусе с кунжутной посыпкой.',
      'price': 9.20,
      'restaurant_name': 'Додо Пицца',
      'category': 'Chicken',
      'rating': 4.7,
      'reviews_count': 590,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },

    // ======== РЕСТОРАН 4: Шоколадница ========
    // --- Category: Burgers (2) ---
    {
      'id': '516',
      'name': 'Бургер Шоколадницы Острый',
      'description': 'Острая говяжья котлета с соусом Чипотле, свежий жалапенё, маринованный лук и пикантный соус.',
      'price': 11.99,
      'restaurant_name': 'Шоколадница',
      'category': 'Burgers',
      'rating': 4.3,
      'reviews_count': 520,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '516_2',
      'name': 'Бургер Бриошь с Индейкой',
      'description': 'Котлета из сочной индейки, пышная булочка бриошь, клюквенный соус и салат.',
      'price': 12.50,
      'restaurant_name': 'Шоколадница',
      'category': 'Burgers',
      'rating': 4.5,
      'reviews_count': 320,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- Category: Pizza (2) ---
    {
      'id': '517',
      'name': 'Пицца Мясная Монстр',
      'description': 'Пепперони, баварская колба, ветчина, бекон, говядина и сыр Моцарелла с томатным соусом.',
      'price': 19.99,
      'restaurant_name': 'Шоколадница',
      'category': 'Pizza',
      'rating': 4.7,
      'reviews_count': 980,
      'delivery_time': '25-30 min',
      'price_category': '\$\$',
      'has_offer': true,
    },
    {
      'id': '517_2',
      'name': 'Пицца Четыре Сезона',
      'description': 'Четыре секции: шампиньоны, пепперони, томаты с базиликом и ветчина с сыром.',
      'price': 16.99,
      'restaurant_name': 'Шоколадница',
      'category': 'Pizza',
      'rating': 4.6,
      'reviews_count': 710,
      'delivery_time': '20-25 min',
      'price_category': '\$\$',
      'has_offer': false,
    },

    // --- Category: Asian & Sushi (2) ---
    {
      'id': '518',
      'name': 'Ролл Вегги Гриль',
      'description': 'Сладкий перец, шпинат, морковь, авокадо и кунжут с соевым соусом и имбирным ароматом.',
      'price': 6.50,
      'restaurant_name': 'Шоколадница',
      'category': 'Asian & Sushi',
      'rating': 4.2,
      'reviews_count': 340,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '518_2',
      'name': 'Лапша Wok с Овощами',
      'description': 'Пшеничная лапша удон с обжаренными овощами, соусом соя-мирин и кунжутом.',
      'price': 8.99,
      'restaurant_name': 'Шоколадница',
      'category': 'Asian & Sushi',
      'rating': 4.4,
      'reviews_count': 480,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },

    // --- Category: Breakfast & Coffee (2) ---
    {
      'id': '519',
      'name': 'Классический Бенедикт',
      'description': 'Два яйца вареджина, варёные яичные желтки, варёный тост с авокадо и соус Бенедикт.',
      'price': 9.99,
      'restaurant_name': 'Шоколадница',
      'category': 'Breakfast & Coffee',
      'rating': 4.6,
      'reviews_count': 820,
      'delivery_time': '10-15 min',
      'price_category': '\$\$',
      'has_offer': false,
    },
    {
      'id': '519_2',
      'name': 'Сырники со Сметаной и Джемом',
      'description': 'Три нежных творожных сырника со свежей сметаной и ягодным топпингом.',
      'price': 7.50,
      'restaurant_name': 'Шоколадница',
      'category': 'Breakfast & Coffee',
      'rating': 4.8,
      'reviews_count': 1400,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },

    // --- Category: Chicken (2) ---
    {
      'id': '520',
      'name': 'Куриные Ножки Острые',
      'description': 'Хрустящие острые куриные ножки с соусом Чипотле и домашней заправкой из картофеля фри.',
      'price': 8.99,
      'restaurant_name': 'Шоколадница',
      'category': 'Chicken',
      'rating': 4.5,
      'reviews_count': 680,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '520_2',
      'name': 'Куриный Шницель с Зеленью',
      'description': 'Отбивная куриная грудка в хрустящей панировке со свежим салатом и лимоном.',
      'price': 10.50,
      'restaurant_name': 'Шоколадница',
      'category': 'Chicken',
      'rating': 4.6,
      'reviews_count': 510,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // ======== РЕСТОРАН 5: BBQ Chicken ========
    // --- Category: Burgers (2) ---
    {
      'id': '521',
      'name': 'Вегетарианский Бургер Сытный',
      'description': 'Домашняя вегетарианская котлета из чечевицы и овощей, авокадо, свежие томаты и салат Эндиво.',
      'price': 9.50,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Burgers',
      'rating': 4.2,
      'reviews_count': 410,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '521_2',
      'name': 'Бургер BBQ Криспи Чикен',
      'description': 'Сочное куриное бедро в хрустящей панировке, соус Барбекю и маринованный огурчик.',
      'price': 10.99,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Burgers',
      'rating': 4.7,
      'reviews_count': 730,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': false,
    },

    // --- Category: Pizza (2) ---
    {
      'id': '522',
      'name': 'Пицца Вегетарианская Делуха',
      'description': 'Моцарелла, болгарский перец, цукини, шпинат, помидоры и орехи кедровые на деревянном жерне.',
      'price': 13.99,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Pizza',
      'rating': 4.4,
      'reviews_count': 520,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '522_2',
      'name': 'Пицца Цыпленок BBQ',
      'description': 'Куриное филе в соусе барбекю, красный лук, сыр Моцарелла и зелень.',
      'price': 14.80,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Pizza',
      'rating': 4.7,
      'reviews_count': 830,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- Category: Asian & Sushi (2) ---
    {
      'id': '523',
      'name': 'Ролл Калифорния Специал',
      'description': 'Рис для суши, крабовое мясо, авокадо, огурец и майонез с кунжутом и имбирным соусом.',
      'price': 7.99,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Asian & Sushi',
      'rating': 4.5,
      'reviews_count': 670,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': false,
    },
    {
      'id': '523_2',
      'name': 'Суп Том Ям с Курицей',
      'description': 'Остро-кислый тайский бульон, куриное филе, грибы цаогу, кокосовое молоко и кинза.',
      'price': 9.99,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Asian & Sushi',
      'rating': 4.7,
      'reviews_count': 610,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': true,
    },

    // --- Category: Breakfast & Coffee (2) ---
    {
      'id': '524',
      'name': 'Американский Большой Брекфаст',
      'description': 'Три варёных яйца, домашний бекон, сосиски, жареный хлеб с джемом и сладкий картофель.',
      'price': 12.99,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Breakfast & Coffee',
      'rating': 4.5,
      'reviews_count': 760,
      'delivery_time': '15-20 min',
      'price_category': '\$\$',
      'has_offer': false,
    },
    {
      'id': '524_2',
      'name': 'Панкейки с Медом и Ягодами',
      'description': 'Пышные оладьи с натуральным медом, свежей голубикой и взбитыми сливками.',
      'price': 8.50,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Breakfast & Coffee',
      'rating': 4.8,
      'reviews_count': 1050,
      'delivery_time': '10-15 min',
      'price_category': '\$',
      'has_offer': true,
    },

    // --- Category: Chicken (2) ---
    {
      'id': '525',
      'name': 'Куриные Крылышки Медово-Соевые',
      'description': 'Сочные крылышки в медово-соевом глазури с кунжутом и домашней заправкой из картофеля фри.',
      'price': 7.99,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Chicken',
      'rating': 4.8,
      'reviews_count': 1100,
      'delivery_time': '15-20 min',
      'price_category': '\$',
      'has_offer': true,
    },
    {
      'id': '525_2',
      'name': 'Баскет Цыпленок BBQ',
      'description': 'Большая порция кусочков курицы, запеченных в фирменном соусе BBQ со специями.',
      'price': 15.99,
      'restaurant_name': 'BBQ Chicken',
      'category': 'Chicken',
      'rating': 4.9,
      'reviews_count': 1420,
      'delivery_time': '20-25 min',
      'price_category': '\$\$',
      'has_offer': false,
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
    final categories = _rawFoodData
        .map((e) => e['category'] as String)
        .toSet()
        .toList();

    return ['All', ...categories];
  }

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

 