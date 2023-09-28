//rrQGdHHZmrgTd9H14iDA4kEB8iK0ZRhlBv3tAHUVS03DHuHtFxqhSI2Npo4EiXrxAn5tt3

import '../../modules/shop_app/login_shop/login.dart';
import '../network/local/cash_helper.dart';
import 'componants.dart';

void signOut(context) {
  CashHelper.removedata(key: 'token').then((value) {
    if (value == true) {
      navigateAndFinsh(context, LoginScreen());
    }
  });
}

String token = '';
