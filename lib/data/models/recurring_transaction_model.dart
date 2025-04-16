import 'package:hive/hive.dart';

part 'recurring_transaction_model.g.dart';

@HiveType(typeId: 2)
class RecurringTransactionModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type; // "income" or "expense"

  @HiveField(2)
  String category;

  @HiveField(3)
  double amount;

  @HiveField(4)
  String frequency; // "monthly", "weekly"

  RecurringTransactionModel({
    required this.id,
    required this.type,
    required this.category,
    required this.amount,
    required this.frequency,
  });
}
