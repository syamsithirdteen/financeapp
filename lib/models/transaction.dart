import 'package:flutter/material.dart';

class TransactionModel {
  final String title;
  final double amount; // Mengubah dari String menjadi double untuk perhitungan
  final String category;
  final bool
  isExpense; // NEW: true jika pengeluaran (merah), false jika pemasukan (hijau)
  final IconData icon; // NEW: Ikon untuk kategori
  final DateTime date; // NEW: Tanggal transaksi

  TransactionModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.isExpense,
    required this.icon,
    required this.date,
  });
}
