class ClothModel {
  String? id;
  String sellerID;
  String name;
  String description;
  String category;
  String fit;
  Map<String, dynamic> size;
  Map<String, dynamic> reservableCount;
  List images;
  Map<String, dynamic> reservedCount;
  Map<String, dynamic> soldCount;
  String brand;
  String material;
  int price;
  String tags;
  String metaTitle;
  String metaDescription;
  DateTime date;

  ClothModel(
      {this.id,
      required this.sellerID,
      required this.name,
      required this.description,
      required this.category,
      required this.reservableCount,
      required this.fit,
      required this.size,
      required this.images,
      this.reservedCount = const {},
      this.soldCount = const {},
      required this.brand,
      required this.material,
      required this.price,
      required this.tags,
      required this.metaTitle,
      required this.metaDescription,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'sellerID': sellerID,
      'name': name,
      'description': description,
      'category': category,
      'fit': fit,
      'size': size,
      'images': images,
      'reservedCount': reservedCount,
      'reservableCount':reservableCount,
      'soldCount': soldCount,
      'brand': brand,
      'material': material,
      'price': price,
      'tags': tags,
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
    };
  }

  factory ClothModel.fromJson(Map<String, dynamic> map, String id) {
    return ClothModel(
        id: id,
        sellerID: map['sellerID'],
        reservableCount: map['reservableCount'],
        name: map['name'],
        brand: map['brand'],
        category: map['category'],
        description: map['description'],
        fit: map['fit'],
        images: map['images'],
        material: map['material'],
        metaDescription: map['metaDescription'],
        metaTitle: map['metaTitle'],
        price: map['price'],
        size: map['size'],
        tags: map['tags'],
        reservedCount: map['reservedCount'],
        soldCount: map['soldCount'],
        date:map['date'].toDate()
        );
  }
}
