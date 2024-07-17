import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart';
import 'package:kitchen/screen/components/category_filter.dart';

class BuildAppbar extends StatelessWidget implements PreferredSizeWidget {
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
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HeaderColor,
      toolbarHeight: 100,
      title: Row(
        children: [
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/kitchenlogo.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Text(
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
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onCategoryChanged(newValue);
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
                isSelected: [selectedIndex == 0, selectedIndex == 1],
                onPressed: (int index) {
                  onItemTapped(index);
                },
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedIndex == 0 ? Colors.green : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Order',
                        style: TextStyle(
                          color: selectedIndex == 0 ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedIndex == 1 ? Colors.blue : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Selesai',
                        style: TextStyle(
                          color: selectedIndex == 1 ? Colors.white : Colors.black,
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
              child: const Icon(
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
              child: const Icon(
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
