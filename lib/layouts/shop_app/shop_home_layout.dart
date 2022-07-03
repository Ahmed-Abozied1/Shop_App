// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorits/favorite_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/products/products.screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/component/component_screen.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/styles/colors.dart';

class ShopHomeLayout extends StatelessWidget {
  const ShopHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
           List<Widget> screens = [
          ProductsScreen(),
          FavoritsScreen(),
          CategoriesScreen(),
          SettingsScreen(),
        ];
        List<String> titles = [
          'Shoppy',
          'Favourites',
          'Cart',
          'Settings',
        ];
        var cubit = ShopCubit.get(context);
        return Scaffold(

            appBar: AppBar(
              title:Text(titles[ShopCubit.get(context).currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      //
                    )),
              ],
            ),
            body:
            //'cubit.bootomScreen[cubit.currentIndex],
            screens[ShopCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(

              onTap: (index) {
                cubit.changeIndex(index);
              },
             currentIndex: cubit.currentIndex,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                 BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: defaultColor),
                  label: "Home",
                ),
                 BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, color: defaultColor),
                  label: "Favorites",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart, color: defaultColor,),
                  label: "Categories",
                  
                ),
                
               
                 
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, color: defaultColor),
                  label: "Settings",
                ),
              
              ],
            ));
      },
    );
  }
}
