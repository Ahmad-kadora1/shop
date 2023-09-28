import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/services.dart';
// import 'package:bloc/bloc.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/layout/modules/shop_app/homlayout/home_layout.dart';
import 'package:shop/layout/modules/shop_app/login_shop/login.dart';

import 'layout/modules/shop_app/on_boarding/on_boarding.dart';
import 'layout/shared/componants/constans.dart';
import 'layout/shared/network/local/cash_helper.dart';
import 'layout/shared/network/remode/dio_halper.dart';
import 'layout/shared/observer.dart';
import 'layout/shared/them.dart';
import 'layout/shop_app/shopThem_cubit/cubit-them.dart';
import 'layout/shop_app/shopThem_cubit/steatstheam.dart';
import 'layout/shop_app/shop_cubit/cubit/cubit.dart';

//https://newsapi.org/v2/everything?q=tesla&apiKey=80335548d4fd4a6c9bc6ff09d5718932
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHalpe.init();
  await CashHelper.init();
  Widget widget;

  bool? isdark = CashHelper.getdata(key: 'isdark');
  bool? onbording = CashHelper.getdata(key: 'onBording');
  // CashHelper.removedata(key: 'onBording');
  token = CashHelper.getdata(key: 'token');

  if (onbording != null) {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBordingscreen();
  }
  runApp(MyApp(
    isdark: isdark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isdark;
  final Widget? startWidget;

  const MyApp({Key? key, this.isdark, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            //   create: (BuildContext context) => NewsCubit()
            //     ..getBusiness()
            //     ..getSports()
            //     ..getscience(),
            // ),
            // BlocProvider(
            create: (BuildContext context) =>
                CubitThem()..changAppMode(frommod: isdark)),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getuserData(),
        ),
      ],
      child: BlocConsumer<CubitThem, AppStatesThem>(
        listener: (BuildContext context, state) {
          // if (state is NewsChangeModeState) {}
        },
        builder: (BuildContext context, Object? state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightThem,
            darkTheme: DarkThem,
            themeMode: CubitThem.get(context).isdark
                ? ThemeMode.light
                : ThemeMode.dark,
            home:
                startWidget // oninbording ?? false ? LoginScreen() : OnBordingscreen()
            ),
      ),
    );
  }
}
