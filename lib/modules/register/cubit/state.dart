import 'package:shop_app/models/shop_login_model/shop_login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class ShopRegisterErrrorState extends RegisterStates {
  final String error;

  ShopRegisterErrrorState(this.error);
}

class ShopRegisterShowPasswordVisisbityState extends RegisterStates {}
