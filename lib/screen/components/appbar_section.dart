import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart';
import 'package:kitchen/screen/components/category_filter.dart';

class BuildAppbar extends StatefulWidget implements PreferredSizeWidget {
  const BuildAppbar({Key? key}) : super(key: key);

  @override
  _AppbarSectionState createState() => _AppbarSectionState();

  @override
  Size get preferredSize => Size.fromHeight(100); // Set the preferred size for the AppBar
}

class _AppbarSectionState extends State<BuildAppbar> {
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
    var categoryFilter = CategoryFilter.of(context);

    return AppBar(
      backgroundColor: HeaderColor,
      toolbarHeight: 100,
      title: Row(
        children: [
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 50,
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
                      categoryFilter?.onCategoryChanged(_selectedCategory);
                    });
                  },
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: true,
                  items: _categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.transparent),
              ),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(16),
                fillColor: Colors.transparent,
                selectedColor: Colors.white,
                color: Colors.white,
                borderWidth: 1,
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
                          color: isFirstSelected ? Colors.white : Colors.black,
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
                          color: !isFirstSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70),
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
          Padding(
            padding: const EdgeInsets.only(left: 10),
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
    );
  }
}
