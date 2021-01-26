import 'package:flutter/material.dart';
import 'package:hartna1/admin//helpers/restaurant.dart';
import 'package:hartna1/admin//models/restaurant.dart';

class RestaurantProvider2 with ChangeNotifier{
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantModel restaurant;

  RestaurantProvider2.initialize(){
    loadRestaurants();
  }

  loadRestaurants()async{
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String retaurantId}) async{
    restaurant = await _restaurantServices.getRestaurantById(id: retaurantId);
    notifyListeners();
  }

  Future search({String name})async{
    searchedRestaurants = await _restaurantServices.searchRestaurant(restaurantName: name);
    print("RESTOS ARE: ${searchedRestaurants.length}");
    notifyListeners();
  }
}