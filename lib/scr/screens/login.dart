import 'package:hartna1/admin/screens/LoginAdmin.dart';
import 'package:hartna1/scr/providers/category10.dart';
import 'package:flutter/material.dart';
import 'package:hartna1/scr/helpers/screen_navigation.dart';
import 'package:hartna1/scr/helpers/style.dart';
import 'package:hartna1/scr/providers/product.dart';
import 'package:hartna1/scr/providers/restaurant.dart';
import 'package:hartna1/scr/providers/user.dart';
import 'package:hartna1/scr/screens/home.dart';
import 'package:hartna1/scr/screens/registration.dart';
import 'package:hartna1/scr/widgets/custom_text.dart';
import 'package:hartna1/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider10>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

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
                Image.asset("images/logo.png", width: 120, height: 120,),
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
                 controller: authProvider.email,
                 decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: "ايميل",
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
                        hintText: "كلمةالسر",
                        icon: Icon(Icons.lock)
                    ),
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()async{
                  if(!await authProvider.signIn()){
                    _key.currentState.showSnackBar(
                      SnackBar(content: Text("هناك خطأ!"))
                    );
                    return;
                  }
                  categoryProvider.loadCategories();
                  restaurantProvider.loadSingleRestaurant();
                  productProvider.loadProducts();
                  authProvider.clearController();
                  changeScreenReplacement(context, Home());
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
                        CustomText(text: "تسجيل", color: white, size: 22,)
                      ],
                    ),),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                changeScreen(context, RegistrationScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "اول مرة؟ سجل هنا", size: 20,),
                ],
              ),
            ),
              GestureDetector(
              onTap: (){
             changeScreen(context, LoginAdmin());
                },
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                 CustomText(text: "حساب خاص", size: 20,),
          ],
        ),
      ),
    ]
    )
      )
    );
  }
}
