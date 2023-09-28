import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/models/shop_app/search_model.dart';
import 'package:shop/layout/modules/shop_app/searsh/cubit/cubit.dart';
import 'package:shop/layout/modules/shop_app/searsh/cubit/states.dart';
import 'package:shop/layout/shared/componants/componants.dart';

import '../../../shop_app/shop_cubit/cubit/cubit.dart';

class SearshScreen extends StatelessWidget {
  const SearshScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formkeuy = GlobalKey<FormState>();
    var searchControler = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkeuy,
              child: Column(
                children: [
                  defultfromfild(
                      controller: searchControler,
                      type: TextInputType.text,
                      onSubmit: (value) {
                        SearchCubit.get(context).search(value);
                      },
                      valdidate: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        } else
                          return null;
                      },
                      text: 'Search',
                      prfix: Icons.search),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (state is SearchLodingState) LinearProgressIndicator(),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context)
                                .searchmodel!
                                .data
                                ?.data![index],
                            context),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: SearchCubit.get(context)
                                .searchmodel
                                ?.data
                                ?.data
                                ?.length ??
                            0),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}

Widget buildSearchItem(Dataproduct? model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        color: Colors.white,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image(
                image: NetworkImage(model!.image!),
                //'${model?.data?.products?[index].image}'),
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fill,
              ),
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
                    //         //'${model?.data?.products?[index].name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        //               //'${model?.data?.products?[index].price}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.orange),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      //             // if (model?.data?.products?[index].old_price !=
                      //             //     model?.data?.products?[index].price)
                      //             // if (model.oldprice != 0)
                      //             //   Text(
                      //             //     model.oldprice.toString(),
                      //             //     //'${model?.data?.products?[index].old_price}',
                      //             //     style: const TextStyle(
                      //             //         fontWeight: FontWeight.normal,
                      //             //         color: Colors.grey),
                      //             //   ),
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
