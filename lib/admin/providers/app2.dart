import 'package:flutter/material.dart';


class AppProvider2 with ChangeNotifier{
  bool isLoading2 = false;

  void changeLoading(){
    isLoading2 = !isLoading2;
    notifyListeners();
  }
}