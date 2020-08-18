import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restro/models/cartItem.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  static const RESTAURANT_ID = "restautantId";

//private inside the class
  String _id;
  String _restautantId;
  String _description;
  String _userId;
  int _total;
  String _status;
  int _createdAt;

//getter to access outside the class without editing

  String get id => _id;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;
  String get restaurantId => _restautantId;

  //public variable
  List<CartItemModel> cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _description = snapshot.data[DESCRIPTION];
    _userId = snapshot.data[USER_ID];
    _status = snapshot.data[STATUS];
    _total = snapshot.data[TOTAL];
    _createdAt = snapshot.data[CREATED_AT];
    _restautantId = snapshot.data[RESTAURANT_ID];
    cart = _convertCartItems(snapshot.data[CART]);
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
