import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restro/models/product.dart';

class ProductServices {
  String collection = "products";
  Firestore _firestore = Firestore.instance;

  // ignore: missing_return
  Future createProduct({Map data}) {
    _firestore.collection(collection).document(data['id']).setData({
      "id": data["id"],
      "image": data["image"],
      "rates": data["rates"],
      "rating": data["rating"],
      "price": data["price"],
      "restaurant": data["restaurant"],
      "restaurantId": data["restaurantId"],
      "category": data["category"],
      "description": data["description"],
      "featured": data["featured"],
      "name": data["name"]
    });
  }

  void removeProduct({String id}) {
    _firestore.collection(collection).document(id).delete();
  }

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  void likeOrDislikeProduct({String id, List<String> userLikes}) {
    _firestore
        .collection(collection)
        .document(id)
        .updateData({"userLikes": userLikes});
  }

  Future<List<ProductModel>> getProductsByRestaurant({String id}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.documents) {
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
        });
  }
}
