import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});
  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final _ip = TextEditingController(text: '192.168.88.1');
  final _user = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  String? _error;
  List<Map<String, dynamic>> _cards = [];

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('${_user.text}:${_pass.text}'))}',
        },
      ));
      final res = await dio.get('http://${_ip.text.trim()}/rest/ip/hotspot/user');
      final list = (res.data as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .where((e) => e['name'] != 'default-trial')
          .toList();
      setState(() => _cards = list);
    } on DioException catch (e) {
      setState(() => _error = e.response?.statusCode == 401
          ? 'اسم المستخدم أو كلمة السر خطأ'
          : 'تعذر الاتصال بالراوتر: ${e.message}');
    } catch (e) {
      setState(() => _error = 'خطأ: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _printPdf() async {
    final fontData =
        await rootBundle.load('assets/fonts/IBMPlexSansArabic-Regular.ttf');
    final boldData =
        await rootBundle.load('assets/fonts/IBMPlexSansArabic-Bold.ttf');
    final font = pw.Font.ttf(fontData);
    final bold = pw.Font.ttf(boldData);
    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: font, bold: bold),
    );

    pw.Widget cardBox(Map<String, dynamic> c) => pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.7)),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('أبا يزيد لنك منجر',
                  style: pw.TextStyle(font: bold, fontSize: 11)),
              pw.SizedBox(height: 4),
              pw.Text('المستخدم: ${c['name'] ?? ''}',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.Text('كلمة السر: ${c['password'] ?? ''}',
                  style: const pw.TextStyle(fontSize: 12)),
              if ((c['limit-uptime'] ?? '').toString().isNotEmpty)
                pw.Text('المدة: ${c['limit-uptime']}',
                    style: const pw.TextStyle(fontSize: 10)),
            ],
          ),
        );

    doc.addPage(pw.MultiPage(
      textDirection: pw.TextDirection.rtl,
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(16),
      build: (_) => [
        pw.Wrap(
          spacing: 6,
          runSpacing: 6,
          children: _cards
              .map((c) => pw.SizedBox(width: 175, child: cardBox(c)))
              .toList(),
        ),
      ],
    ));

    await Printing.layoutPdf(onLayout: (_) async => doc.save());
  }

  @override
  void dispose() {
    _ip.dispose();
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الكروت')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              TextField(
                controller: _ip,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                    labelText: 'عنوان الراوتر (IP)',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _user,
                decoration: const InputDecoration(
                    labelText: 'اسم المستخدم', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'كلمة السر', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _loading ? null : _fetch,
                    icon: const Icon(Icons.download),
                    label: const Text('جلب الكروت'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _cards.isEmpty ? null : _printPdf,
                    icon: const Icon(Icons.print),
                    label: const Text('طباعة'),
                  ),
                ),
              ]),
            ]),
          ),
          if (_loading) const LinearProgressIndicator(),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(_error!, style: const TextStyle(color: Colors.redAccent)),
            ),
          if (_cards.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('عدد الكروت: ${_cards.length}'),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _cards.length,
              itemBuilder: (_, i) {
                final c = _cards[i];
                return ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: Text('${c['name'] ?? ''}'),
                  subtitle: Text(
                      'كلمة السر: ${c['password'] ?? '-'}   المدة: ${c['limit-uptime'] ?? '-'}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
