import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hartna1/scr/models/cart_item.dart';
import 'package:hartna1/scr/models/cart_item.dart';
import 'package:hartna1/scr/models/order.dart';

class OrderServices{
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder({String numberSub, String userId ,String id,String description,String status ,List<CartItemModel> cart, int totalPrice}) {
   List<Map> convertedCart = [];
   List<String> restaurantIds = [];

   for(CartItemModel item in cart){
     convertedCart.add(item.toMap());
     restaurantIds.add(item.restaurantId);
   }


    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "numberSub": numberSub,
      "id": id,
      "restaurantIds": restaurantIds,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId, String numberSub}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .where("numberSub", isEqualTo: numberSub)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });

}