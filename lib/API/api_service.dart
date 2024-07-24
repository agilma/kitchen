import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitchen/API/models.dart'; // Ganti dengan nama file model Anda

Future<List<Order>> fetchOrders() async {
  final response = await http.get(Uri.parse('https://669f297cb132e2c136fce3f6.mockapi.io/orderData'));

  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
    List<dynamic> data = json.decode(response.body);
    if (data == null) {
      print('Data is null');
      return [];
    }
    List<Order> orders = data.map((json) => Order.fromJson(json)).toList();
    print('Parsed Orders: $orders');
    return orders;
  } else {
    throw Exception('Failed to load orders');
  }
}

