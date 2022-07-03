// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/shared/component/component_screen.dart';
import 'package:shop_app/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel;
          // nameController.text = model.data.name;
          // emailController.text=model.email;
          // phoneController.text=model.phone;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is LoadingGetUpdateUserState)
                    
                      LinearProgressIndicator(),

                    
                    defaultFormFeild(
                        prefixIcon: Icons.person,
                        controller: nameController,
                        onSubmit: () {},
                        validator: (String name) {
                          if (name.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        label: "Name",
                        type: TextInputType.name),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormFeild(
                        prefixIcon: Icons.email,
                        controller: emailController,
                        onSubmit: () {},
                        validator: (String email) {
                          if (email.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        label: "Email",
                        type: TextInputType.emailAddress),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormFeild(
                        prefixIcon: Icons.phone,
                        controller: phoneController,
                        onSubmit: () {},
                        validator: (var phone) {
                          if (phone.isEmpty) {
                            return 'Please enter Phone';
                          }
                          return null;
                        },
                        label: "Phone",
                        type: TextInputType.phone),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        child: TextButton(
                      onPressed: () {
                        signOut(context);
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(color: defaultColor),
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                         
                         ShopCubit.get(context).getUpdateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                          
                        }
                       
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: defaultColor),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
