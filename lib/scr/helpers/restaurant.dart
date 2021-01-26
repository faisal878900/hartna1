import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../models/restaurant.dart';

class RestaurantServices {
  String collection = "restaurants";
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
  Future<List<RestaurantModel>> getRestaurants() async {
    Position pos = await _determinePosition();
    double dist=0;
    return _firestore.collection(collection).get().then((result) {
      List<RestaurantModel> restaurants = [];
      for (DocumentSnapshot restaurant in result.docs) {
        dist=Geolocator.distanceBetween(pos.latitude, pos.longitude,restaurant.data()['lat'] , restaurant.data()['long']);
        dist=dist/1000;
        print("distance =======> $dist");
        if(dist<=1.2) {
          RestaurantModel rs = RestaurantModel.fromSnapshot(restaurant);
          rs.distance = dist;
          restaurants.add(rs);
        }
      }
      return restaurants;
    });
  }

  Future<RestaurantModel> getRestaurantById({String id}) => _firestore.collection(collection).doc(id.toString()).get().then((doc){
    if(doc.data()!=null)
      return RestaurantModel.fromSnapshot(doc);
    return null;
  });

  Future<List<RestaurantModel>> searchRestaurant({String restaurantName}) async {
    // code to convert the first character to uppercase
    String searchKey =restaurantName;
    Position pos = await _determinePosition();
    double dist=0;
    return await _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) async{
      List<RestaurantModel> restaurants = [];
      print("ethy poncha");
      for (DocumentSnapshot product in result.docs) {

        dist=Geolocator.distanceBetween(pos.latitude, pos.longitude,product.data()['lat'] , product.data()['long']);
        dist=dist/1000;
        print("distance =======> $dist");
        if(dist<=1.2) {
          RestaurantModel rs = RestaurantModel.fromSnapshot(product);
          rs.distance = dist;
          restaurants.add(rs);
        }
      }
      return restaurants;
    });
  }


}