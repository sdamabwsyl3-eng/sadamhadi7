import 'package:flutter/material.dart';

class AppData {
  static String networkName = 'MikroTik CCR2004';
  static bool isOnline = true;
  static double uploadSpeed = 420.0;
  static String uploadUnit = 'K';
  static double downloadSpeed = 9.5;
  static String downloadUnit = 'M';
  static int cardsRemaining = 1711;
  static int cardsUsed = 521;
  static int cardsTotal = 2232;
  static double usagePercent = 0.23;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(),
              const SizedBox(height: 20),
              _buildDeviceCard(),
              const SizedBox(height: 20),
              _buildQuickActions(),
              const SizedBox(height: 20),
              _buildStatsSection(),
              const SizedBox(height: 24),
              _buildBottomButtons(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E88E5).withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.router, color: Color(0xFF1E88E5), size: 28),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'أبا يزيد لنك منجر',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'إدارة الشبكات والكروت',
                style: TextStyle(color: Colors.white60, fontSize: 13),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppData.isOnline ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(AppData.isOnline ? Colors.green : Colors.red, width: 1.5),
          ),
          child: Row(
            children: [
              Icon(Icons.circle, color: AppData.isOnline ? Colors.green : Colors.red, size: 10),
              const SizedBox(width: 6),
              Text(
                AppData.isOnline ? 'ONLINE' : 'OFFLINE',
                style: TextStyle(color: AppData.isOnline ? Colors.green : Colors.red, fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF26A69A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('الجهاز المتصل', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 4),
                Text(AppData.networkName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _SpeedItem(icon: Icons.arrow_upward, value: '${AppData.uploadSpeed.toStringAsFixed(0)}${AppData.uploadUnit}', label: 'الرفع'),
                    _SpeedItem(icon: Icons.arrow_downward, value: '${AppData.downloadSpeed.toStringAsFixed(1)}${AppData.downloadUnit}', label: 'التحميل'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: const Icon(Icons.router, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      (Icons.list_alt, 'قائمة الكروت', Colors.green),
      (Icons.add_circle, 'توليد كروت', Color(0xFF1E88E5)),
      (Icons.bar_chart, 'التقارير والتحليل', Colors.purple),
      (Icons.show_chart, 'المراقبة', Colors.amber),
      (Icons.speed, 'سرعة الباقات', Colors.orange),
      (Icons.wifi, 'مراقبة الانترنتات', Color(0xFF1E88E5)),
      (Icons.account_balance_wallet, 'شحن الرصيد', Colors.green),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.55,
      ),
      itemCount: actions.length,
      itemBuilder: (_, i) => _ActionButton(icon: actions[i].$1, label: actions[i].$2, color: actions[i].$3),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _StatCard(title: 'المتبقي', value: '${AppData.cardsRemaining}', icon: Icons.credit_card, color: Colors.green)),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(title: 'مستخدمة', value: '${AppData.cardsUsed}', icon: Icons.credit_card_off, color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('الإجمالي', style: TextStyle(color: Colors.white60, fontSize: 13)),
              const SizedBox(height: 8),
              Text('${AppData.cardsTotal}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(value: AppData.usagePercent, minHeight: 10, backgroundColor: Colors.white10),
              ),
              const SizedBox(height: 8),
              Text('نسبة الاستخدام: ${(AppData.usagePercent * 100).toInt()}%', style: const TextStyle(color: Colors.white60, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            icon: const Icon(Icons.headset_mic, color: Colors.white),
            label: const Text('تواصل معنا', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E88E5), padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            icon: const Icon(Icons.search, color: Colors.white),
            label: const Text('فحص كرت', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

class _SpeedItem extends StatelessWidget {
  final IconData icon;
  final String value, label;
  const _SpeedItem({required this.icon, required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(children: [Icon(icon, color: Colors.white, size: 26), const SizedBox(height: 6), Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12))]);
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ActionButton({required this.icon, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4))]),
    padding: const EdgeInsets.all(14),
    child: Row(textDirection: TextDirection.rtl, children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 24)), const SizedBox(width: 12), Expanded(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)))]),
  );
}

class _StatCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Row(textDirection: TextDirection.rtl, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(color: Colors.white60, fontSize: 13)), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 22))]), const SizedBox(height: 8), Text(value, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold))]),
  );
}
