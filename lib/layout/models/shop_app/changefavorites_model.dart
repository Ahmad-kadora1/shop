// import 'dart:async';

class ChangeFavoritesModel {
  bool? status;
  String? message;
  FavoritesData? data;

  //Favorites({this.status, this.message, this.data});

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavoritesData.fromJson(json['data']) : null;
    // ignore: avoid_print
    print(data.toString());
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class FavoritesData {
  DataProductsModel? dataProducts;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    dataProducts = DataProductsModel.fromJosn(json['product']);
  }
}

class DataProductsModel {
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  DataProductsModel.fromJosn(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json[' discount'];
    image = json['image'];
    // name = json['name'];
    // inFavorites = json['in_favorites'];
    // inCart = json['in_cart'];
  }
}
