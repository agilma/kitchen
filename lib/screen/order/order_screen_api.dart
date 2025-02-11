import 'package:flutter/material.dart';
import 'package:kitchen/screen/components/order_card.dart';

class OrderScreenApi extends StatefulWidget {
  final String selectedCategory;
  final List<Map<String, dynamic>> dataOrder;

  const OrderScreenApi({
    Key? key,
    required this.selectedCategory,
    required this.dataOrder,
  }) : super(key: key);

  @override
  _OrderScreenApiState createState() => _OrderScreenApiState();
}

class _OrderScreenApiState extends State<OrderScreenApi> {
  double _opacity = 1.0;

  @override
  void didUpdateWidget(OrderScreenApi oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dataOrder != widget.dataOrder) {
      _fadeOutIn();
    }
  }

  void _fadeOutIn() async {
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: OrderCard(
            selectedCategory: widget.selectedCategory,
            dataOrder: widget.dataOrder,
          ),
        ),
      ),
    );
  }
}
