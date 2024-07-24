import 'package:flutter/material.dart';
import 'package:kitchen/API/models.dart'; // Ganti dengan nama file model Anda
import 'package:kitchen/API/api_service.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders List'),
      ),
      body: FutureBuilder<List<Order>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                print('Order items: ${order.items}'); // Logging data items sebelum pengecekan
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text(order.name),
                    subtitle: Text(order.status),
                    trailing: Text(order.table),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Queue: ${order.queue}'),
                            Text('Time: ${order.time}'),
                            SizedBox(height: 10),
                            if (order.items.isNotEmpty) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: order.items.map((item) {
                                  print('Rendering item: ${item.item}');
                                  return ListTile(
                                    title: Text(item.item),
                                    subtitle: Text(item.description),
                                    trailing: Text('${item.quantity} x ${item.type}'),
                                  );
                                }).toList(),
                              )
                            ] else ...[
                              Text('No items found for this order')
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
