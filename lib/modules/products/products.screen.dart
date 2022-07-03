// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/component/component_screen.dart';
import 'package:shop_app/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if (state is SuccessChangeFavoutitesState) {
        //   if (state.model.status!) {
        //     showToast(message: state.model.message!,
        //      type: ToastType.success
        //      );
        //   }
        //   else
        //   {
        //     showToast(message: state.model.message!,
        //      type: ToastType.error
        //      );
        //   }
        // }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              body: ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => builderWidget(
                ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!,
                context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          )),
        );
      },
    );
  }

  Widget builderWidget(
    HomeModel? model,
    CategoriesModel? categoriesModel,
    context,
  ) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ignore: prefer_const_literals_to_create_immutables
          CarouselSlider(
              items: model!.data!.banners
                  .map((e) =>
                      Image(image: NetworkImage(e.image), fit: BoxFit.cover))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel!.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel!.data.data.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  " New Products",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.63,
              children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProuducts(model.data!.products[index], context)),
            ),
          ),
        ]),
      );
  Widget buildGridProuducts(ProductsModel? model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                if (model!.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(),
                  ),
                  Row(
                    children: [
                      Text(
                        model.price.round().toString(),
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.round().toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopCubit.get(context).favourite[model.id]
                                    ? defaultColor
                                    : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            )),
                        onPressed: () {
                          ShopCubit.get(context).favouriteProduct(model.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel? model) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image(
              image: NetworkImage(model!.image),
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
            Container(
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                color: Colors.black.withOpacity(.8),
                child: Text(
                  model.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      );
}
