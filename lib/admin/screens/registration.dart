import 'package:hartna1/admin/providers/app2.dart';
import 'package:hartna1/admin/providers/category.dart';
import 'package:hartna1/admin/providers/product2.dart';
import 'package:hartna1/admin/providers/restaurant2.dart';
import 'package:flutter/material.dart';
import 'package:hartna1/admin/helpers/screen_navigation.dart';
import 'package:hartna1/admin/helpers/style.dart';
import 'package:hartna1/admin/providers/user2.dart';
import 'package:hartna1/admin/screens/dashboard.dart';
import 'package:hartna1/admin/widget/custom_text.dart';
import 'package:hartna1/admin/widget/loading.dart';
import 'package:provider/provider.dart';

import 'LoginAdmin.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider2>(context);
    final categoryProvider = Provider.of<CategoryProvider5>(context);
    final restaurantProvider = Provider.of<RestaurantProvider2>(context);
    final productProvider = Provider.of<ProductProvider2>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/logo.png", width: 100, height: 100,),
              ],
            ),

            SizedBox(
              height: 40,
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Restaurant name",
                        icon: Icon(Icons.restaurant)
                    ),
                  ),),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.email,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Emails",
                        icon: Icon(Icons.email)
                    ),
                  ),),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.password,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock)
                    ),
                  ),),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()async{
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");

                  if(!await authProvider.signUp()){
                    _key.currentState.showSnackBar(
                        SnackBar(content: Text("Resgistration failed!"))
                    );
                    return;
                  }
//                  categoryProvider.loadCategories();
//                  restaurantProvider.loadSingleRestaurant();
//                  productProvider.loadProducts();
                  authProvider.clearController();
                  changeScreenReplacement(context, DashboardScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: red,
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text: "Resgister", color: white, size: 22,)
                      ],
                    ),),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                changeScreen(context, LoginAdmin());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "login here here", size: 20,),
                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}
