import 'package:flutter/material.dart';
import 'package:kitchen/API/models.dart'; // Ganti dengan nama file model Anda
import 'package:kitchen/API/api_service.dart';
import 'package:kitchen/constants.dart';

class OrderCardApi extends StatefulWidget {
  @override
  _OrderCardApiState createState() => _OrderCardApiState();
}

class _OrderCardApiState extends State<OrderCardApi> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders();
  }

  double getCardWidth() {
    var screenWidth = MediaQuery.of(context).size.width;
    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return isLandscape ? screenWidth / 3 - 12 : screenWidth / 2 - 16;
  }

  @override
  Widget build(BuildContext context) {
    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

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
            print('Orders loaded: ${snapshot.data!.length}');
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: isLandscape ? 4.0 : 8.0,
                  runSpacing: isLandscape ? 8.0 : 10.0,
                  children: List.generate(snapshot.data!.length, (index) {
                    var order = snapshot.data![index];

                    return Padding(
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
                                color: OrderStatusColor, // Set your OrderStatusColor here
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Order - 00${order.queue}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: isLandscape ? 22.0 : 28.0,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${order.time}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: isLandscape ? 14.0 : 18.0,
                                            ),
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
                                        Flexible(
                                          child: Text(
                                            '${order.table}',
                                            style: TextStyle(
                                              fontSize: isLandscape ? 14.0 : 16.0,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${order.name}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: isLandscape ? 14.0 : 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    for (var item in order.items)
                                      ListTile(
                                        leading: Text('${item.quantity}'),
                                        title: Text(item.item),
                                        subtitle: Text(item.description),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add your button logic here
                                  },
                                  child: const Text(
                                    'Mark Done',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: OrderStatusColor, // Set your OrderStatusColor here
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
