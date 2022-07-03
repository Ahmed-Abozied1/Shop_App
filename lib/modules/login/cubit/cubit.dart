// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model/shop_login_model.dart';
import 'package:shop_app/modules/login/cubit/state.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
 
  LoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postDate(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
      headers: {
        'lang': 'ar',
        'Content-Type': 'application/json',
      },
    ).then((value) {
     // print(value.data.toString());
      loginModel = LoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel!));
      // print(loginModel!.message!);
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    isPassword
        ? suffix = Icons.visibility
        : suffix = Icons.visibility_off_outlined;
    emit(ShopShowPasswordVisisbityState());
  }
}
