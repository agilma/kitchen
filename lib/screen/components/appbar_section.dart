import 'package:flutter/material.dart';
import 'package:kitchen/constants.dart';
import 'package:kitchen/data/order_data.dart';

class BuildAppbar extends StatefulWidget implements PreferredSizeWidget {
  // final int selectedIndex;
  // final Function(int) onItemTapped;
  // final String selectedCategory;
  // final Function(String) onCategoryChanged;
  // final Function(List<Map<String, dynamic>>) onDataOrderChanged;

  const BuildAppbar({
    Key? key,
    // required this.selectedIndex,
    // required this.onItemTapped,
    // required this.selectedCategory,
    // required this.onCategoryChanged,
    // required this.onDataOrderChanged,
  }) : super(key: key);

  @override
  State<BuildAppbar> createState() => _BuildAppbarState();

  @override
  Size get preferredSize {
    final Orientation orientation =
        MediaQueryData.fromView(WidgetsBinding.instance.window).orientation;
    final double height = orientation == Orientation.landscape ? 60.0 : 120.0;
    return Size.fromHeight(height);
  }
}

class _BuildAppbarState extends State<BuildAppbar> {
  List<Map<String, dynamic>> dataOrder = [];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    setState(() {
      dataOrder = List.from(orderData);
    });
    //widget.onDataOrderChanged(dataOrder);
  }

  List<Map<String, dynamic>> _fetchOrderData() {
    return List.from(orderData);
  }

  void _refreshData() {
    setState(() {
      dataOrder = _fetchOrderData();
    });
    //widget.onDataOrderChanged(dataOrder);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = screenWidth >= 600;

    return AppBar(
      backgroundColor: HeaderColor,
      toolbarHeight: widget.preferredSize.height,
      title: isLandscape
          ? Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(isTablet ? 8 : 5),
                  child: Container(
                    width: isTablet
                        ? (isLandscape ? 100 : 35)
                        : (isLandscape ? 30 : 25),
                    height: isTablet
                        ? (isLandscape ? 70 : 40)
                        : (isLandscape ? 35 : 30),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo-kontena.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isTablet ? 10 : 5),
                Flexible(
                  child: Container(
                    width: isTablet
                        ? (isLandscape ? 150 : 140)
                        : (isLandscape ? 100 : 90),
                    height: isTablet
                        ? (isLandscape ? 25 : 20)
                        : (isLandscape ? 20 : 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEFEFE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: DropdownButton<String>(
                        style: TextStyle(
                            fontSize: isTablet
                                ? (isLandscape ? 14 : 12)
                                : (isLandscape ? 12 : 10),
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                        //value: widget.selectedCategory,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            //widget.onCategoryChanged(newValue);
                          }
                        },
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(8),
                        isExpanded: true,
                        items: [
                          'All Station',
                          'Food Station',
                          'Beverage Station',
                          'Snack Station'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: isTablet
                      ? (isLandscape ? 35 : 30)
                      : (isLandscape ? 30 : 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child:ToggleButtons(
                    borderRadius: BorderRadius.circular(12),
                    fillColor: Colors.transparent,
                    selectedColor: const Color(0xFFFEFEFE),
                    color: const Color(0xFFFEFEFE),
                    borderWidth: 1,
                    isSelected: [
                      selectedIndex == 0,
                      selectedIndex == 1
                    ],
                    onPressed: (int index) {
                      //widget.onItemTapped(index);
                    },
                    children: <Widget>[
                      Container(
                        width: isTablet
                            ? (isLandscape ? 70 : 60)
                            : (isLandscape ? 60 : 50),
                        height: isTablet
                            ? (isLandscape ? 35 : 30)
                            : (isLandscape ? 30 : 25),
                        decoration: BoxDecoration(
                          // color: widget.selectedIndex == 0
                          //     ? OrderStatusColor
                          //     : const Color(0xFFFEFEFE),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Order',
                            style: TextStyle(
                                // color: widget.selectedIndex == 0
                                //     ? const Color(0xFFFEFEFE)
                                //     : Colors.black,
                                fontSize: isTablet
                                    ? (isLandscape ? 14 : 12)
                                    : (isLandscape ? 12 : 10),
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Container(
                        width: isTablet
                            ? (isLandscape ? 70 : 60)
                            : (isLandscape ? 60 : 50),
                        height: isTablet
                            ? (isLandscape ? 35 : 30)
                            : (isLandscape ? 30 : 25),
                        decoration: BoxDecoration(
                          // color: widget.selectedIndex == 1
                          //     ? DoneStatusColor
                          //     : const Color(0xFFFEFEFE),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Selesai',
                            style: TextStyle(
                                // color: widget.selectedIndex == 1
                                //     ? const Color(0xFFFEFEFE)
                                //     : Colors.black,
                                fontSize: isTablet
                                    ? (isLandscape ? 14 : 12)
                                    : (isLandscape ? 12 : 10),
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isTablet ? 30 :10),
                ElevatedButton(
                  onPressed: _refreshData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEFEFE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(
                      isTablet
                          ? (isLandscape ? 35 : 30)
                          : (isLandscape ? 30 : 25),
                      isTablet
                          ? (isLandscape ? 35 : 30)
                          : (isLandscape ? 30 : 25),
                    ),
                  ),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: isTablet
                        ? (isLandscape ? 18 : 16)
                        : (isLandscape ? 16 : 14),
                  ),
                ),
                SizedBox(width: isTablet ? 5 : 3),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your settings functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEFEFE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(
                        isTablet
                            ? (isLandscape ? 35 : 30)
                            : (isLandscape ? 30 : 25),
                        isTablet
                            ? (isLandscape ? 35 : 30)
                            : (isLandscape ? 30 : 25),
                      ),
                    ),
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: isTablet
                          ? (isLandscape ? 18 : 16)
                          : (isLandscape ? 16 : 14),
                    ),
                  ),
                ),
              ],
            )
          //portrait view
        : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: isTablet ? 10 : 5, bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(isTablet ? 8 : 5),
                        child: Container(
                          width: isTablet ? 40 : 70,
                          height: isTablet ? 45 : 60,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/logo-kontena.png"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: isTablet ? 160 : 120,
                        height: isTablet ? 30 : 25,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEFEFE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButton<String>(
                            style: TextStyle(
                                fontSize: isTablet ? 14 : 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                            //value: widget.selectedCategory,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                //widget.onCategoryChanged(newValue);
                              }
                            },
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(8),
                            isExpanded: true,
                            items: [
                              'All Station',
                              'Food Station',
                              'Beverage Station',
                              'Snack Station'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: isTablet ? 35 : 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: ToggleButtons(
                          borderRadius: BorderRadius.circular(12),
                          fillColor: Colors.transparent,
                          selectedColor: const Color(0xFFFEFEFE),
                          color: const Color(0xFFFEFEFE),
                          borderWidth: 1,
                          isSelected: [
                            // widget.selectedIndex == 0,
                            // widget.selectedIndex == 1
                          ],
                          onPressed: (int index) {
                            //widget.onItemTapped(index);
                          },
                          children: <Widget>[
                            Container(
                              width: isTablet ? 70 : 60,
                              height: isTablet ? 30 : 25,
                              decoration: BoxDecoration(
                                // color: widget.selectedIndex == 0
                                //     ? OrderStatusColor
                                //     : const Color(0xFFFEFEFE),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Order',
                                  style: TextStyle(
                                      // color: widget.selectedIndex == 0
                                      //     ? const Color(0xFFFEFEFE)
                                      //     : Colors.black,
                                      fontSize: isTablet ? 14 : 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            Container(
                              width: isTablet ? 70 : 60,
                              height: isTablet ? 30 : 25,
                              decoration: BoxDecoration(
                                // color: widget.selectedIndex == 1
                                //     ? DoneStatusColor
                                //     : const Color(0xFFFEFEFE),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Selesai',
                                  style: TextStyle(
                                      // color: widget.selectedIndex == 1
                                      //     ? const Color(0xFFFEFEFE)
                                      //     : Colors.black,
                                      fontSize: isTablet ? 14 : 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: isTablet ? 100 : 10),
                    ElevatedButton(
                      onPressed: _refreshData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEFEFE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(
                          isTablet ? 35 : 30,
                          isTablet ? 35 : 30,
                        ),
                      ),
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: isTablet ? 18 : 16,
                      ),
                    ),
                    SizedBox(width: isTablet ? 5 : 3),
                    ElevatedButton(
                      onPressed: () {
                        _refreshData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEFEFE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(
                          isTablet ? 35 : 30,
                          isTablet ? 35 : 30,
                        ),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: isTablet ? 18 : 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
