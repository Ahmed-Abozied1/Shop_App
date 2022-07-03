// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/models/favourites_model/favourties_model.dart';
import 'package:shop_app/shared/component/component_screen.dart';
import 'package:shop_app/styles/colors.dart';

class FavoritsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).favoriteModel!.data!.data.isEmpty
            ? Center(
                child: Text(
                  'No Favourites',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              )
            : Scaffold(
                body: ConditionalBuilder(
                condition: state is! LoadingGetFavouritesState,
                builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildListProduct(
                        ShopCubit.get(context)
                            .favoriteModel!
                            .data!
                            .data[index]
                            .product,
                        context),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: ShopCubit.get(context)
                        .favoriteModel!
                        .data!
                        .data
                        .length),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ));
        //  condition: state is SuccessGetFavouritesState,
      },
    );
  }
}
