import 'package:flutter/material.dart';
import 'package:hartna1/scr/helpers/screen_navigation.dart';
import 'package:hartna1/scr/helpers/style.dart';
import 'package:hartna1/scr/providers/product.dart';
import 'package:hartna1/scr/screens/details.dart';
import 'package:hartna1/scr/widgets/custom_text.dart';
import 'package:hartna1/scr/widgets/product.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: CustomText(text: "منتجاتي", size: 20,),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){})
        ],
      ),
      body: productProvider.productsSearched.length < 1? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search, color: grey, size: 30,),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(text: "مافي اي منتج", color: grey, weight: FontWeight.w300, size: 22,),
            ],
          )
        ],
      ) : ListView.builder(
          itemCount: productProvider.productsSearched.length,
          itemBuilder: (context, index){
            return GestureDetector(
                onTap: ()async{
                  changeScreen(context, Details(product: productProvider.productsSearched[index]));
                },
                child: ProductWidget(product: productProvider.productsSearched[index]));
          }),
    );
  }
}
