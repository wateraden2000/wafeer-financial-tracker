import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'راتب وظيفة رئيسية',
      amount: 4500.0,
      category: 'راتب',
      type: TransactionType.income,
      date: DateTime.now().subtract(const Duration(days: 2)),
      notes: 'الراتب الشهري الأساسي',
    ),
    Transaction(
      id: '2',
      title: 'شراء بقالة ومستلزمات',
      amount: 450.0,
      category: 'طعام',
      type: TransactionType.expense,
      date: DateTime.now().subtract(const Duration(days: 1)),
      notes: 'من السوبرماركت',
    ),
    Transaction(
      id: '3',
      title: 'فاتورة الكهرباء والإنترنت',
      amount: 180.0,
      category: 'فواتير',
      type: TransactionType.expense,
      date: DateTime.now(),
      notes: 'شامل استهلاك شهر مايو',
    ),
    Transaction(
      id: '4',
      title: 'بيع هاتف مستعمل',
      amount: 700.0,
      category: 'أخرى',
      type: TransactionType.income,
      date: DateTime.now(),
      notes: 'تم البيع نقداً',
    ),
    Transaction(
      id: '5',
      title: 'اشتراك سينما وترفيه',
      amount: 75.0,
      category: 'ترفيه',
      type: TransactionType.expense,
      date: DateTime.now(),
      notes: 'الاشتراك الشهري',
    ),
  ];

  double _monthlyBudget = 1500.0;
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  String _selectedType = 'الكل'; // 'الكل', 'دخل', 'مصروف'

  List<Transaction> get transactions => _transactions;
  double get monthlyBudget => _monthlyBudget;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  String get selectedType => _selectedType;

  // Categories list
  final List<String> categories = [
    'طعام',
    'تسوق',
    'مواصلات',
    'ترفيه',
    'فواتير',
    'راتب',
    'أخرى'
  ];

  // Calculated properties
  double get totalIncome {
    return _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpenses {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBalance => totalIncome - totalExpenses;

  double get budgetProgressPercentage {
    if (_monthlyBudget <= 0) return 0.0;
    final pct = totalExpenses / _monthlyBudget;
    return pct > 1.0 ? 1.0 : pct;
  }

  // Filtered transactions
  List<Transaction> get filteredTransactions {
    return _transactions.where((t) {
      final matchesSearch = t.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (t.notes != null && t.notes!.toLowerCase().contains(_searchQuery.toLowerCase()));
      
      final matchesCategory = _selectedCategory == 'الكل' || t.category == _selectedCategory;
      
      bool matchesType = true;
      if (_selectedType == 'دخل') {
        matchesType = t.type == TransactionType.income;
      } else if (_selectedType == 'مصروف') {
        matchesType = t.type == TransactionType.expense;
      }

      return matchesSearch && matchesCategory && matchesType;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Sort by date descending
  }

  // Actions
  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void setBudget(double budget) {
    _monthlyBudget = budget;
    notifyListeners();
  }

  void updateFilters({String? search, String? category, String? type}) {
    if (search != null) _searchQuery = search;
    if (category != null) _selectedCategory = category;
    if (type != null) _selectedType = type;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = 'الكل';
    _selectedType = 'الكل';
    notifyListeners();
  }

  Map<String, double> getCategoryExpenses() {
    final Map<String, double> data = {};
    for (var cat in categories) {
      if (cat == 'راتب') continue; // Don't show income categories
      final sum = _transactions
          .where((t) => t.type == TransactionType.expense && t.category == cat)
          .fold(0.0, (sum, item) => sum + item.amount);
      if (sum > 0) {
        data[cat] = sum;
      }
    }
    return data;
  }
}
