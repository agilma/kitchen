import 'package:flutter/material.dart';
import 'package:kitchen/screen/components/appbar_section.dart';
import 'package:kitchen/screen/order/order_screen.dart';
import 'package:kitchen/screen/done/done_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = 'Semua';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCategoryChanged(String newCategory) {
    setState(() {
      _selectedCategory = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        selectedCategory: _selectedCategory,
        onCategoryChanged: _onCategoryChanged,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          OrderScreen(selectedCategory: _selectedCategory),
          DoneScreen(selectedCategory:_selectedCategory),
        ],
      ),
    );
  }
}
