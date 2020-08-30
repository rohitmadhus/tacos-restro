import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restro/helpers/screen_navigation.dart';
import 'package:restro/helpers/style.dart';
import 'package:restro/providers/app.dart';
import 'package:restro/providers/category.dart';
import 'package:restro/providers/product.dart';
import 'package:restro/providers/user.dart';
import 'package:restro/screens/dashboard.dart';
import 'package:restro/widgets/customFileButton.dart';
import 'package:restro/widgets/custom_text.dart';
import 'package:restro/widgets/loading.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: white,
          title: Text(
            "Add Product",
            style: TextStyle(color: black),
          )),
      body: app.isLoading
          ? Loading()
          : ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: productProvider.productImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(productProvider.productImage))
                            : CustomFileUploadButton(
                                icon: Icons.image,
                                text: "Add image",
                                onTap: () async {
                                  //productProvider.loadImageFile();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          child: new Wrap(
                                            children: <Widget>[
                                              new ListTile(
                                                  leading:
                                                      new Icon(Icons.image),
                                                  title: new Text('Gallery'),
                                                  onTap: () async {
                                                    productProvider
                                                        .getImageFile(
                                                            source: ImageSource
                                                                .gallery);
                                                    Navigator.pop(context);
                                                  }),
                                              new ListTile(
                                                leading:
                                                    new Icon(Icons.camera_alt),
                                                title: new Text('Camera'),
                                                onTap: () {
                                                  productProvider.getImageFile(
                                                      source:
                                                          ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                      ),
                      // Visibility(
                      //     visible: productProvider?.productImage == null
                      //         ? false
                      //         : true,
                      //     child: Image.file(productProvider.productImage))
                    ],
                  ),
                ),
                Visibility(
                  visible: productProvider.productImage != null,
                  child: FlatButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: new Wrap(
                                  children: <Widget>[
                                    new ListTile(
                                        leading: new Icon(Icons.image),
                                        title: new Text('Gallery'),
                                        onTap: () async {
                                          productProvider.getImageFile(
                                              source: ImageSource.gallery);
                                          Navigator.pop(context);
                                        }),
                                    new ListTile(
                                      leading: new Icon(Icons.camera_alt),
                                      title: new Text('Camera'),
                                      onTap: () {
                                        productProvider.getImageFile(
                                            source: ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text(
                        "Change Image",
                        style: TextStyle(color: grey),
                      )),
                ),
                Divider(),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomText(text: "featured"),
                        Switch(
                            value: productProvider.featured,
                            onChanged: (value) {
                              productProvider.changeFeatured();
                            })
                      ],
                    )),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomText(
                      text: "Category:",
                      color: grey,
                      weight: FontWeight.w300,
                    ),
                    DropdownButton<String>(
                      value: categoryProvider.selectedCategory,
                      style: TextStyle(
                          color: primary, fontWeight: FontWeight.w300),
                      icon: Icon(
                        Icons.filter_list,
                        color: primary,
                      ),
                      elevation: 0,
                      onChanged: (value) {
                        categoryProvider.changeCategoryName(
                            selectedCategory: value.trim());
                      },
                      items: categoryProvider.categoriesName
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.name,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Product name",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.description,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Product description",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Price",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                      decoration: BoxDecoration(
                          color: primary,
                          border: Border.all(color: black, width: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: grey.withOpacity(0.3),
                                offset: Offset(2, 7),
                                blurRadius: 4)
                          ]),
                      child: FlatButton(
                        onPressed: () async {
                          app.changeLoading();
                          if (!await productProvider.uploadProduct(
                              category: categoryProvider.selectedCategory,
                              restaurant: userProvider.restaurant.name,
                              restaurantId: userProvider.restaurant.id)) {
                            _key.currentState.showSnackBar(SnackBar(
                              content: Text("Upload Failed"),
                              duration: const Duration(seconds: 5),
                            ));
                            userProvider.loadProductsByRestaurant(
                                restaurantId: userProvider.restaurant.id);
                            await userProvider.reload();
                            app.changeLoading();
                            return;
                          }
                          userProvider.loadProductsByRestaurant(
                              restaurantId: userProvider.restaurant.id);
                          await userProvider.reload();
                          productProvider.clear();
                          _key.currentState.showSnackBar(SnackBar(
                            content: Text("Upload Success"),
                            duration: const Duration(seconds: 2),
                          ));
                          app.changeLoading();
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          text: "Upload Product",
                          color: white,
                        ),
                      )),
                ),
              ],
            ),
    );
  }
}
