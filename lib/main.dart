// ignore_for_file: prefer_const_constructors, unused_local_variable, curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_app/shop_home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CacheHelper.init();
      Widget? widget;
      bool? onBoarding = CacheHelper.getData(key: "onBoarding");

      token = CacheHelper.getData(key: "token");
      print(token);
      if (onBoarding != null) {
        if (token != null)
          widget = ShopHomeLayout();
        else
          widget = ShopLoginScreen();
      } else {
        OnBoarding();

      }

      runApp(MyApp(startWidget: widget!));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
     
      
        BlocProvider(
          create: ( context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorties()
            ..getUserData()
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: defaultColor,
              selectedLabelStyle: TextStyle(color: defaultColor),
            ),
            primarySwatch: defaultColor,
            fontFamily: "Noto",
            //
            // AppBarTheme(backgroundColor: Colors.white, elevation: 0.0),
          ),
          debugShowCheckedModeBanner: false,
          home: startWidget),
    );
  }
}
