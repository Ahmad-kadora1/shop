import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/models/shop_app/categories_model.dart';
//import 'package:shop/layout/shared/componants/componants.dart';
import 'package:shop/layout/shop_app/shop_cubit/cubit/cubit.dart';
import 'package:shop/layout/shop_app/shop_cubit/cubit/states.dart';

class CatecogriesScreen extends StatelessWidget {
  const CatecogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Container(
          color: Colors.orange,
          child: ListView.separated(
              itemBuilder: (context, index) => buildCatTtem(
                  ShopCubit.get(context).categoriesModel?.data?.data?[index]),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 0.0,
                  ),
              itemCount:
                  ShopCubit.get(context).categoriesModel?.data?.data?.length ??
                      0),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildCatTtem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 120.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: NetworkImage('${model?.image}'),
                width: 120.0,
                height: 120.0,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '${model?.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 70.0,
              color: Colors.black,
            ),
          ]),
        ),
      );
}
