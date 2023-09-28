import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/modules/shop_app/shop_regester/cubit/cubit.dart';
import 'package:shop/layout/modules/shop_app/shop_regester/cubit/states.dart';

import '../../../shared/componants/componants.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../homlayout/home_layout.dart';

class ShopRegesterScreen extends StatelessWidget {
  ShopRegesterScreen({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();
  final pssControl = TextEditingController();

  final emalControl = TextEditingController();
  final nameControl = TextEditingController();

  final phoneControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
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
                          'REGISTER ',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'REGISTER now to browse our hot offers ',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultfromfild(
                            controller: nameControl,
                            type: TextInputType.name,
                            onSubmit: (value) {},
                            valdidate: (value) {
                              if (value!.isEmpty) {
                                return ' please enter your name ';
                              }
                              return null;
                            },
                            text: 'User Name',
                            prfix: Icons.person),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultfromfild(
                            controller: emalControl,
                            type: TextInputType.emailAddress,
                            onSubmit: (value) {},
                            valdidate: (value) {
                              if (value!.isEmpty) {
                                return ' please enter your Email ';
                              }
                              return null;
                            },
                            text: 'Email Adress',
                            prfix: Icons.email),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultfromfild(
                          ispassword: ShopRegisterCubit.get(context).bol,
                          controller: pssControl,
                          type: TextInputType.visiblePassword,
                          sufixprass: () {
                            ShopRegisterCubit.get(context).onchangpassword();
                            // setState(() {
                            //   bol = !bol;
                            // });
                          },
                          sufix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
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
                        defultfromfild(
                            controller: phoneControl,
                            type: TextInputType.phone,
                            onSubmit: (value) {},
                            valdidate: (value) {
                              if (value!.isEmpty) {
                                return ' please enter your Phone ';
                              }
                              return null;
                            },
                            text: 'your phone',
                            prfix: Icons.phone),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          builder: (BuildContext context) => defultButton(
                            background: Colors.orange,
                            fun1: () {
                              if (formkey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emalControl.text,
                                    password: pssControl.text,
                                    name: nameControl.text,
                                    phone: phoneControl.text);
                                // ahmad.kadora@gmail.com
                                //123456
                                // print(emalcontrol.text);
                                // print(psscontrol.text);
                              }
                            },
                            text: 'regester',
                            isupper: true,
                          ),
                          condition: state is! ShopRegisterLodingState,
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
        listener: (BuildContext context, Object? state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel?.status == true) {
              CashHelper.saveData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                navigateAndFinsh(context, const ShopLayout());
              });
              //  print(state.loginModel?.data?.token);
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
