import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro/helpers/screen_navigation.dart';
import 'package:restro/helpers/style.dart';
import 'package:restro/providers/user.dart';
import 'package:restro/screens/addProduct.dart';
import 'package:restro/screens/orders.dart';
import 'package:restro/widgets/custom_text.dart';
import 'package:restro/widgets/imagePlaceHolder.dart';
import 'package:restro/widgets/product.dart';
import 'package:restro/widgets/small_floating_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    bool hasImage = false;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0.5,
        backgroundColor: white,
        title: CustomText(
          text: "Sales: ₹${userProvider.totalSales}",
          color: white,
        ),
        actions: <Widget>[],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primary),
              accountName: CustomText(
                text: userProvider.restaurant?.name ?? "",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.user.email ?? "",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.restaurant),
              title: CustomText(text: "Restaurant"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
//                  Positioned.fill(
//                      child: Align(
//                        alignment: Alignment.center,
//                        child: Loading(),
//                      )),

              // restaurant image
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: ImagePlaceHolderWidget(hasImage: hasImage)),

              // fading black
              Container(
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ],
                    )),
              ),

              //restaurant name
              Positioned.fill(
                  bottom: 40,
                  left: 20,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                        text: userProvider.restaurant?.name ?? "",
                        color: white,
                        size: 20,
                        weight: FontWeight.bold,
                      ))),

              // average price
              Positioned.fill(
                  bottom: 20,
                  left: 20,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                        text: "Average Price: ₹ ${userProvider.avgPrice}",
                        color: white,
                        size: 15,
                        weight: FontWeight.w300,
                      ))),

              // Edit button
              Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: black.withOpacity(0.3)),
                            child: FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: white,
                                ),
                                label: CustomText(
                                  text: "Edit",
                                  color: white,
                                ))),
                      ),
                    ),
                  )),
              // rating
              Positioned.fill(
                  bottom: 2,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                                size: 20,
                              ),
                            ),
                            Text(".."),
                          ],
                        ),
                      ),
                    ),
                  )),

              //like button
              Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {},
                        child: SmallButton(Icons.favorite),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-2, -1),
                          blurRadius: 5),
                    ]),
                child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset("images/delivery.png"),
                    ),
                    title: CustomText(
                      text: "Orders To Approve",
                      size: 20,
                    ),
                    trailing: CustomText(
                      text: userProvider.orders.length.toString(),
                      size: 20,
                      weight: FontWeight.bold,
                      color: red,
                    )),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-2, -1),
                          blurRadius: 5),
                    ]),
                child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset("images/fd.png"),
                    ),
                    title: CustomText(
                      text: "Total Food",
                      size: 20,
                    ),
                    trailing: CustomText(
                      text: userProvider.productsByRestaurant.length.toString(),
                      size: 20,
                      weight: FontWeight.bold,
                    )),
              ),
            ),
          ),

          //products
          Column(
            children: userProvider.productsByRestaurant == null
                ? [GestureDetector(child: Text("no products"))]
                : userProvider.productsByRestaurant
                    .map((item) => GestureDetector(
                          onTap: () {
                            // changeScreen(
                            //     context,
                            //     Details(
                            //       product: item,
                            //     ));
                          },
                          child: ProductWidget(
                            product: item,
                          ),
                        ))
                    .toList(),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeScreen(context, AddProductScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: primary,
        tooltip: 'Add Product',
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.home),
                        Text(
                          "Home",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    changeScreen(context, OrderScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Text(
                          "Orders",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text(
                          "Cart",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.person),
                        Text(
                          "Profile",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
