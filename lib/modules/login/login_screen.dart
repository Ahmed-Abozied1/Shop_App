// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/shop_app/shop_home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/state.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/component/component_screen.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/styles/colors.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
    var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    IconData? suffix;
    bool isPassword = false;

    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.loginModel.status!) {
                print(state.loginModel.message!);

                print(state.loginModel.data!.token!);
                CacheHelper.setData(
                        value: state.loginModel.data!.token!, key: 'token')
                    .then((value) =>
                        {
                          token=state.loginModel.data!.token!,
                          navigateAndFinish(context, ShopHomeLayout())});
              } else {
                print(state.loginModel.message!);
                showToast(
                    message: state.loginModel.message!, type: ToastType.error);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            " Shoppy",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black87),
                          ),
                          // Text("Login Now ToBrowse Our Hot Offers",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1!
                          //         .copyWith(color: Colors.grey)),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            // decoration: BoxDecoration(
                            //     color: Colors.grey[400],
                            //     borderRadius: BorderRadius.circular(15)),
                            child: defaultFormFeild(
                              hintText: 'Email Address',
                              controller: emailController,
                              onSubmit: (value) {},
                              label: '',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email must not be empty';
                                }
                              },
                              type: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
////////////////////////
                          Container(
                            // height: 48.0,
                            // width: 350,
                            // decoration: BoxDecoration(
                            //     color: Colors.grey[400],
                            //     borderRadius:
                            //         BorderRadiusDirectional.circular(15)),
                            child: defaultFormFeild(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(LoginCubit.get(context).suffix)),
                              controller: passwordController,
                              onSubmit: (s) {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              obsecure: LoginCubit.get(context).isPassword,
                              label: '',
                              validator: (s) {
                                if (s.isEmpty) {
                                  return 'Password must not be empty';
                                }
                              },
                              type: TextInputType.visiblePassword,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 24),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: defaultColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) {
                              return defaultButton(
                                  background: defaultColor,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: "Login",
                                  isUpperCase: true);
                            },
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don\'t have an account?"),
                              SizedBox(
                                width: 10.0,
                              ),
                              DefaultTextButton(
                                  function: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  text: "Sigin Up")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
