import 'package:get/get.dart';
import '../data/models/recurring_transaction_model.dart';
import '../data/hive_boxes.dart';

class RecurringTransactionController extends GetxController {
  var recurringTransactions = <RecurringTransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecurringTransactions();
  }

  void loadRecurringTransactions() {
    recurringTransactions
        .assignAll(HiveBoxes.getRecurringTransactions().values.toList());
  }

  void addRecurringTransaction(RecurringTransactionModel transaction) {
    HiveBoxes.getRecurringTransactions().put(transaction.id, transaction);
    recurringTransactions.add(transaction);
  }

  void applyRecurringTransactions() {
    final now = DateTime.now();
    for (var transaction in recurringTransactions) {
      if (transaction.frequency == "monthly" && now.day == 1) {
        // Add to transactions
      }
    }
  }
}
