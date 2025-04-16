import 'package:hive/hive.dart';
import 'models/transaction_model.dart';
import 'models/budget_model.dart';
import 'models/recurring_transaction_model.dart';

class DBHelper {
  static const String transactionsBox = 'transactions';
  static const String budgetsBox = 'budgets';
  static const String recurringTransactionsBox = 'recurring_transactions';
  static const String settingsBox = 'settings';

  // ✅ Open Hive Boxes Safely
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(TransactionModelAdapter());
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(BudgetModelAdapter());
    if (!Hive.isAdapterRegistered(2))
      Hive.registerAdapter(RecurringTransactionModelAdapter());

    if (!Hive.isBoxOpen(transactionsBox))
      await Hive.openBox<TransactionModel>(transactionsBox);
    if (!Hive.isBoxOpen(budgetsBox))
      await Hive.openBox<BudgetModel>(budgetsBox);
    if (!Hive.isBoxOpen(recurringTransactionsBox))
      await Hive.openBox<RecurringTransactionModel>(recurringTransactionsBox);
    if (!Hive.isBoxOpen(settingsBox)) await Hive.openBox(settingsBox);
  }

  // ======= Transactions =======
  static Box<TransactionModel> getTransactionsBox() =>
      Hive.box<TransactionModel>(transactionsBox);

  static Future<void> addTransaction(TransactionModel transaction) async {
    await getTransactionsBox().put(transaction.id, transaction);
  }

  static List<TransactionModel> getTransactions() {
    return getTransactionsBox().values.toList();
  }

  static Future<void> deleteTransaction(String id) async {
    await getTransactionsBox().delete(id);
  }

  // ======= Budgets =======
  static Box<BudgetModel> getBudgetsBox() => Hive.box<BudgetModel>(budgetsBox);

  static Future<void> addBudget(BudgetModel budget) async {
    await getBudgetsBox().put(budget.category, budget);
  }

  static List<BudgetModel> getBudgets() {
    return getBudgetsBox().values.toList();
  }

  static Future<void> updateBudget(String category, double spentAmount) async {
    var budget = getBudgetsBox().get(category);
    if (budget != null) {
      budget.spent += spentAmount;
      await getBudgetsBox().put(category, budget);
    }
  }

  // ======= Recurring Transactions =======
  static Box<RecurringTransactionModel> getRecurringTransactionsBox() =>
      Hive.box<RecurringTransactionModel>(recurringTransactionsBox);

  static Future<void> addRecurringTransaction(
      RecurringTransactionModel transaction) async {
    await getRecurringTransactionsBox().put(transaction.id, transaction);
  }

  static List<RecurringTransactionModel> getRecurringTransactions() {
    return getRecurringTransactionsBox().values.toList();
  }

  static Future<void> deleteRecurringTransaction(String id) async {
    await getRecurringTransactionsBox().delete(id);
  }

  // ======= App Settings =======
  static Box getSettingsBox() => Hive.box(settingsBox);

  static bool getDarkModeSetting() {
    return getSettingsBox().get('darkMode', defaultValue: false);
  }

  static Future<void> setDarkModeSetting(bool isDarkMode) async {
    await getSettingsBox().put('darkMode', isDarkMode);
  }
}
