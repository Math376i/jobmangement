import 'package:flutter/material.dart';
import 'package:flutter_counter/maps/view/maps_page.dart';
import 'package:flutter_counter/settings/view/settings_page.dart';

import '../home/view/home_page.dart';

class AppPage {
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Widget Function() builder;

  const AppPage({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    required this.builder,
  });
}

const List<AppPage> pages = [
  AppPage(
    title: 'Map',
    builder: MapsPage.new,
    icon: Icons.map,
    selectedIcon: Icons.map_outlined,
  ),
  AppPage(
    title: 'Home',
    builder: HomePage.new,
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  AppPage(
    title: "Settings",
    builder: SettingsPage.new,
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  )
];
