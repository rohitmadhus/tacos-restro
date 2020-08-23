import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro/helpers/style.dart';
import 'package:restro/models/order.dart';
import 'package:restro/providers/user.dart';
import 'package:restro/widgets/custom_text.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "Sales: ₹${userProvider.totalSales}",
          color: white,
        ),
        actions: <Widget>[],
      ),
      body: ListView.builder(
          itemCount: userProvider.orders.length,
          itemBuilder: (_, index) {
            List<OrderModel> orders = userProvider.orders;
            return GestureDetector(
              onTap: () {
                if (true) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                        child: ListView.builder(
                                      itemCount: userProvider
                                          .orders[index].cart.length,
                                      itemBuilder: (_, id) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(userProvider
                                                .orders[index].cart[id].name),
                                            Text(userProvider
                                                .orders[index].cart[id].quantity
                                                .toString())
                                          ],
                                        );
                                      },
                                      shrinkWrap: true,
                                    )),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Confirm",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Close",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.red[400],
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      });
                  return;
                }
              },
              child: ListTile(
                leading: CustomText(
                  text: "₹ ${orders[index].total}",
                  weight: FontWeight.bold,
                ),
                title: Text(orders[index].description),
                subtitle: Text(
                    DateTime.fromMillisecondsSinceEpoch(orders[index].createdAt)
                        .toString()),
                trailing:
                    CustomText(text: orders[index].status, color: Colors.green),
              ),
            );
          }),
    );
  }
}
