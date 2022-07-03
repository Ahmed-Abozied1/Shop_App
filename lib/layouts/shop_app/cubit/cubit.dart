// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/change_favourites_model/favourites.dart';
import 'package:shop_app/models/favourites_model/favourties_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/shop_login_model/shop_login_model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorits/favorite_screen.dart';
import 'package:shop_app/modules/products/products.screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppInitial());

  static ShopCubit get(context) => BlocProvider.of<ShopCubit>(context);
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChaneBottomNavigationBar());
  }

  List<Widget> bootomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritsScreen(),
    SettingsScreen(),
  ];
  HomeModel? homeModel;
  Map<int, dynamic> favourite = {};
  void getHomeData() {
    emit(ShopAppLoading());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel!.data!.banners[0].image);
      homeModel!.data!.products.forEach((element) {
        favourite.addAll({element.id: element.isFavorites});
      });
      print(favourite.toString());
      emit(ShopAppLoadedsuccess());
    }).catchError((error) {
      print("error!!! " + error.toString());
      emit(ShopAppError());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit((SuccessCategoriesState()));
    }).catchError((error) {
      print("Error !!! " + error.toString());
      emit((CategoriesErrorState()));
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;
  void favouriteProduct(
    int id,
  ) {
    favourite[id] = !favourite[id];
    emit(ChangeFavoutitesState());
    DioHelper.postDate(url: FAVOURITES, token: token, data: {
      "product_id": id,
    }).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavouritesModel!.status!) {
        favourite[id] = !favourite[id];
      } else {
        getFavorties();
      }
      emit(SuccessChangeFavoutitesState(changeFavouritesModel!));
    }).catchError((onError) {
      favourite[id] = !favourite[id];
      print("Error !!! " + onError.toString());
      emit(ErrorChangeFavoutitesState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorties() {
    emit(LoadingGetFavouritesState());
    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      printFullText("hiiii");
      emit((SuccessGetFavouritesState()));
    }).catchError((error) {
      print("Error !!! " + error.toString());
      emit((GetFavouritesErrorState()));
    });
  }

    LoginModel? userModel;

  void getUserData() {
    emit(LoadingGetUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
    print(userModel!.data!.name);
      emit((SuccessGetUserDatasState(userModel!)));
    }).catchError((error) {
      print("Error !!! " + error.toString());
      emit((GetUserDataErrorState()));
    });
  }

   void getUpdateUserData({
    required String name,
    required String email,
    required String phone,
   }) {
    emit(LoadingGetUpdateUserState());
    DioHelper.putDate(url: UPDATE, token: token,data:{
       "name": name,
        "email": email,
        "phone": phone,
        

    } ).then((value) {
      userModel = LoginModel.fromJson(value.data);
    print(userModel!.data!.name);
      emit((SuccessGetUpdateUsersState(userModel!)));
    }).catchError((error) {
      print("Error !!! " + error.toString());
      emit((GetUpdateUserErrorState()));
    });
  }
}
