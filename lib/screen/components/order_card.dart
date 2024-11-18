import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart';
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
  final List<GlobalKey> _cardKeys = [];
  final List<double> _cardHeights = [];
  final Map<int, double> _maxHeightPerRow = {}; // Variable to store max height per row

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

    if (isLandscape || isTablet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _maxHeightPerRow.clear(); // Clear previous row heights

        // Calculate heights for each card
        for (int i = 0; i < _cardKeys.length; i++) {
          final key = _cardKeys[i];
          final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            final size = renderBox.size;
            _cardHeights[i] = size.height;
          }
        }

        // Determine max height for each row
        final int cardsPerRow = 3;
        for (int i = 0; i < _cardHeights.length; i += cardsPerRow) {
          final end = (i + cardsPerRow <= _cardHeights.length) ? i + cardsPerRow : _cardHeights.length;
          final rowHeights = _cardHeights.sublist(i, end);
          final maxRowHeight = rowHeights.reduce((a, b) => a > b ? a : b);
          final rowIndex = i ~/ cardsPerRow;
          _maxHeightPerRow[rowIndex] = maxRowHeight;
        }

        // Redraw the widget to apply the new heights
        setState(() {});
      });
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: isLandscape ? 4.0 : 8.0,
          runSpacing: isLandscape ? 8.0 : 10.0,
          children: List.generate(widget.dataOrder.length, (index) {
            var order = widget.dataOrder[index];
            bool shouldDisplay = widget.selectedCategory == 'All Station' ||
                orderContainsStation(order, widget.selectedCategory);

            if (_cardKeys.length <= index) {
              _cardKeys.add(GlobalKey());
              _cardHeights.add(0.0); // Initialize heights list
            }

            // Calculate the row index for the current card
            final int cardsPerRow = 3;
            final int rowIndex = index ~/ cardsPerRow;
            final double? rowHeight = _maxHeightPerRow[rowIndex];

            return shouldDisplay
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      key: _cardKeys[index], // Assign key here
                      width: getCardWidth(),
                      height: (isLandscape || isTablet) ? rowHeight : null, // Apply the height of the row if landscape or tablet
                      child: Card(
                        elevation: 8,
                        child: SingleChildScrollView(
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
                                        Flexible(
                                          child: Text(
                                            'Order - 00${order['queue']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: isLandscape ? 20.0 : 24.0,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${order['time']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: isLandscape ? 12.0 : 16.0,
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
                                            '${order['table']}',
                                            style: TextStyle(
                                              fontSize: isLandscape ? 12.0 : 14.0,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${order['name']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: isLandscape ? 12.0 : 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    for (var item in order['items'])
                                      if (widget.selectedCategory == 'All Station' ||
                                          item['station'] == widget.selectedCategory)
                                        OrderItem(
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
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        ),
      ),
    );
  }

  bool orderContainsStation(Map<String, dynamic> order, String station) {
    for (var item in order['items']) {
      if (item['station'] == station) {
        return true;
      }
    }
    return false;
  }
}
