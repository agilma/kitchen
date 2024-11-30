import 'package:flutter/material.dart';
import 'package:kitchen/features/authentication/login_screen.dart';
import 'package:kitchen/screen/done/done_screen.dart';
import 'package:kitchen/screen/order/order_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login';
  static const String orderScreen = '/order';
  static const String doneScreen = '/done';


  static Map<String, WidgetBuilder> routes = {
    orderScreen: (context) => OrderScreen(),
    loginScreen: (context) => LoginScreen(),
    doneScreen: (context) => DoneScreen(),
  };
}
