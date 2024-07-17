import 'package:flutter/material.dart';

class CategoryFilter extends InheritedWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const CategoryFilter({
    Key? key,
    required Widget child,
    required this.selectedCategory,
    required this.onCategoryChanged,
  }) : super(key: key, child: child);

  static CategoryFilter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CategoryFilter>();
  }

  @override
  bool updateShouldNotify(CategoryFilter oldWidget) {
    return oldWidget.selectedCategory != selectedCategory;
  }
}
