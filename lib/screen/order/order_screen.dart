import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart'; // Pastikan impor constants.dart jika diperlukan.

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isFirstSelected = true;
  String _selectedCategory = 'Semua'; // Nilai awal dropdown
  List<String> _categories = [
    'Semua',
    'Makanan',
    'Minuman',
    'Snack',
    'Item'
  ]; // Daftar pilihan dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            HeaderColor, // Gunakan HeaderColor dari constants.dart jika diperlukan
        toolbarHeight: 100,
        title: Row(
          children: [
            SizedBox(
              width: 10, // Spasi awal di sebelah kiri logo
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 50, // Set lebar dan tinggi untuk container
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/kitchenlogo.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              "Kitchen",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            // Dropdown
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(10),
                    isExpanded:
                        true, // Membuat dropdown menggunakan seluruh lebar yang tersedia
                    items: _categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            //toogle button
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.transparent),
                ),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(16),
                  fillColor: Colors
                      .transparent, // Set transparan agar warna container terlihat
                  selectedColor: Colors.white,
                  color: Colors.white,
                  borderWidth: 1, // Border toggle button
                  isSelected: [isFirstSelected, !isFirstSelected],
                  onPressed: (int index) {
                    setState(() {
                      isFirstSelected = index == 0;
                    });
                  },
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isFirstSelected ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Order',
                          style: TextStyle(
                            color:
                                isFirstSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        color: !isFirstSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Selesai',
                          style: TextStyle(
                            color:
                                !isFirstSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //button refresh
          Padding(
            padding: const EdgeInsets.only(left: 160),
            child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
          ),
          //button setting
          Padding(
            padding: const EdgeInsets.only(left:10),
            child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
          ),
          ],
        ),
      ),
      body: Center(
        child: Text('Order content goes here'),
      ),
    );
  }
}
