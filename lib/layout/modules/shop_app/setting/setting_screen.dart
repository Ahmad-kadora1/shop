import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shared/componants/componants.dart';
import 'package:shop/layout/shared/componants/constans.dart';
import 'package:shop/layout/shop_app/shop_cubit/cubit/cubit.dart';
import 'package:shop/layout/shop_app/shop_cubit/cubit/states.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: ((context, state) => ConditionalBuilder(
            builder: (BuildContext context) {
              var model = ShopCubit.get(context).userModel;
              nameControler.text = model!.data!.name!;
              emailControler.text = model.data!.email!;
              phoneControler.text = model.data!.phone!;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is ShopLodingUpdateUserState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defultfromfild(
                            controller: nameControler,
                            type: TextInputType.name,
                            onSubmit: (value) {},
                            valdidate: (value) {
                              if (value!.isEmpty) {
                                return ' name must not be empty ';
                              }
                              return null;
                            },
                            text: 'User Name',
                            prfix: Icons.person),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultfromfild(
                            controller: emailControler,
                            type: TextInputType.emailAddress,
                            onSubmit: (value) {},
                            valdidate: (value) {
                              if (value!.isEmpty) {
                                return ' Email must not be empty ';
                              }
                              return null;
                            },
                            text: 'Email Address',
                            prfix: Icons.email),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultfromfild(
                            controller: phoneControler,
                            type: TextInputType.phone,
                            onSubmit: (value) {},
                            valdidate: (value) {
                              if (value!.isEmpty) {
                                return ' phone must not be empty ';
                              }
                              return null;
                            },
                            text: 'Phone Number',
                            prfix: Icons.phone),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultButton(
                            fun1: () {
                              signOut(context);
                            },
                            text: 'Logout',
                            background: Colors.amber),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defultButton(
                            fun1: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateuserData(
                                  name: nameControler.text,
                                  email: emailControler.text,
                                  phone: phoneControler.text,
                                );
                              }
                            },
                            text: 'update',
                            background: Colors.amber)
                      ],
                    ),
                  ),
                ),
              );
            },
            condition: ShopCubit.get(context).userModel != null,
            fallback: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          )),
      listener: (context, state) {},
    );
  }
}
