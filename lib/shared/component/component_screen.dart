// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/styles/colors.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        double radius = 40.0,
        required function,
        required String text,
        bool isUpperCase = true}) =>
    Container(
      height: 40.0,
      width: width,
      child: MaterialButton(
          onLongPress: () {},
          onPressed: () {
            function();
          },
          child: Text(
            isUpperCase ? text.toUpperCase() : text.toLowerCase(),
            style: const TextStyle(color: Colors.white),
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: background,
      ),
    );

// Widget defaultFormFeild({
//   required TextEditingController controller,
//   required TextInputType type,
//   Function? onSubmit, //Add question mark
//   Function? onChange,
//   Function? suffixPressed, //Add question mark
//   Function? onTap,
//   required Function? validate,
//   required var label,
//   required IconData prefix,
//   IconData? suffix,
//   bool isPassword=false
// }) =>
//     TextFormField(
//       obscureText: isPassword,
//       onTap: onTap != null ? onTap() : null,
//       controller: controller,
//       keyboardType: type,
//       onFieldSubmitted: onSubmit != null ? onSubmit() : null, //do null checking
//       onChanged: onChange != null ? onChange() : null, //do null check

//       validator: (value) {
//         return validate!(value);
//       },
//       decoration: InputDecoration(
//           suffixIcon: suffix != null ? Icon(suffix) : null,
//           labelText: label,
//           prefixIcon: Icon(prefix),
//           border: OutlineInputBorder()),
//     );

Widget DefaultTextButton({required function, required String text}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: Text(text.toUpperCase()));

Widget defaultFormFeild({
  required TextEditingController controller,
  required Function onSubmit,
  required Function validator,
  required String? label,
  required TextInputType type,
  String? hintText,
  bool obsecure = false,
  Function? suffix,
  IconData? prefixIcon,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    onFieldSubmitted: (String s) {
      return onSubmit(s);
    },
    decoration: InputDecoration(
        hintText: hintText,
        helperStyle: const TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: defaultColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          // borderSide: BorderSide(
          //   color: Colors.black54,
          //   width: 2.0,
          // ),
        ),
        contentPadding: const EdgeInsets.all(0),
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon),
    keyboardType: type,
    obscureText: obsecure,
    validator: (s) => validator(s),
  );
}

void showToast({required String message, required ToastType type}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ToastType.success == type
          ? Colors.green
          : ToastType.warning == type
              ? Colors.yellow
              : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastType { success, error, warning }
void signOut(context) {
  CacheHelper.removeData(key: "token").then((value) => {
        if (value) {navigateAndFinish(context, ShopLoginScreen())}
      });
}

 Widget buildListProduct( model, context,{bool isOldPrice=true}) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(fontSize: 8.0, color: Colors.white),
                      ),
                    ),
                  Image(
                    image: NetworkImage(model.image!),
                    width: 120,
                    height: 120,
                  
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.round().toString()+"\$",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (model.discount != 0 && isOldPrice) 
                          Text(
                            model.oldPrice.round().toString()+"\$",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor:
                                  ShopCubit.get(context).favourite[model.id]
                                      ? defaultColor
                                      : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                size: 14,
                                color: Colors.white,
                              )),
                          onPressed: () {
                            ShopCubit.get(context).favouriteProduct(model.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
