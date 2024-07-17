import 'package:flutter/material.dart';
import 'package:kitchen/data/order_data.dart'; // Pastikan import data orderData Anda
import 'package:kitchen/screen/components/category_filter.dart';
import 'package:kitchen/screen/components/order_item.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key? key,
  }) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    var categoryFilter = CategoryFilter.of(context);
    String _selectedCategory = categoryFilter?.selectedCategory ?? 'Semua';

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 12.0,
          runSpacing: 12.0,
          children: List.generate(orderData.length, (index) {
            var order = orderData[index];
            bool shouldDisplay = _selectedCategory == 'Semua' || orderContainsType(order, _selectedCategory);

            return shouldDisplay ? Container(
              width: MediaQuery.of(context).size.width / 3 - 16, // Mengatur lebar card
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
                              Icon(
                                Icons.soup_kitchen,
                                color: Colors.white,
                                size: 30,
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
                            if (_selectedCategory == 'Semua' || item['type'] == _selectedCategory)
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
                          // Implement action
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
            ) : SizedBox(); // Jangan tampilkan card jika tidak memenuhi kriteria
          }),
        ),
      ),
    );
  }

  bool orderContainsType(Map<String, dynamic> order, String type) {
    for (var item in order['items']) {
      if (item['type'] == type) {
        return true;
      }
    }
    return false;
  }
}
