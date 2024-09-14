 import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/administrator_screens/admin_home/admin_home.dart';
import 'package:quiz_app_new/screens/administrator_screens/admin_home/cubit/cubit.dart';
import 'package:quiz_app_new/screens/administrator_screens/admin_login/login_cubit/cubit.dart';
import 'package:quiz_app_new/screens/administrator_screens/create_new_exam/cubit/cubit.dart';
import 'package:quiz_app_new/screens/fav/cubit/cubit.dart';
import 'package:quiz_app_new/screens/layout/cubit/cubit.dart';
import 'package:quiz_app_new/screens/layout/nav_bar.dart';
import 'package:quiz_app_new/screens/login/login_cubit/cubit.dart';
import 'package:quiz_app_new/screens/student_home/cubit/cubit.dart';
import 'package:quiz_app_new/screens/student_profile/cubit/cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'Sh/bloc_observer.dart';
import 'Sh/shared_pref.dart';
import 'screens/splash/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp();
  FirebaseAppCheck.instance.activate();
  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
  });
  FirebaseMessaging.onMessage.listen((message) {
    debugPrint(
        '================================ FOREGROUND NOTIFICATION ================================');
    debugPrint(message.data.toString());
    debugPrint('Notification title: ${message.notification!.title}');
    debugPrint('Notification body: ${message.notification!.body}');
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AdminLoginCubit()),
        BlocProvider(create: (context) => AdminHomeCubit()..getUserDataInHome()),
        BlocProvider(create: (context) => CreateNewExamCubit() ),
        BlocProvider(create: (context) => NavBarCubit()),
        BlocProvider(
          create: (context) => StudentHomeCubit()..getUserDataInHome()..getAllVideos(),
        ),
        BlocProvider(
          create: (context) => FavCubit()..getAllFavourite(),
        ),
        // BlocProvider(create: (context)=>TestBankCubit()..getAllQuestionsTestBank(),),
        BlocProvider(
          create: (context) => StudentProfileCubit()..getUserDataInProfile(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(88, 17, 143, 1)),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(88, 17, 143, 1)),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(88, 17, 143, 1)),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
        home:
        // const SplashScreen(),
        SharedPreferencesHelper.getData(key: "uId")==null ?  const SplashScreen() :
        SharedPreferencesHelper.getData(key: "uId")!=null && SharedPreferencesHelper.getData(key: "isAdmin") ==true ? AdminHome():
        Layout(),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
