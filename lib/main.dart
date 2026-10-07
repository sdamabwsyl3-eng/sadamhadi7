import 'package:flutter/material.dart';

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
