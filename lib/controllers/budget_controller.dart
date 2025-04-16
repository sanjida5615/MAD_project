import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../data/models/budget_model.dart';
import '../data/hive_boxes.dart';

class BudgetController extends GetxController {
  var budgets = <BudgetModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBudgets();
  }

  void loadBudgets() {
    budgets.assignAll(HiveBoxes.getBudgets().values.toList());
  }

  void addBudget(String category, double limit) {
    var budget = BudgetModel(category: category, limit: limit);
    HiveBoxes.getBudgets().put(category, budget);
    budgets.add(budget);
  }

  void updateBudget(String category, double spentAmount) {
    var budget = budgets.firstWhereOrNull((b) => b.category == category);
    if (budget != null) {
      budget.updateSpent(spentAmount);
      HiveBoxes.getBudgets().put(category, budget);
      budgets.refresh();
      if (budget.spent > budget.limit) {
        Get.snackbar(
            "Budget Alert", "You have exceeded your ${budget.category} budget!",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
