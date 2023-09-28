import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop/layout/models/shop_app/changefavorites_model.dart';

import '../../../models/shop_app/favorites_model.dart';
import '../../../shop_app/shop_cubit/cubit/cubit.dart';
import '../../../shop_app/shop_cubit/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ShopLodingGetFavoritesState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context)
                        .favoritesModel!
                        .data!
                        .dataProducts![index],
                    context),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: ShopCubit.get(context)
                        .favoritesModel!
                        .data
                        ?.dataProducts
                        ?.length ??
                    0),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget buildFavItem(DataProductsModel model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        color: Colors.white,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: NetworkImage(model.image!),
                    //'${model?.data?.products?[index].image}'),
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                ),
                // if (model?.data?.products?[index].old_price >
                //
                //   model?.data?.products?[index].price)

                if (model.discount != 0)
                  Container(
                      width: 70.0,
                      height: 20.0,
                      color: Colors.red,
                      child: const Text(
                        'discound',
                        style: TextStyle(color: Colors.white),
                      ))
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    //'${model?.data?.products?[index].name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        //'${model?.data?.products?[index].price}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.orange),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      // if (model?.data?.products?[index].old_price !=
                      //     model?.data?.products?[index].price)
                      if (model.oldprice != 0)
                        Text(
                          model.oldprice.toString(),
                          //'${model?.data?.products?[index].old_price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      const Spacer(),
                      InkWell(
                        child: Icon(
                          ShopCubit.get(context).favorites1![model.id]!
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        onTap: () {
                          ShopCubit.get(context).changeFavorites(
                            model.id!,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
