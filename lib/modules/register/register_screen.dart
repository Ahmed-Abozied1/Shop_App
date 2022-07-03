// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/shop_home_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/state.dart';
import 'package:shop_app/shared/component/component_screen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
         listener: (context, state) {
            if (state is RegisterSuccessState) {
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
                appBar: AppBar(
                  title: const Text("Register"),
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " REGISTER ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.black87),
                            ),

                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              child: defaultFormFeild(
                                prefixIcon: Icons.person,
                                hintText: 'Username',
                                controller: nameController,
                                onSubmit: (value) {},
                                label: 'UserName',
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Name must not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.name,
                              ),
                            ),

                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: defaultFormFeild(
                                prefixIcon: Icons.email,
                                hintText: 'Email Address',
                                controller: emailController,
                                onSubmit: (value) {},
                                label: '',
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Email must not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.emailAddress,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ////////////////////////
                            Container(
                              child: defaultFormFeild(
                                prefixIcon: Icons.password_rounded,
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      RegisterCubit.get(context)
                                          .changePasswordVisibility();
                                    },
                                    icon: Icon(
                                        RegisterCubit.get(context).suffix)),
                                controller: passwordController,
                                onSubmit: (s) {},
                                obsecure: RegisterCubit.get(context).isPassword,
                                label: '',
                                validator: (s) {
                                  if (s.isEmpty) {
                                    return 'Password must not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.visiblePassword,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: defaultFormFeild(
                                prefixIcon: Icons.phone,
                                hintText: 'Phone',
                                controller: phoneController,
                                onSubmit: (value) {},
                                label: '',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Phone must not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.phone,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) {
                                return defaultButton(
                                    background: defaultColor,
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text);
                                      }
                                    },
                                    text: "register",
                                    isUpperCase: true);
                              },
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
