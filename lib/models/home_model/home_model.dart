class HomeModel {
    late bool status;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((value) {
      banners.add(BannersModel.fromJson(value));
    });
    json['products'].forEach((value) {
      products.add(ProductsModel.fromJson(value));
    });
  }
}

class BannersModel {
   late int id;
  late String image;
  // ProductsModel? category;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    // category = ProductsModel.fromJson(json['category']);
  }
}

class ProductsModel {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;

  late String image;
  late String name;
  late bool isFavorites;
  bool? isCart;
  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];

    discount = json['discount'];

    image = json['image'];
    name = json['name'];
    isFavorites = json['in_favorites'];
    isCart = json['in_cart'];
  }
}
