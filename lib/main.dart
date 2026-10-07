import 'package:flutter/material.dart';
import 'pages/account_page.dart';
import 'pages/cards_page.dart';
import 'pages/solutions_page.dart';
import 'pages/store_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark(useMaterial3: true);

    return MaterialApp(
      title: 'أبا يزيد لنك منجر',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      theme: base.copyWith(
        textTheme: base.textTheme.apply(fontFamily: 'IBMPlexSansArabic'),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _pages = const [
    SolutionsPage(),
    CardsPage(),
    StorePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.hub), label: 'الحلول'),
          NavigationDestination(icon: Icon(Icons.credit_card), label: 'الكروت'),
          NavigationDestination(icon: Icon(Icons.store), label: 'المتجر'),
          NavigationDestination(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}
