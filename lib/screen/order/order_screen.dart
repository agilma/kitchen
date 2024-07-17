import 'package:flutter/material.dart';
import 'package:kitchen/screen/components/order_card.dart';

class OrderScreen extends StatelessWidget {
  final String selectedCategory;

  const OrderScreen({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderCard(selectedCategory: selectedCategory),
    );
  }
}
