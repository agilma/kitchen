import 'package:flutter/material.dart';
import 'package:kitchen/screen/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderListPage(),
    );
  }
}



// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   String _selectedCategory = 'Semua';
//   List<Map<String, dynamic>> _dataOrder = []; // Tambahkan variabel untuk menyimpan data order

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _onCategoryChanged(String newCategory) {
//     setState(() {
//       _selectedCategory = newCategory;
//     });
//   }

//   void _onDataOrderChanged(List<Map<String, dynamic>> newDataOrder) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         _dataOrder = newDataOrder;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BuildAppbar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//         selectedCategory: _selectedCategory,
//         onCategoryChanged: _onCategoryChanged,
//         onDataOrderChanged: _onDataOrderChanged, // Tambahkan callback ini
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: <Widget>[
//           OrderScreen(selectedCategory: _selectedCategory, dataOrder: _dataOrder), // Tambahkan dataOrder sebagai parameter
//           DoneScreen(selectedCategory: _selectedCategory),
//         ],
//       ),
//     );
//   }
// }
