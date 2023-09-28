//import 'package:bloc/bloc.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/models/shop_app/login_model.dart';
import 'package:shop/layout/modules/shop_app/login_shop/cubit/states.dart';
import 'package:shop/layout/shared/network/remode/dio_halper.dart';

import '../../../../shared/network/end_piont.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({required String email, required String password}) {
    emit(ShopLoginLodingState());

    DioHalpe.postdata(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(loginModel?.status);
      // print(loginModel?.message);
      // print(loginModel?.data?.name);
      // print(loginModel?.data?.phone);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool bol = true;
  void onchangpassword() {
    bol = !bol;
    suffix = bol ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShowpassState());
  }
}
