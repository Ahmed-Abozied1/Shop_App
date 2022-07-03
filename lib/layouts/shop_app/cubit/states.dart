import 'package:shop_app/models/change_favourites_model/favourites.dart';
import 'package:shop_app/models/shop_login_model/shop_login_model.dart';

abstract class ShopStates {}

class ShopAppInitial extends ShopStates {}

class ShopChaneBottomNavigationBar extends ShopStates {}

/////////

class ShopAppLoading extends ShopStates {}

class ShopAppLoadedsuccess extends ShopStates {}

class ShopAppError extends ShopStates {}
//categories

class SuccessCategoriesState extends ShopStates {}

class CategoriesErrorState extends ShopStates {}
//change favourites

class SuccessChangeFavoutitesState extends ShopStates {
  final ChangeFavouritesModel model;

  SuccessChangeFavoutitesState(this.model);
}

class ChangeFavoutitesState extends ShopStates {}

class ErrorChangeFavoutitesState extends ShopStates {}

// Git favouritesclass SuccessCategoriesState extends ShopStates {}

class LoadingGetFavouritesState extends ShopStates {}

class SuccessGetFavouritesState extends ShopStates {}

class GetFavouritesErrorState extends ShopStates {}

//userData Profile
class LoadingGetUserDataState extends ShopStates {}

class SuccessGetUserDatasState extends ShopStates {
  final LoginModel loginModel;

  SuccessGetUserDatasState(this.loginModel);

}

class GetUserDataErrorState extends ShopStates {}



//userUpdate Profile
class LoadingGetUpdateUserState extends ShopStates {}

class SuccessGetUpdateUsersState extends ShopStates {
  final LoginModel loginModel;

  SuccessGetUpdateUsersState(this.loginModel);

}

class GetUpdateUserErrorState extends ShopStates {}