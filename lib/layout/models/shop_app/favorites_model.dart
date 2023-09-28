class Favorites {
  bool? status;
  String? message;
  FavoritesData? data;

  //Favorites({this.status, this.message, this.data});

  Favorites.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavoritesData.fromJson(json['data']) : null;
  }
}

class FavoritesData {
  int? currentPage;

  String? firstPageUrl;
  // Null? from;
  int? lastPage;
  String? lastPageUrl;
  // Null? nextPageUrl;
  String? path;
  int? perPage;
  // Null? prevPageUrl;
  // Null? to;
  int? total;

  List<DataProductsModel>? dataProducts = [];
  FavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    // if (json['data'] != null)

    // data = <Null>[];
    json['data'].forEach((v) {
      dataProducts?.add(DataProductsModel.fromJosn(v['product']));
    });

    firstPageUrl = json['first_page_url'];
    // from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    // nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    // to = json['to'];
    total = json['total'];
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
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
