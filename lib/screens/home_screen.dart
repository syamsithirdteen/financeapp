import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../widgets/grid_menu_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // helper sederhana untuk menggantikan .withOpacity (menghindari deprecation)
  static Color _withAlpha(Color c, double opacity) {
    return Color.fromARGB((opacity * 255).round(), c.red, c.green, c.blue);
  }

  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionModel(
        title: 'Coffee Shop',
        amount: 35000.00,
        category: 'Food',
        icon: Icons.coffee,
        isExpense: true,
        date: DateTime.now(),
      ),
      TransactionModel(
        title: 'Grab Ride',
        amount: 25000.00,
        category: 'Travel',
        icon: Icons.directions_car,
        isExpense: true,
        date: DateTime.now(),
      ),
      TransactionModel(
        title: 'Gym Membership',
        amount: 150000.00,
        category: 'Health',
        icon: Icons.fitness_center,
        isExpense: true,
        date: DateTime.now(),
      ),
      TransactionModel(
        title: 'Movie Ticket',
        amount: 60000.00,
        category: 'Event',
        icon: Icons.movie,
        isExpense: true,
        date: DateTime.now(),
      ),
      TransactionModel(
        title: 'Salary',
        amount: 5000000.00,
        category: 'Income',
        icon: Icons.wallet,
        isExpense: false,
        date: DateTime.now(),
      ),
    ];

    // ringkasan total (skeleton demo). Tipe int agar _formatCurrency bekerja
    final totalBalance = 12350000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Mate'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 600));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting + Total Balance Card
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Syamsi Alpiansyah 👋',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: _withAlpha(
                      Theme.of(context).primaryColor,
                      0.1,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Total balance card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _withAlpha(Theme.of(context).primaryColor, 0.7),
                              Theme.of(context).primaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _withAlpha(
                                Theme.of(context).primaryColor,
                                0.3,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Balance',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${_formatCurrency(totalBalance)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tombol Top Up — sekarang memanggil Navigator.push dengan route lengkap
                      ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const _PlaceholderScreen(
                                title: 'Top Up (temporary)',
                              ),
                            ),
                          );

                          if (result == true) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Top up berhasil. Saldo diperbarui.',
                                  ),
                                ),
                              );
                            }
                            // TODO: panggil state management / reload saldo nyata di sini
                          }
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Top Up'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // My Cards title + Manage button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Cards',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const _PlaceholderScreen(title: 'Manage Cards'),
                        ),
                      );
                    },
                    child: const Text('Manage', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ATM Cards horizontal
              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SizedBox(width: 2),
                    AtmCard(
                      bankName: 'Bank A',
                      cardNumber: '**** 2345',
                      balance: 'Rp12.500.000',
                      color1: Color(0xFF3A8DFF),
                      color2: Color(0xFF004CFF),
                    ),
                    AtmCard(
                      bankName: 'Bank B',
                      cardNumber: '**** 8765',
                      balance: 'Rp5.350.000',
                      color1: Color(0xFFFF8C00),
                      color2: Color(0xFFFF2E00),
                    ),
                    AtmCard(
                      bankName: 'Bank C',
                      cardNumber: '**** 4321',
                      balance: 'Rp3.800.000',
                      color1: Color(0xFF00C6FF),
                      color2: Color(0xFF0072FF),
                    ),
                    AtmCard(
                      bankName: 'Bank D',
                      cardNumber: '**** 9987',
                      balance: 'Rp20.000.000',
                      color1: Color(0xFF8E2DE2),
                      color2: Color(0xFF4A00E0),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Grid menu modern
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  GridMenuItem(icon: Icons.send_to_mobile, label: 'Transfer'),
                  GridMenuItem(icon: Icons.payment, label: 'Bills'),
                  GridMenuItem(icon: Icons.qr_code, label: 'Scan'),
                  GridMenuItem(icon: Icons.savings, label: 'Savings'),
                  GridMenuItem(icon: Icons.fastfood, label: 'Food'),
                  GridMenuItem(icon: Icons.travel_explore, label: 'Travel'),
                  GridMenuItem(icon: Icons.health_and_safety, label: 'Health'),
                  GridMenuItem(icon: Icons.more_horiz, label: 'More'),
                ],
              ),

              const SizedBox(height: 24),

              // Recent Transactions
              const Text(
                'Recent Transactions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return TransactionItem(transaction: transactions[index]);
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // helper format rupiah sederhana
  static String _formatCurrency(int value) {
    final abs = value.abs();
    final str = abs.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]}.',
    );
    return str;
  }
}

/// Simple temporary placeholder page used for navigation targets
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // contoh: kembali dengan nilai true (angkap berhasil)
            Navigator.of(context).pop(true);
          },
          child: const Text('Kembali (return true)'),
        ),
      ),
    );
  }
}
