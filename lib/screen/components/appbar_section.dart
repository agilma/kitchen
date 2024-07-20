import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart';
import 'package:kitchen/data/order_data.dart';
import 'package:kitchen/screen/components/category_filter.dart';

class BuildAppbar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const BuildAppbar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.selectedCategory,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  State<BuildAppbar> createState() => _BuildAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _BuildAppbarState extends State<BuildAppbar> {
  List<Map<String, dynamic>> dataOrder = []; // Inisialisasi array kosong

  @override
  void initState() {
    super.initState();
    _loadInitialData(); // Muat data saat inisialisasi
  }

  void _loadInitialData() {
    setState(() {
      dataOrder = List.from(orderData); // Memuat data dari file terpisah
    });
  }

   List<Map<String, dynamic>> _fetchOrderData() {
    // Fungsi ini bisa disesuaikan jika Anda memiliki logika untuk memuat data baru.
    return List.from(dataOrder);
  }

  void _refreshData() {
    setState(() {
      dataOrder = _fetchOrderData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HeaderColor,
      toolbarHeight: 60,
      title: Row(
        children: [
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 40,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/kitchenlogo2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Text(
            "Kitchen",
            style: TextStyle(
              fontSize: 40, // Menurunkan ukuran font agar lebih responsif
              fontWeight: FontWeight.w800,
              color: Color(0xFFFEFEFE),
            ),
          ),
          const SizedBox(width: 20), // Memberikan sedikit jarak antara teks dan dropdown
          Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFEFEFE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButton<String>(
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
                value: widget.selectedCategory,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    widget.onCategoryChanged(newValue);
                  }
                },
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                items: ['Semua', 'Makanan', 'Minuman', 'Snack', 'Item']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.transparent),
            ),
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(16),
              fillColor: Colors.transparent,
              selectedColor: Color(0xFFFEFEFE),
              color: Color(0xFFFEFEFE),
              borderWidth: 1,
              isSelected: [widget.selectedIndex == 0, widget.selectedIndex == 1],
              onPressed: (int index) {
                widget.onItemTapped(index);
              },
              children: <Widget>[
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.selectedIndex == 0 ? OrderStatusColor : Color(0xFFFEFEFE),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Order',
                      style: TextStyle(
                          color: widget.selectedIndex == 0 ? Color(0xFFFEFEFE) : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.selectedIndex == 1 ? DoneStatusColor : Color(0xFFFEFEFE),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Selesai',
                      style: TextStyle(
                          color: widget.selectedIndex == 1 ? Color(0xFFFEFEFE) : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: _refreshData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFEFEFE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: Size(50, 40),
            ),
            child: const Icon(
              Icons.refresh,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // Add your settings functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFEFEFE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: Size(50, 40),
            ),
            child: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
