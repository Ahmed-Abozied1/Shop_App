
class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic currentPage;
  List<Product> data = [];

  dynamic from;
  dynamic lastPage;

  String? path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Data.fromJson(Map<dynamic, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];

      json['data'].forEach((element) {
        data.add(Product.fromJson(element));
      });
    }

    from = json['from'];

    lastPage = json['last_page'];

    path = json['path'];

    perPage = json['per_page'];

    to = json['to'];

    total = json['total'];
  }
}



class Product {
  dynamic id;

  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    price = json['price'];

    oldPrice = json['old_price'];

    discount = json['discount'];

    image = json['image'];

    name = json['name'];

    description = json['description'];
  }
}