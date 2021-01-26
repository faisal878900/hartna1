import 'package:hartna1/scr/helpers/product.dart';
import 'package:hartna1/scr/models/products.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];





  ProductProvider.initialize(){
    loadProducts();
  }

  loadProducts()async{
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategoryAndRest({String categoryName, String restaurantId})async{
    productsByCategory = await _productServices.getProductsOfCategoryAndRest(category: categoryName, id: restaurantId);
    notifyListeners();
  }


  Future loadProductsByRestaurant({String restaurantId})async{
    productsByRestaurant = await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

//  likeDislikeProduct({String userId, ProductModel product, bool liked})async{
//    if(liked){
//      if(product.userLikes.remove(userId)){
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//      }else{
//        print("THE USER WA NOT REMOVED");
//      }
//    }else{
//
//      product.userLikes.add(userId);
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//
//
//      }
//  }

  Future search({String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");

    notifyListeners();
  }


}