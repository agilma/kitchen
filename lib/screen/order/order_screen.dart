import 'package:flutter/material.dart';
import 'package:kitchen/screen/components/order_card.dart';

class OrderScreen extends StatelessWidget {
  final String selectedCategory;
  final List<Map<String, dynamic>> dataOrder; // Tambahkan parameter ini

  const OrderScreen({Key? key, required this.selectedCategory, required this.dataOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderCard(selectedCategory: selectedCategory, dataOrder: dataOrder), // Pastikan OrderCard menerima dataOrder
    );
  }
}
