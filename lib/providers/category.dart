import 'package:flutter/material.dart';
import '../helpers/category.dart';
import '../models/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];
  List<String> categoriesName = [];
  String selectedCategory;

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    categories = await _categoryServices.getCategories();
    for (CategoryModel category in categories) {
      categoriesName.add(category.name);
    }
    selectedCategory = categoriesName[0];
    notifyListeners();
  }

  changeCategoryName({String selectedCategory}) {
    selectedCategory = selectedCategory;
    notifyListeners();
  }
}
