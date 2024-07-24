import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart';
import 'package:kitchen/data/done_data.dart';
import 'package:kitchen/screen/components/order_item.dart';

class OrderCard extends StatefulWidget {
  final String selectedCategory;
  final List<Map<String, dynamic>> dataOrder;

  const OrderCard({
    Key? key,
    required this.selectedCategory,
    required this.dataOrder,
  }) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = screenWidth >= 600;

    int getColumnCount() {
      if (isTablet) {
        return 3;
      } else {
        return isLandscape ? 3 : 1;
      }
    }

    double getCardWidth() {
      int columnCount = getColumnCount();
      return (screenWidth / columnCount) - (16 * (columnCount - 1) / columnCount);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4.0,
          runSpacing: 10.0,
          children: List.generate(widget.dataOrder.length, (index) {
            var order = widget.dataOrder[index];
            bool shouldDisplay = widget.selectedCategory == 'Semua' ||
                orderContainsType(order, widget.selectedCategory);
            return shouldDisplay
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: getCardWidth(),
                      child: Card(
                        elevation: 8,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order - 00${order['queue']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28.0,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    // Hapus order dari dataOrder widget
                                    widget.dataOrder.removeAt(index);
                                  });
                                },
                                child: const Text(
                                  'Mark Done',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                : const SizedBox();
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
