import 'package:flutter/material.dart';

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
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('أبا يزيد لنك منجر'),
          backgroundColor: const Color(0xFF0F2B48),
        ),
        body: const Center(
          child: Text(
            '✅ التطبيق يعمل بنجاح!\nسنضيف المزيد قريباً',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, height: 1.5),
          ),
        ),
      ),
    );
  }
}
