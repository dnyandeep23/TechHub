import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/core/store.dart';
import 'package:first_app/pages/cart_page.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:first_app/pages/register_page.dart';
import 'package:first_app/utils/routes.dart';
import 'package:first_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('', 9099);
  setPathUrlStrategy();

  runApp(VxState(store: MyStore(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // // double pi = 3.14;
    // bool isMale = true;
    // num temp = 30.5;
    //
    // var day = "Friday";
    // // var day = 5;
    // const pi = 3.14;
    //
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      // darkTheme: ThemeData(
      //
      // ),,
      debugShowCheckedModeBanner: false,
      //   routeInformationParser: RouteInformationParser,
      // routerDelegate:

      initialRoute: MyRoutes.loginRoute,
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(value1: '',),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.registerRoute: (context) => RegisterPage(),
        MyRoutes.cartRoute: (context) => CartPage(value1: '',)
      },
    );
  }
}

// bringVegitables({int rupees = 100}){ // optional parameter : diya toh bhi theek nahi toh bhi theek
//
// }
