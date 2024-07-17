import 'package:flutter/material.dart';
import 'package:kitchen/screen/components/appbar_section.dart';
import 'package:kitchen/screen/components/order_card.dart';
import 'package:kitchen/screen/components/category_filter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _selectedCategory = 'Semua';

  void _updateCategory(String newCategory) {
    setState(() {
      _selectedCategory = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CategoryFilter(
      selectedCategory: _selectedCategory,
      onCategoryChanged: _updateCategory,
      child: Scaffold(
        appBar: const BuildAppbar(),
        body: OrderCard(),
      ),
    );
  }
}
