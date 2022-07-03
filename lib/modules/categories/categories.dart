// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
