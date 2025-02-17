import 'package:hartna1/scr/providers/category10.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hartna1/scr/helpers/screen_navigation.dart';
import 'package:hartna1/scr/helpers/style.dart';
import 'package:hartna1/scr/providers/app.dart';
import 'package:hartna1/scr/providers/product.dart';
import 'package:hartna1/scr/providers/restaurant.dart';
import 'package:hartna1/scr/providers/user.dart';
import 'package:hartna1/scr/screens/cart.dart';
import 'package:hartna1/scr/screens/category.dart';
import 'package:hartna1/scr/screens/login.dart';
import 'package:hartna1/scr/screens/order.dart';
import 'package:hartna1/scr/screens/product_search.dart';
import 'package:hartna1/scr/screens/restaurant.dart';
import 'package:hartna1/scr/screens/restaurants_search.dart';
import 'package:hartna1/scr/widgets/categories.dart';
import 'package:hartna1/scr/widgets/custom_text.dart';
import 'package:hartna1/scr/widgets/featured_products.dart';
import 'package:hartna1/scr/widgets/loading.dart';
import 'package:hartna1/scr/widgets/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    restaurantProvider.loadSingleRestaurant();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "حارتنا",
          color: white,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton( 
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, CartScreen());
                },
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primary),
              accountName: CustomText(
                text: user.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),

            ListTile(
              onTap: () async{
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "طلباتي "),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "العربية"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "تسجيل الخروج"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Loading()],
        ),
      )
          : SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: red,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern)async{
                        app.changeLoading();
                        if(app.search == SearchBy.PRODUCTS){
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        }else{
                          await restaurantProvider.search(name: pattern);
                          changeScreen(context, RestaurantsSearchScreen());
                        }
                        app.changeLoading();
                      },
                      decoration: InputDecoration(
                        hintText: "ابحث عن منتج",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomText(text: "Search by:", color: grey, weight: FontWeight.w300,),
                DropdownButton<String>(
                  value: app.filterBy,
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w300
                  ),
                  icon: Icon(Icons.filter_list,
                    color: primary,),
                  elevation: 0,
                  onChanged: (value){
                    if (value == "Products"){
                      app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                    }else{
                      app.changeSearchBy(newSearchBy: SearchBy.RESTAURANTS);
                    }
                  },
                  items: <String>["Products", "Restaurants"].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value));
                  }).toList(),

                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: "بقالات قريبة",
                    size: 20,
                    color: grey,
                  ),
                ],
              ),
            ),
            Column(
              children: restaurantProvider.restaurants
                  .map((item) => GestureDetector(
                onTap: () async {
                  app.changeLoading();

                  await productProvider.loadProductsByRestaurant(
                      restaurantId: item.id);
                  app.changeLoading();

                  changeScreen(
                      context,
                      RestaurantScreen(
                        restaurantModel: item,
                      ));
                },
                child: RestaurantWidget(
                  restaurant: item,
                ),
              ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}