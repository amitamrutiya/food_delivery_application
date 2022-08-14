class RecommendedProduct {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  List<RecommendedProductModel>? _products;
List<RecommendedProductModel> get products => _products as List<RecommendedProductModel>;
  RecommendedProduct(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    _totalSize = totalSize;
    _offset = offset;
    _products = products;
    _typeId = typeId;
  }

  RecommendedProduct.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['_offset'];
    if (json['products'] != null) {
      _products = <RecommendedProductModel>[];
      json['products'].forEach((v) {
        _products!.add(new RecommendedProductModel.fromJson(v));
      });
    }
  }
}

class RecommendedProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  RecommendedProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  RecommendedProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }
}
