import 'package:alisveris/Screens/FavoritesScreen.dart';
import 'package:alisveris/Screens/HomeScreen.dart';
import 'package:alisveris/Screens/UserProfileScreen.dart';
import 'package:flutter/material.dart';

class BottomBarRouter extends StatefulWidget {
  const BottomBarRouter({Key? key}) : super(key: key);

  @override
  State<BottomBarRouter> createState() => _BottomBarRouterState();
}

class _BottomBarRouterState extends State<BottomBarRouter> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
