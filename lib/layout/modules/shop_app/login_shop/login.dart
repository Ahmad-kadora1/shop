// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/modules/shop_app/login_shop/cubit/cubit.dart';
import 'package:shop/layout/modules/shop_app/login_shop/cubit/states.dart';
import 'package:shop/layout/shared/componants/constans.dart';

import '../homlayout/home_layout.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../shop_regester/shop_regester_screen.dart';

class LoginScreen extends StatelessWidget {
  final psscontrol = TextEditingController();

  final emalcontrol = TextEditingController();

  final formkey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN ',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'login now to browse our hot offers ',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultfromfild(
                            controller: emalcontrol,
                            type: TextInputType.emailAddress,
                            onSubmit: (value) {},
                            valdidate: (value) {
                              if (value!.isEmpty) {
                                return ' is not found ';
                              }
                              return null;
                            },
                            text: 'Email  adress',
                            prfix: Icons.email),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultfromfild(
                          ispassword: ShopLoginCubit.get(context).bol,
                          controller: psscontrol,
                          type: TextInputType.visiblePassword,
                          sufixprass: () {
                            ShopLoginCubit.get(context).onchangpassword();
                            // setState(() {
                            //   bol = !bol;
                            // });
                          },
                          sufix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emalcontrol.text,
                                  password: psscontrol.text);
                              // ahmad.kadora@gmail.com
                              //123456
                              // print(emalcontrol.text);
                              // print(psscontrol.text);
                            }
                          },
                          valdidate: (value) {
                            if (value!.isEmpty) {
                              return ' is not passworf ';
                            }
                            return null;
                          },
                          text: 'Enter password',
                          prfix: Icons.lock,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          builder: (BuildContext context) => defultButton(
                            background: Colors.orange,
                            fun1: () {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emalcontrol.text,
                                    password: psscontrol.text);
                                // ahmad.kadora@gmail.com
                                //123456
                                // print(emalcontrol.text);
                                // print(psscontrol.text);
                              }
                            },
                            text: 'Login',
                          ),
                          condition: state is! ShopLoginLodingState,
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'move to creat account --------',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                            defaultTextbutton(
                                onpress: () {
                                  navigateAndFinsh(
                                      context, ShopRegesterScreen());
                                },
                                text: 'regester'),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel?.status == true) {
              CashHelper.saveData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                token = state.loginModel!.data!.token!;
                navigateAndFinsh(context, const ShopLayout());
              });
              print(state.loginModel?.data?.token);
              // showtoast(
              //     text: "${state.loginModel?.message}",
              //     state: ToastStates.SUCCESS);
              // print('this token   ${state.loginModel?.data?.token}');
            } else {
              showtoast(
                  text: "${state.loginModel?.message}",
                  state: ToastStates.ERROR);
            }
          }
        },
      ),
    );
  }
}
