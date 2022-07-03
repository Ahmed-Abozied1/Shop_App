// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model/shop_login_model.dart';
import 'package:shop_app/modules/register/cubit/state.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
 
  LoginModel? loginModel;

  void userRegister({required String email,
   required String password, 
    required String name,
    required String phone,
   
   }) {
    emit(RegisterLoadingState());
    DioHelper.postDate(
      url: REGISTER,
      data: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
      },
      // headers: {
      //   'lang': 'ar',
      //   'Content-Type': 'application/json',
      // },
    ).then((value) {
     // print(value.data.toString());
      loginModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessState(loginModel!));
      // print(loginModel!.message!);
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    isPassword
        ? suffix = Icons.visibility
        : suffix = Icons.visibility_off_outlined;


    emit(ShopRegisterShowPasswordVisisbityState());
  }
}
