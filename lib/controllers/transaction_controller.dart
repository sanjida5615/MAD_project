import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../data/models/transaction_model.dart';
import '../data/hive_boxes.dart';

class TransactionController extends GetxController {
  var transactions = <TransactionModel>[].obs;

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var selectedCategory = "Food".obs;
  var categories =
      ["Food", "Travel", "Bills", "Salary", "Shopping", "Other"].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  // ✅ Ensure Hive Box is Open Before Fetching Transactions
  void loadTransactions() async {
    if (!Hive.isBoxOpen('transactions')) {
      await Hive.openBox<TransactionModel>('transactions');
    }
    transactions.assignAll(HiveBoxes.getTransactions().values.toList());
  }

  void addTransaction() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    if (amount <= 0) {
      Get.snackbar("Error", "Enter a valid amount",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: amount > 0 ? "income" : "expense",
      category: selectedCategory.value,
      amount: amount,
      date: DateTime.now(),
      description: descriptionController.text,
    );

    var box = HiveBoxes.getTransactions();
    box.put(transaction.id, transaction);
    transactions.add(transaction);

    // ✅ Refresh UI after adding transaction
    transactions.refresh();

    // ✅ Clear input fields
    amountController.clear();
    descriptionController.clear();

    Get.back();
    Get.snackbar("Success", "Transaction added",
        snackPosition: SnackPosition.BOTTOM);
  }

  void deleteTransaction(String id) {
    var box = HiveBoxes.getTransactions();
    box.delete(id);
    transactions.removeWhere((t) => t.id == id);

    // ✅ Refresh UI after deleting transaction
    transactions.refresh();
  }
}
