import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hartna1/scr/helpers/screen_navigation.dart';
import 'package:hartna1/scr/models/products.dart';
import 'package:hartna1/scr/providers/app.dart';
import 'package:hartna1/scr/providers/user.dart';
import 'package:hartna1/scr/screens/cart.dart';
import 'package:hartna1/scr/widgets/custom_text.dart';
import 'package:hartna1/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';


import '../helpers/style.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});


  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),

        ],
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){Navigator.pop(context);}),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: app.isLoading ? Loading() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(widget.product.image),
            ),
            SizedBox(height: 15,),

            CustomText(text: widget.product.name,size: 26,weight: FontWeight.bold),
            CustomText(text: "${widget.product.price / 100}",size: 20,weight: FontWeight.w400),
            SizedBox(height: 10,),

            CustomText(text: "الوصف غير متوفر حاليا",size: 18,weight: FontWeight.w400),

            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(widget.product.description??'default value' , textAlign: TextAlign.center, style: TextStyle(color: grey, fontWeight: FontWeight.w300),),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.remove,size: 36,), onPressed: (){
                    if(quantity != 1){
                      setState(() {
                        quantity -= 1;
                      });
                    }
                  }),
                ),
                GestureDetector(
                  onTap: ()async{
                    print("All set loading");
                    bool value =  await user.addToCard(product: widget.product, quantity: quantity);
                    if(value){
                      print("Item added to cart");
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("تمت اضافة المنتج الى سلتك!")));
                      user.reloadUserModel();

                      return;
                    } else{
                      print("Item NOT added to cart");

                    }
                    print("lOADING SET TO FALSE");

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: app.isLoading ? Loading() : Padding(
                      padding: const EdgeInsets.fromLTRB(28,12,28,12),
                      child: CustomText(text: "اضف $quantity الى العربية",color: white,size: 22,weight: FontWeight.w300,),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.add,size: 36,color: red,), onPressed: (){
                    setState(() {
                      quantity += 1;
                    });
                  }),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
