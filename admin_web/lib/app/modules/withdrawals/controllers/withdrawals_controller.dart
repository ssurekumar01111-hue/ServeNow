import 'dart:async';
import 'package:get/get.dart';
import 'package:admin_web/app/models/transaction_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class WithdrawalsController extends GetxController {
  final allWithdrawals = <TransactionModel>[].obs;
  final filteredWithdrawals = <TransactionModel>[].obs;
  final statusFilter = 'pending'.obs;
  final isLoading = true.obs;

  final pendingCount = 0.obs;
  final pendingAmount = 0.0.obs;
  final completedCount = 0.obs;
  final completedAmount = 0.0.obs;

  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    listenToWithdrawals();
  }

  void listenToWithdrawals() {
    _sub = FireStoreUtils.getWithdrawalsStream().listen((snapshot) {
      allWithdrawals.value = snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      
      _calculateStats();
      applyFilters();
      isLoading.value = false;
    });
  }

  void _calculateStats() {
    int pCount = 0;
    double pAmt = 0;
    int cCount = 0;
    double cAmt = 0;

    for (var w in allWithdrawals) {
      if (w.status == 'pending') {
        pCount++;
        pAmt += (w.amount ?? 0);
      } else if (w.status == 'approved') {
        cCount++;
        cAmt += (w.amount ?? 0);
      }
    }

    pendingCount.value = pCount;
    pendingAmount.value = pAmt;
    completedCount.value = cCount;
    completedAmount.value = cAmt;
  }

  void applyFilters() {
    filteredWithdrawals.value = allWithdrawals.where((w) => w.status == statusFilter.value).toList();
  }

  void setFilter(String status) {
    statusFilter.value = status;
    applyFilters();
  }

  Future<void> approveWithdrawal(String id, String note) async {
    await FireStoreUtils.approveWithdrawal(id, note);
  }

  Future<void> rejectWithdrawal(String id, String reason) async {
    await FireStoreUtils.rejectWithdrawal(id, reason);
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
