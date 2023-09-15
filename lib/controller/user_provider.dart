import 'package:flutter/material.dart';
import 'package:xpay_web/controller/api_service.dart';

import '../model/user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> allUsers = [];
  int currentPage = 0;
  void setUsers(List<User> users) {
    allUsers = users;
    notifyListeners();
  }

  int totalUsers = 0;
  final int pageLimit = 10;

  int getCurrentPage() => currentPage;
  int getMaxPages() => (totalUsers / pageLimit).ceil();

  void setCurrentPage(BuildContext context, int page) {
    currentPage = page;
    fetchResults(context);
    notifyListeners();
  }

  void incrementPage() {
    if (currentPage < 10) {
      currentPage++;
      notifyListeners();
    }
  }

  void decrementPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  void setTotalUsers(int total) {
    totalUsers = total;
    notifyListeners();
  }

  Future<void> loadPage(BuildContext context, int page) async {
    setCurrentPage(context, page);
    await fetchResults(context);
  }

  Future<void> loadNextPage(BuildContext context) async {
    if (currentPage < 10) {
      incrementPage();
      await loadPage(context, currentPage);
    }
  }

  Future<void> loadPreviousPage(BuildContext context) async {
    if (currentPage >= 1) {
      decrementPage();
      await fetchResults(context);
    }
  }
}
