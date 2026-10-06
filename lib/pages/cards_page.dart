import 'package:flutter/material.dart';
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('الكروت')), body: const Center(child: Text('توليد — فحص — طباعة — شحن', style: TextStyle(fontSize: 18))));
}
