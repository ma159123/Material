import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motabea/shared/network/local/shared_preference.dart';
import 'layout/motabea_app/cubit/cubit.dart';
import 'layout/motabea_app/cubit/states.dart';
import 'layout/motabea_app/home.dart';
import 'modules/Login.dart';
import 'modules/boading.dart';
import 'shared/bloc_observer.dart';
import 'shared/styles/themes.dart';

//just for change
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  bool isBoarding=CacheHelper.getData(key: 'onBoarding')??false;
  bool isLogin=CacheHelper.getData(key: 'isLogin')??false;
 Widget widget;

 if(isBoarding!=false)
   {

     if(isLogin!=false) widget=MaterialHomeScreen();
     else  widget=InformScreen();

   }else {
   widget=BoardingScreen();
 }

  runApp(MyApp(
  isBoarding,
    widget
  ));
}

class MyApp extends StatelessWidget {

 final bool isBoarding;
 final Widget startingWidget;
  MyApp(this.isBoarding, this.startingWidget, );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MotabeaCubit()),
      ],
      child: BlocConsumer<MotabeaCubit, MotabeaStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home:startingWidget,           //isBoarding?InformScreen(): BoardingScreen(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
