import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart';
import 'package:kitchen/data/done_data.dart';
import 'package:kitchen/data/order_data.dart'; // Pastikan import data orderData Anda
import 'package:kitchen/screen/components/category_filter.dart';
import 'package:kitchen/screen/components/order_item.dart';

class OrderCard extends StatefulWidget {
  final String selectedCategory;

  const OrderCard({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  // Tambahkan doneData untuk menyimpan order yang telah selesai

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 12.0,
          runSpacing: 12.0,
          children: List.generate(orderData.length, (index) {
            var order = orderData[index];
            bool shouldDisplay = widget.selectedCategory == 'Semua' ||
                orderContainsType(order, widget.selectedCategory);
            return shouldDisplay
                ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3 - 16, // Mengatur lebar card
                      child: Card(
                        elevation: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: OrderStatusColor,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order - 00${order['queue']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                      Text(
                                        '${order['time']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${order['table']}',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        '${order['name']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  for (var item in order['items'])
                                    if (widget.selectedCategory == 'Semua' ||
                                        item['type'] == widget.selectedCategory)
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
                                  setState(() {
                                    // Ubah status order menjadi "Done"
                                    order['status'] = 'Done';
                                    // Pindahkan order ke doneData
                                    doneData.add(order);
                                    // Hapus order dari orderData
                                    orderData.removeAt(index);
                                  });
                                },
                                child: const Text(
                                  'Mark Done',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: OrderStatusColor,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(); // Jangan tampilkan card jika tidak memenuhi kriteria
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
