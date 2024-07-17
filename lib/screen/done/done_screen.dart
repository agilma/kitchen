import 'package:flutter/material.dart';
import 'package:kitchen/screen/components/done_card.dart';
import 'package:kitchen/screen/components/order_card.dart';

class DoneScreen extends StatelessWidget {
  final String selectedCategory;

  const DoneScreen({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoneCard(selectedCategory: selectedCategory),
    );
  }
}
