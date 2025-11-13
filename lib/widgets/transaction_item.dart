import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil warna primer (Indigo) dari Tema
    final Color primaryColor = Theme.of(context).primaryColor;

    // 2. Tentukan warna dan tanda +/- berdasarkan 'isExpense' dari model baru
    final Color amountColor = transaction.isExpense
        ? Colors.red.shade700
        : Colors.green.shade700;

    final String sign = transaction.isExpense ? '-' : '+';

    // 3. Format 'amount' (double) menjadi String mata uang
    final String formattedAmount =
        'Rp ${transaction.amount.toStringAsFixed(0)}';

    return Card(
      // 4. UI/UX: Desain kartu yang lebih modern (Material 3 Style)
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // Gunakan border tipis alih-alih bayangan (shadow)
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        // 5. Leading: Ikon dinamis dari model, dibungkus CircleAvatar
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: primaryColor.withOpacity(0.1),
          child: Icon(
            transaction.icon, // Menggunakan ikon dari model
            color: primaryColor,
            size: 22,
          ),
        ),

        // 6. Title/Subtitle
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(transaction.category),

        // 7. Trailing: Tampilkan jumlah yang sudah diformat
        trailing: Text(
          '$sign $formattedAmount',
          style: TextStyle(
            color: amountColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
