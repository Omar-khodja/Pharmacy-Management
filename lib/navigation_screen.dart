import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pharmacy_management/feature/Inventory/presentaion/screen/inventory.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/screen/medicine_managment.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/screen/sales.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/screen/dashboard.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    Dashboard(),
    MedicineManagment(),
    Sales(),
    Inventory(),
  ];
  final List<String> _pageTitles = const [
    'Dashboard',
    'Medicine Management',
    'Sales',
    'Inventory',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text(_pageTitles[_selectedIndex]),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,

              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(context).colorScheme.primary
                  .withValues(alpha: 0.8),
              color: Colors.black,
              tabs: const [
                GButton(icon: LineIcons.home, text: 'Dashboard'),
                GButton(icon: LineIcons.firstAid, text: 'Medicine'),
                GButton(icon: LineIcons.shoppingCart, text: 'Sales'),
                GButton(icon: LineIcons.box, text: 'Inventory'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
