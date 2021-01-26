import 'package:flutter/material.dart';
import 'package:hartna1/admin/helpers/style.dart';
import 'package:hartna1/admin/models/cart_item.dart';
import 'package:hartna1/admin/providers/user2.dart';
import 'package:hartna1/admin/widget/custom_text.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider2>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView.builder(
          itemCount: userProvider.cartItems.length,
          itemBuilder: (_, index){
            List<CartItemModel> cart = userProvider.cartItems;
            return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
            height: 130,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
            boxShadow: [
            BoxShadow(
            color: red.withOpacity(0.2),
            offset: Offset(3, 2),
            blurRadius: 30)
            ]),
            child: Row(
            children: <Widget>[
                ClipRRect(
                borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
              child: Image.network(
                cart[index].image,
                height: 120,
                width: 140,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
            width: 10,
            ),
            Expanded(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            RichText(
            text: TextSpan(children: [
            TextSpan(
            text: cart[index].name+ "\n",
            style: TextStyle(
            color: black,
            fontSize: 20,
            fontWeight: FontWeight.bold)),

            TextSpan(
            text: "\$${cart[index].price / 100} \n",
            style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w300)),
              TextSpan(
                  text: cart[index].numberSubb+ "\n",
                  style: TextStyle(
                      color: black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            TextSpan(
            text: "الكمية: ",
            style: TextStyle(
            color: grey,
            fontSize: 16,
            fontWeight: FontWeight.w400)),
            TextSpan(
            text: cart[index].quantity.toString()+ "\n",
            style: TextStyle(
            color: primary,
            fontSize: 16,
            fontWeight: FontWeight.w400)),
              TextSpan(
                  text: (DateTime.fromMillisecondsSinceEpoch(cart[index].date).toString()),
                  style: TextStyle(
                      color: black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ]),


            ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: red,
                  ),
                  onPressed: (){

                    }
                  )

            ],
            ),
            )
            ],
            ),
            ),
            );
          }),
    );
  }
}
