import 'package:hartna1/scr/helpers/category.dart';
import 'package:hartna1/scr/models/category.dart';
import 'package:flutter/material.dart';


class CategoryProvider10 with ChangeNotifier{
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];

  CategoryProvider10.initialize(){
    loadCategories();
  }

  loadCategories()async{
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}