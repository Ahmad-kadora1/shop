import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/models/shop_app/search_model.dart';
import 'package:shop/layout/modules/shop_app/searsh/cubit/states.dart';
import 'package:shop/layout/shared/componants/constans.dart';

import '../../../../shared/network/end_piont.dart';
import '../../../../shared/network/remode/dio_halper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  Searchmodel? searchmodel;

  void search(String text) {
    emit(SearchLodingState());
    DioHalpe.postdata(
      url: SEARCH,
      token: token,
      data: {'text': text},
    ).then((value) {
      searchmodel = Searchmodel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
