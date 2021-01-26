import 'package:flutter/material.dart';
import 'package:hartna1/admin//helpers/category.dart';
import 'package:hartna1/admin//models/category.dart';

class CategoryProvider5 with ChangeNotifier{
  CategoryServices _categoryServices5 = CategoryServices();
  List<CategoryModel> categories5 = [];
  List<String> categoriesNames5 = [];
  String selectedCategory5;

  CategoryProvider5.initialize(){
    loadCategories();
  }

  loadCategories()async{
    categories5 = await _categoryServices5.getCategories();
    for(CategoryModel category in categories5){
      categoriesNames5.add(category.name);
      notifyListeners();

    }
    selectedCategory5 = categoriesNames5[0];
    notifyListeners();
  }

  changeSelectedCategory({String newCategory}){
    selectedCategory5 = newCategory;
    notifyListeners();
  }
}
