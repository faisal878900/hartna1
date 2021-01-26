import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hartna1/scr/models/restaurant.dart';
import '../models/products.dart';

class ProductServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
  Future<List<ProductModel>> getProducts() async {
    List<RestLoc>  restLoc=await getAllRestaurants();
    List<ProductModel> products = new List<ProductModel>();
    QuerySnapshot snapshot=await _firestore.collection(collection).get();
    for(int i=0;i<snapshot.docs.length;i++){
        bool comply = await isProductOfRestaurant(
            restLoc, snapshot.docs[i].data()["restaurantId"]);
        if (comply) {
          products.add(ProductModel.fromSnapshot(snapshot.docs[i]));
        }

    }
    print("+++++++++++++ length is = ${products.length}");
    return products;
  }
  void likeOrDislikeProduct({String id, List<String> userLikes}){
    _firestore.collection(collection).doc(id).update({
      "userLikes": userLikes
    });
  }

  Future<List<ProductModel>> getProductsByRestaurant({String id}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: id)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getProductsOfCategoryAndRest({String category, String id }) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .where("restaurantId", isEqualTo: id)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });


  Future<List<ProductModel>> searchProducts({String productName}) async{
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    List<RestLoc>  restLoc=await getAllRestaurants();

    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) async{
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            for (DocumentSnapshot product in result.docs) {
              bool comply = await isProductOfRestaurant(
                  restLoc, product.data()["restaurantId"]);

              if (comply)
                products.add(ProductModel.fromSnapshot(product));
            }
          }
          return products;
        });
  }
  Future<bool> isProductOfRestaurant(List<RestLoc>  res,String id) async{
    bool present=false;
    int found=-1;
    Position pos = await _determinePosition();
    double dist=0;
    for(int i=0;i<res.length;i++){

      if(id==res[i].id){
        found=i;
        break;
      }
    }

    if(found!=-1){
      dist=Geolocator.distanceBetween(pos.latitude, pos.longitude,res[found].lat, res[found].long);
      dist=dist/1000;

      if(dist<=1.2){
        present=true;
      }
    }
    return present;
  }
    Future<List<RestLoc>> getAllRestaurants() async {
      List<RestLoc> resList=[];
      QuerySnapshot snapshot=await _firestore.collection("restaurants").get();
      for(int i=0;i<snapshot.docs.length;i++){
        resList.add(new RestLoc(lat:snapshot.docs[i].get("lat"),long: snapshot.docs[i].get("long"),id: snapshot.docs[i].get("id")));
      }
      return resList;
    }
}
