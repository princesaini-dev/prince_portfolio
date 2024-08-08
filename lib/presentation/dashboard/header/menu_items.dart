import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';

class MenuItems {
  static const List<MenuItem> menuItems = [
    MenuItem(title: StringManager.home, icon: Icons.home),
    MenuItem(title: StringManager.about, icon: Icons.person),
    // MenuItem(
    //     title: StringManager.projects, icon: Icons.precision_manufacturing),
    MenuItem(title: StringManager.contact, icon: Icons.contact_page_outlined),
    // MenuItem(title: StringManager.blog, icon: Icons.edit_document),
    MenuItem(title: StringManager.resume, icon: Icons.description_outlined),
  ];
}

class MenuItem {
  final String title;
  final IconData icon;
  const MenuItem({required this.title, required this.icon});
}
