import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/account_page.dart';
import 'pages/solutions_page.dart';
import 'pages/store_page.dart';
import 'pages/cards_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أبا يزيد لنك منجر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: 'Cairo',
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 4;
  final List<Widget> _pages = const [
    AccountPage(),
    SolutionsPage(),
    StorePage(),
    CardsPage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        backgroundColor: const Color(0xFF1E1E1E),
        indicatorColor: const Color(0xFF1E88E5).withOpacity(0.3),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'حلول'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'المتجر'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined), label: 'الكروت'),
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
        ],
      ),
    );
  }
}
