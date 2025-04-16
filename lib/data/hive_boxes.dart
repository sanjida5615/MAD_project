import 'package:hive/hive.dart';
import 'models/transaction_model.dart';
import 'models/budget_model.dart';
import 'models/recurring_transaction_model.dart';

class HiveBoxes {
  static Box<TransactionModel> getTransactions() =>
      Hive.box<TransactionModel>('transactions');
  static Box<BudgetModel> getBudgets() => Hive.box<BudgetModel>('budgets');

  // ✅ Add this method for recurring transactions
  static Box<RecurringTransactionModel> getRecurringTransactions() =>
      Hive.box<RecurringTransactionModel>('recurring_transactions');
}
