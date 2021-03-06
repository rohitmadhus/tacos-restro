//to use file
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:restro/models/product.dart';
import 'package:uuid/uuid.dart';
import '../helpers/product.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsSearched = [];
  bool featured = false;

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  final picker = ImagePicker();
  File productImage;
  String productImageName;

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory =
        await _productServices.getProductsOfCategory(category: categoryName);
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

  Future search({String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");

    notifyListeners();
  }

  changeFeatured() {
    featured = !featured;
    notifyListeners();
  }

  //load file
  getImageFile({ImageSource source}) async {
    final pickedFile =
        await picker.getImage(source: source, maxHeight: 400, maxWidth: 640);
    // productImage = File(pickedFile.path);
    //path will return the path of image in phone
    //need to fix for by making unique image
    try {
      productImage = File(pickedFile.path);
      productImageName =
          productImage.path.substring(productImage.path.indexOf('/') + 1);
    } catch (e) {
      print(e.toString());
      productImageName = null;
      productImage = null;
    }
    notifyListeners();
  }

  // Upload file to firebase
  Future _uploadFileToFirebase({File imageFile, String imageFileName}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return imageUrl;
  }

  Future<bool> uploadProduct(
      {String category, String restaurant, String restaurantId}) async {
    try {
      String id = Uuid().v1();
      String imageUrl = await _uploadFileToFirebase(
          imageFile: productImage, imageFileName: id);
      Map data = {
        "id": id,
        "name": name.text.trim(),
        "image": imageUrl,
        "rates": 0,
        "rating": 0.0,
        "price": double.parse(price.text.trim()),
        "restaurant": restaurant,
        "restaurantId": restaurantId,
        "category": category,
        "description": description.text.trim(),
        "featured": featured
      };
      _productServices.createProduct(data: data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  clear() {
    productImage = null;
    productImageName = null;
    name = null;
    description = null;
    price = null;
    featured = false;
  }
}
