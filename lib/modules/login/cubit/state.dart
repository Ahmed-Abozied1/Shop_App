import 'package:shop_app/models/shop_login_model/shop_login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class ShopLoginErrrorState extends LoginStates {
  final String error;

  ShopLoginErrrorState(this.error);
}

class ShopShowPasswordVisisbityState extends LoginStates {}
