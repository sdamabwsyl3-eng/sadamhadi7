import 'package:flutter/material.dart';
class StorePage extends StatelessWidget {
  const StorePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('المتجر')), body: const Center(child: Text('الباقات والأجهزة والطباعة', style: TextStyle(fontSize: 18))));
}
