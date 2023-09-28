// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/models/shop_app/categories_model.dart';
import 'package:shop/layout/models/shop_app/favorites_model.dart';
import 'package:shop/layout/models/shop_app/home_model.dart';
import 'package:shop/layout/models/shop_app/login_model.dart';
import 'package:shop/layout/modules/shop_app/setting/setting_screen.dart';
import 'package:shop/layout/shared/componants/constans.dart';
import 'package:shop/layout/shared/network/end_piont.dart';
import 'package:shop/layout/shared/network/remode/dio_halper.dart';
import 'package:shop/layout/shop_app/shop_cubit/cubit/states.dart';

import '../../../models/shop_app/changefavorites_model.dart';
import '../../../modules/shop_app/catecogries/catecogries_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/prodducts/products_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'caterogies'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'favorits'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
  ];
  List<Widget> screens = [
    const ProductsScreen(),
    const CatecogriesScreen(),
    const FavoritesScreen(),
    SettingScreen(),

    // SettingScreen()
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  ShopHomeModel? shophomeModel;
  Map<int, bool>? favorites1 = {};
  void getHomeData() {
    emit(ShopLodingHomeDataState());
    DioHalpe.getData(url: HOME, token: token).then((value) {
      shophomeModel = ShopHomeModel.fromJson(value.data);

      // print(shophomeModel?.data?.banners?[1].id);
      //print(shophomeModel?.status);
      shophomeModel?.data?.products?.forEach((element) {
        favorites1?.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorites1.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopLodingHomeDataState());
    DioHalpe.getData(url: Get_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);

      // print(shophomeModel?.data?.banners?[1].id);
      // print(shophomeModel?.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorCategoriesState());
    });
  }

  Map<int, bool> favorites = {};
  IconData favoritIcon = Icons.favorite_border;
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productsId) async {
    // if(productsId == favoritesModel.data[])){}
    favorites1![productsId] = !favorites1![productsId]!;

    // if (favorites.containsKey(productsId)) {
    //   favorites.remove(productsId);
    //   favoritIcon = Icons.favorite_border;
    emit(ShopChangeFavoritesState());
    // } else {
    //   favorites.addAll({productsId: fav});
    //   favoritIcon = Icons.favorite;
    //   emit(ShopChangeFavoritesState());
    // }

    // favoritIcon =
    //     favorites[productsId]! ? Icons.favorite_border : Icons.favorite;

    await DioHalpe.postdata(
            url: FAVORITES,
            data: {
              'product_id': productsId,
            },
            token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(changeFavoritesModel?.data?.dataProducts?.id);

      // print(shophomeModel?.data?.banners?[1].id);
      // print(shophomeModel?.status);
      // getHomeData();

      if (!changeFavoritesModel!.status!) {
        favorites1![productsId] = !favorites1![productsId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      print(error.toString());
      // favorites[productsId] = !favorites[productsId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  Favorites? favoritesModel;
  void getFavoritesData() {
    emit(ShopLodingGetFavoritesState());
    DioHalpe.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = Favorites.fromJson(value.data);
      print("FAV DATA ${favoritesModel?.data?.dataProducts}");

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getuserData() {
    emit(ShopLodingGetUserDataState());
    DioHalpe.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print("User DAta ${userModel?.data?.name}");

      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateuserData({
    String? name,
    String? email,
    String? phone,
  }) {
    emit(ShopLodingUpdateUserState());
    DioHalpe.putdata(url: UPDATA_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print("User DAta ${userModel?.data?.name}");

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error);
      emit(ShopErrorUpdateUserState());
    });
  }
}
