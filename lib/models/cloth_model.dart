
class ClothModel {
  String? id;
  String sellerID;
   String name;
   String description;
   String category;
   String fit;
   Map<String,dynamic> size;
   List images;
    Map<String,dynamic> reservedCount;
   Map<String, dynamic> soldCount ;
   String brand;
   String material;
   int price;
   String tags;
   String metaTitle;
   String metaDescription;
  

  ClothModel(
      {
      this.id,
        required this.sellerID,
        required this.name,
      required this.description,
      required this.category,
      required this.fit,
      required this.size,
      required this.images,
      this.reservedCount =const{},
      this.soldCount = const{},
      required this.brand,
      required this.material,
      required this.price,
      required this.tags,
      required this.metaTitle,
      required this.metaDescription,});

  Map<String, dynamic> toMap() {
    return {
      'sellerID':sellerID,
      'name': name,
      'description': description,
      'category': category,
      'fit': fit,
      'size': size,
      'images': images,
      'reservedCount': reservedCount,
      'soldCount': soldCount,
      'brand': brand,
      'material': material,
      'price': price,
      'tags': tags,
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
    };
  }

  factory ClothModel.fromJson(Map<String, dynamic> map,String id) {

    return ClothModel(
      id:id,
      sellerID: map['sellerID'],
        name: map['name'],
        brand: map['brand'],
        category: map['category'],
        description: map['description'],
        fit: map['fit'],
        images: map['images'] ,
        material: map['material'],
        metaDescription: map['metaDescription'],
        metaTitle: map['metaTitle'],
        price: map['price'],
        size: map['size'],
        tags: map['tags'],
        reservedCount: map['reservedCount'],
        soldCount: map['soldCount']);
  }
}
