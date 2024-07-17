import 'package:flutter/material.dart';
import 'package:kitchen/data/done_data.dart'; // Pastikan import data doneData Anda
import 'package:kitchen/screen/components/done_item.dart';

class DoneCard extends StatefulWidget {
  final String selectedCategory;

  const DoneCard({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  _DoneCardState createState() => _DoneCardState();
}

class _DoneCardState extends State<DoneCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 12.0,
          runSpacing: 12.0,
          children: List.generate(doneData.length, (index) {
            var order = doneData[index];
            bool shouldDisplay = widget.selectedCategory == 'Semua' || orderContainsType(order, widget.selectedCategory);

            return shouldDisplay ? Container(
              width: MediaQuery.of(context).size.width / 3 - 16, // Mengatur lebar card
              child: Card(
                elevation: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.blue,
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
                                  fontSize: 22.0,
                                ),
                              ),
                              const Icon(
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
                              style: const TextStyle(
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
                                style: const TextStyle(
                                  fontSize: 16.0, // Assuming SecondHeader is 16.0
                                ),
                              ),
                              Text(
                                '${order['name']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0, // Assuming SecondHeader is 16.0
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          // Display DoneItem widgets for each order item
                          for (var item in order['items'])
                            if (widget.selectedCategory == 'Semua' || item['type'] == widget.selectedCategory)
                              DoneItem(
                                quantity: item['quantity'],
                                title: item['item'],
                                subtitle: item['description'],
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ) : const SizedBox(); // Jangan tampilkan card jika tidak memenuhi kriteria
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