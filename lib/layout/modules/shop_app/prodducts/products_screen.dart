import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/models/shop_app/categories_model.dart';
import 'package:shop/layout/models/shop_app/home_model.dart';
import 'package:shop/layout/shop_app/shop_cubit/cubit/cubit.dart';
import 'package:shop/layout/shop_app/shop_cubit/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).shophomeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productsbuilder(
                ShopCubit.get(context).shophomeModel,
                context,
                ShopCubit.get(context).categoriesModel),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }
}

Widget productsbuilder(
        ShopHomeModel? model, context, CategoriesModel? categoryModel) =>
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model?.data?.banners
                  ?.map(
                    (e) => Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
                      child: Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,

                aspectRatio: 1.9,

                initialPage: 0,

                enableInfiniteScroll: true,

                reverse: false,

                autoPlay: true,

                // viewportFraction: .7,

                autoPlayInterval: const Duration(seconds: 3),

                autoPlayAnimationDuration: const Duration(seconds: 1),

                autoPlayCurve: Curves.fastOutSlowIn,

                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 120.0,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoryModel?.data?.data?[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 20.0,
                            ),
                        itemCount: categoryModel?.data?.data?.length ?? 0),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'New Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 50,
              childAspectRatio: 1 / 1.44,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                ShopCubit.get(context).shophomeModel?.data?.products?.length ??
                    0,
                (index) => buildGridProduct(
                    ShopCubit.get(context).shophomeModel, index, context),
              ),
            )
          ],
        ),
      ),
    );
Widget buildGridProduct(ShopHomeModel? model, index, context) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage('${model?.data?.products?[index].image}'),
                  width: double.infinity,
                  // fit: BoxFit.cover,
                ),
                if (model?.data?.products?[index].oldprice >
                    model?.data?.products?[index].price)
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
          ),
          Text(
            '${model?.data?.products?[index].name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '${model?.data?.products?[index].price}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.orange),
              ),
              const SizedBox(
                width: 10.0,
              ),
              if (model?.data?.products?[index].oldprice !=
                  model?.data?.products?[index].price)
                Text(
                  '${model?.data?.products?[index].oldprice}',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.grey),
                ),
              const Spacer(),
              InkWell(
                child: Icon(
                  ShopCubit.get(context)
                          .favorites1![model!.data!.products![index].id]!
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onTap: () {
                  ShopCubit.get(context).changeFavorites(
                    model.data!.products![index].id!,
                  );
                },
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildCategoryItem(DataModel? model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model?.image}'),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100.0,
          child: Text(
            '${model?.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
       
//  ShopCubit.get(context).shophomeModel