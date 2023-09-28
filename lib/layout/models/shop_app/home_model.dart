class ShopHomeModel {
  bool? status;
  HomeDataModel? data;

  ShopHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<DataBannersModel>? banners = [];
  List<DataProductsModel>? products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    //  banners = <DataBannersModel>[];
    json['banners'].forEach((elements) {
      banners?.add(DataBannersModel.fromJson(elements));
    });

    json['products'].forEach((elements) {
      products?.add(DataProductsModel.fromJosn(elements));
    });
  }
}

class DataBannersModel {
  int? id;
  String? image;

  DataBannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
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
