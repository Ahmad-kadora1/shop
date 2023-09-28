//import 'package:bloc/bloc.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/modules/shop_app/shop_regester/cubit/states.dart';
import 'package:shop/layout/shared/network/remode/dio_halper.dart';
import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/end_piont.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? LoginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLodingState());

    DioHalpe.postdata(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone
      },
    ).then((value) {
      // print(value.data);
      LoginModel = ShopLoginModel.fromJson(value.data);
      // print(RegisterModel?.status);
      // print(RegisterModel?.message);
      // print(RegisterModel?.data?.name);
      // print(RegisterModel?.data?.phone);
      emit(ShopRegisterSuccessState(LoginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool bol = true;
  void onchangpassword() {
    bol = !bol;
    suffix = bol ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShowpassRegisterState());
  }
}
