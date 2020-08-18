import 'package:flutter/material.dart';
//import 'package:foodie/src/screens/home.dart';

import 'package:provider/provider.dart';
import 'package:restro/providers/app.dart';
import 'package:restro/providers/category.dart';
import 'package:restro/providers/product.dart';
import 'package:restro/providers/user.dart';
import 'package:restro/screens/dashboard.dart';
import 'package:restro/screens/login.dart';
import 'package:restro/widgets/loading.dart';

/*
** @author
** Rohit Madhu
*/

void main() {
  //To avoid white screen during opening
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        // ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return DashboardScreen();
      default:
        return LoginScreen();
    }
  }
}
