import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hartna1/scr/providers/app.dart';
import 'package:hartna1/scr/providers/category10.dart';
import 'package:hartna1/scr/providers/product.dart';
import 'package:hartna1/scr/providers/restaurant.dart';
import 'package:hartna1/scr/providers/user.dart';
import 'package:hartna1/scr/screens/home.dart';
import 'package:hartna1/scr/screens/login.dart';
import 'package:hartna1/scr/screens/splash.dart';
import 'package:hartna1/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hartna1/admin/providers/category.dart';
import 'admin/providers/app2.dart';
import 'admin/providers/category.dart';
import 'admin/providers/product2.dart';
import 'admin/providers/restaurant2.dart';
import 'admin/providers/user2.dart'hide Status;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
        ChangeNotifierProvider.value(value: AppProvider2()),
        ChangeNotifierProvider.value(value: UserProvider2.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider10.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider2.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider2.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider5.initialize()),



      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
