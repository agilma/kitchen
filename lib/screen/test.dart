import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // Fungsi untuk merefresh halaman
  void _refreshPage() {
    setState(() {
      // Aksi untuk merefresh halaman bisa dilakukan di sini
      // Misalnya mengambil data ulang dari API atau mengupdate state lain
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refresh Page Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshPage,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Content of the page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
