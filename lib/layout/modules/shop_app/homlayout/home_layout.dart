import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:shop/layout/modules/shop_app/login_shop/login.dart';
//import 'package:shop/layout/modules/shop_app/on_boarding/on_boarding.dart';
import 'package:shop/layout/modules/shop_app/searsh/searsh_screen.dart';
import 'package:shop/layout/shared/componants/componants.dart';

//import '../../../shared/network/local/cash_helper.dart';
import '../../../shop_app/shop_cubit/cubit/cubit.dart';
import '../../../shop_app/shop_cubit/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text('HOME LAYOUT'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, const SearshScreen());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.orange,
              elevation: 40.0,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItem),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
