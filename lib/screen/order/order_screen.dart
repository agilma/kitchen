import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart'; // Make sure to import constants.dart if needed.
import 'package:kitchen/data/order_data.dart'; // Import order_data.dart which contains the orderData variable.
import 'package:kitchen/screen/components/appbar_section.dart';
import 'package:kitchen/screen/components/order_item.dart';
import 'package:kitchen/screen/test.dart'; // Ensure BuildAppbar is implemented correctly.

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;

    return Scaffold(
      appBar: const BuildAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.vertical,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(orderData.length, (index) {
            var order = orderData[index];
            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      width: 350,
                      child: Card(
                        elevation: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order - 00${order['queue']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 8.0),
                                          Icon(
                                            Icons.soup_kitchen,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${order['date']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Table: ${order['table']}',
                                        style: TextStyle(
                                          fontSize: 16.0, // Assuming SecondHeader is 16.0
                                        ),
                                      ),
                                      Text(
                                        '${order['name']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0, // Assuming SecondHeader is 16.0
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  // Display OrderItem widgets for each order item
                                  for (var item in order['items'])
                                    OrderItem(
                                      quantity: item['quantity'],
                                      title: item['item'],
                                      subtitle: item['description'],
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle mark done action
                                },
                                child: Text(
                                  'Mark Done',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (constraints.maxHeight > screenHeight)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
