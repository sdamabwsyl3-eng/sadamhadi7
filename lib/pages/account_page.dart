import 'package:flutter/material.dart';
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('حسابي')), body: const Center(child: Text('بيانات الحساب والصلاحيات', style: TextStyle(fontSize: 18))));
}
