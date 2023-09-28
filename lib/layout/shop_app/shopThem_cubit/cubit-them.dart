// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/shop_app/shopThem_cubit/steatstheam.dart';

import '../../shared/network/local/cash_helper.dart';

class CubitThem extends Cubit<AppStatesThem> {
  CubitThem() : super(AppInitialState());
  static CubitThem get(context) => BlocProvider.of(context);

  bool isdark = false;

  void changAppMode({bool? frommod}) {
    if (frommod != null) {
      isdark = frommod;
      emit(AppChangeModeState());
    } else {
      isdark = !isdark;
      CashHelper.putData(key: 'isdark', value: isdark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
