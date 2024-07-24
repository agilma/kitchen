class Item {
  final String id;
  final String idOrderan;  // This should match the JSON key, even if the property name is different
  final int quantity;
  final String item;
  final String description;
  final String type;

  Item({
    required this.id,
    required this.idOrderan,
    required this.quantity,
    required this.item,
    required this.description,
    required this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    print('Parsing Item JSON: $json');
    return Item(
      id: json['id'] ?? '',
      idOrderan: json['orderDataId'] ?? '',  // Map to the correct JSON key
      quantity: json['quantity'] ?? 0,
      item: json['item'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class Order {
  final String idOrderan;
  final String queue;
  final String time;
  final String status;
  final String table;
  final String name;
  final List<Item> items;

  Order({
    required this.idOrderan,
    required this.queue,
    required this.time,
    required this.status,
    required this.table,
    required this.name,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    print('Parsing Order JSON: $json');
    var list = json['Items'] as List? ?? []; // Ensure the key matches the JSON response
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();
    print('Parsed Items: $itemsList');

    return Order(
      idOrderan: json['id_orderan']?.toString() ?? '',
      queue: json['queue']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      status: json['status'] ?? '',
      table: json['table'] ?? '',
      name: json['name'] ?? '',
      items: itemsList,
    );
  }
}
