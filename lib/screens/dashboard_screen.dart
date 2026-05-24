import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'طعام':
        return Icons.fastfood_rounded;
      case 'تسوق':
        return Icons.shopping_bag_rounded;
      case 'مواصلات':
        return Icons.directions_car_rounded;
      case 'ترفيه':
        return Icons.sports_esports_rounded;
      case 'فواتير':
        return Icons.receipt_long_rounded;
      case 'راتب':
        return Icons.account_balance_wallet_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'طعام':
        return Colors.orange;
      case 'تسوق':
        return Colors.pink;
      case 'مواصلات':
        return Colors.blue;
      case 'ترفيه':
        return Colors.purple;
      case 'فواتير':
        return Colors.red;
      case 'راتب':
        return AppTheme.income;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final currencyFormat = intl.NumberFormat.currency(symbol: 'ر.س ', decimalDigits: 2);
    final dateFormat = intl.DateFormat('yyyy/MM/dd');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Custom Glassmorphic Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [AppTheme.primary, AppTheme.primaryLight],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primary.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 24,
                              backgroundColor: AppTheme.darkCard,
                              child: Text(
                                '👤',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'مرحباً بك،',
                                style: TextStyle(
                                  color: AppTheme.textSecondaryDark,
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                'المستخدم الكريم',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.darkCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0x1AFFFFFF)),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Total Balance Premium Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primary,
                          AppTheme.primaryLight.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إجمالي الرصيد المتوفر',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currencyFormat.format(provider.totalBalance),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            // Income Display
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_downward_rounded,
                                      color: AppTheme.income,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'الدخـل',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(provider.totalIncome),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Divider
                            Container(
                              height: 35,
                              width: 1,
                              color: Colors.white.withOpacity(0.2),
                            ),
                            const SizedBox(width: 16),
                            // Expense Display
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_upward_rounded,
                                      color: AppTheme.expense,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'المصروفات',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(provider.totalExpenses),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Monthly Budget Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'الميزانية الشهرية والإنفاق',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.edit_rounded, size: 16, color: AppTheme.primaryLight),
                                label: const Text(
                                  'تعديل الميزانية',
                                  style: TextStyle(color: AppTheme.primaryLight, fontSize: 13),
                                ),
                                onPressed: () => _showEditBudgetDialog(context, provider),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الميزانية: ${currencyFormat.format(provider.monthlyBudget)}',
                                style: TextStyle(color: AppTheme.textSecondaryDark, fontSize: 13),
                              ),
                              Text(
                                'المستهلك: %${(provider.budgetProgressPercentage * 100).toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: provider.budgetProgressPercentage >= 0.9
                                      ? AppTheme.expense
                                      : provider.budgetProgressPercentage >= 0.7
                                          ? AppTheme.budgetWarning
                                          : AppTheme.income,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: provider.budgetProgressPercentage,
                              minHeight: 10,
                              backgroundColor: const Color(0x1AFFFFFF),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                provider.budgetProgressPercentage >= 0.9
                                    ? AppTheme.expense
                                    : provider.budgetProgressPercentage >= 0.7
                                        ? AppTheme.budgetWarning
                                        : AppTheme.income,
                              ),
                            ),
                          ),
                          if (provider.totalExpenses > provider.monthlyBudget)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: const [
                                  Icon(Icons.warning_amber_rounded, color: AppTheme.expense, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'تنبيه: لقد تجاوزت الميزانية المحددة لهذا الشهر!',
                                    style: TextStyle(color: AppTheme.expense, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Categories Spending Bar Chart Overview
              if (provider.getCategoryExpenses().isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'توزيع المصروفات حسب الأقسام',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...provider.getCategoryExpenses().entries.map((entry) {
                              final category = entry.key;
                              final amount = entry.value;
                              final percentage = amount / provider.totalExpenses;
                              final color = _getCategoryColor(category);

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(_getCategoryIcon(category), color: color, size: 16),
                                            const SizedBox(width: 8),
                                            Text(category, style: const TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                        Text(
                                          '${currencyFormat.format(amount)} (${(percentage * 100).toStringAsFixed(0)}%)',
                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: LinearProgressIndicator(
                                        value: percentage,
                                        minHeight: 6,
                                        backgroundColor: const Color(0x0AFFFFFF),
                                        valueColor: AlwaysStoppedAnimation<Color>(color),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Search and Filter Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Column(
                    children: [
                      // Search Input
                      TextField(
                        onChanged: (val) => provider.updateFilters(search: val),
                        decoration: InputDecoration(
                          hintText: 'البحث عن معاملة...',
                          prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
                          suffixIcon: provider.searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear_rounded, color: Colors.grey),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    provider.updateFilters(search: '');
                                  },
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Transaction Type Filter Buttons
                      Row(
                        children: [
                          _buildFilterButton(context, provider, 'الكل', provider.selectedType == 'الكل'),
                          const SizedBox(width: 8),
                          _buildFilterButton(context, provider, 'دخل', provider.selectedType == 'دخل'),
                          const SizedBox(width: 8),
                          _buildFilterButton(context, provider, 'مصروف', provider.selectedType == 'مصروف'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Category Filter Horizontal List
                      SizedBox(
                        height: 38,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _buildCategoryChip(context, provider, 'الكل', provider.selectedCategory == 'الكل'),
                            ...provider.categories.map((cat) {
                              return _buildCategoryChip(context, provider, cat, provider.selectedCategory == cat);
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Transactions List or Empty Placeholder
              provider.filteredTransactions.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppTheme.darkCard,
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0x0DFFFFFF)),
                              ),
                              child: const Icon(
                                Icons.receipt_long_rounded,
                                size: 50,
                                color: AppTheme.textSecondaryDark,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'لا توجد معاملات مطابقة!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'ابدأ بإضافة أول معاملة مالية لتسجيلها وحسابها.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textSecondaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final tx = provider.filteredTransactions[index];
                          final isIncome = tx.type == TransactionType.income;
                          final color = _getCategoryColor(tx.category);

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                            child: Dismissible(
                              key: Key(tx.id),
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: AppTheme.expense.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppTheme.expense.withOpacity(0.5)),
                                ),
                                child: const Icon(Icons.delete_forever_rounded, color: AppTheme.expense, size: 28),
                              ),
                              onDismissed: (direction) {
                                provider.deleteTransaction(tx.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تم حذف المعاملة "${tx.title}" بنجاح.'),
                                    backgroundColor: AppTheme.darkCard,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  leading: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      _getCategoryIcon(tx.category),
                                      color: color,
                                      size: 24,
                                    ),
                                  ),
                                  title: Text(
                                    tx.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            tx.category,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: color,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            dateFormat.format(tx.date),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.textSecondaryDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (tx.notes != null && tx.notes!.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          tx.notes!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppTheme.textSecondaryDark.withOpacity(0.8),
                                           fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${isIncome ? '+' : '-'}${currencyFormat.format(tx.amount).replaceAll('ر.س', '')}',
                                        style: TextStyle(
                                          color: isIncome ? AppTheme.income : AppTheme.expense,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ر.س',
                                        style: TextStyle(
                                          color: isIncome ? AppTheme.income : AppTheme.expense,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: provider.filteredTransactions.length,
                      ),
                    ),
              
              // Bottom Spacer
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppTheme.primary,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            'معاملة جديدة',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          onPressed: () => _showAddTransactionSheet(context, provider),
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, TransactionProvider provider, String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => provider.updateFilters(type: label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : AppTheme.darkCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.primaryLight : const Color(0x1AFFFFFF),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textSecondaryDark,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, TransactionProvider provider, String category, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        selectedColor: AppTheme.primary.withOpacity(0.3),
        checkmarkColor: AppTheme.primaryAccent,
        backgroundColor: AppTheme.darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected ? AppTheme.primary : const Color(0x1AFFFFFF),
          ),
        ),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppTheme.textSecondaryDark,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        onSelected: (val) {
          provider.updateFilters(category: category);
        },
      ),
    );
  }

  void _showEditBudgetDialog(BuildContext context, TransactionProvider provider) {
    final controller = TextEditingController(text: provider.monthlyBudget.toString());
    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('تعديل الميزانية الشهرية'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('أدخل حد الإنفاق الأقصى الذي ترغب به لهذا الشهر:'),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'الميزانية (ر.س)',
                    prefixIcon: Icon(Icons.account_balance_wallet_rounded),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
                onPressed: () => Navigator.pop(ctx),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
                child: const Text('حفظ', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  final budget = double.tryParse(controller.text) ?? 0.0;
                  if (budget > 0) {
                    provider.setBudget(budget);
                    Navigator.pop(ctx);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddTransactionSheet(BuildContext context, TransactionProvider provider) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final notesController = TextEditingController();
    String selectedCategory = provider.categories.first;
    TransactionType selectedType = TransactionType.expense;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.darkCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (stContext, setState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(stContext).viewInsets.bottom + 20,
                  top: 24,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'إضافة معاملة مالية جديدة',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      
                      // Type Switch (Income / Expense)
                      Row(
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: const SizedBox(
                                width: double.infinity,
                                child: Text('مصروف', textAlign: TextAlign.center),
                              ),
                              selected: selectedType == TransactionType.expense,
                              selectedColor: AppTheme.expense.withOpacity(0.2),
                              backgroundColor: const Color(0x0AFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: selectedType == TransactionType.expense
                                      ? AppTheme.expense
                                      : Colors.transparent,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: selectedType == TransactionType.expense ? AppTheme.expense : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (val) {
                                setState(() {
                                  selectedType = TransactionType.expense;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ChoiceChip(
                              label: const SizedBox(
                                width: double.infinity,
                                child: Text('دخل', textAlign: TextAlign.center),
                              ),
                              selected: selectedType == TransactionType.income,
                              selectedColor: AppTheme.income.withOpacity(0.2),
                              backgroundColor: const Color(0x0AFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: selectedType == TransactionType.income
                                      ? AppTheme.income
                                      : Colors.transparent,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: selectedType == TransactionType.income ? AppTheme.income : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (val) {
                                setState(() {
                                  selectedType = TransactionType.income;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Title field
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'العنوان (مثال: وجبة عشاء، راتب إضافي)',
                          prefixIcon: Icon(Icons.title_rounded),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Amount field
                      TextField(
                        controller: amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'المبلغ (ر.س)',
                          prefixIcon: Icon(Icons.attach_money_rounded),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        dropdownColor: AppTheme.darkCard,
                        decoration: const InputDecoration(
                          labelText: 'القسم أو التصنيف',
                          prefixIcon: Icon(Icons.folder_rounded),
                        ),
                        items: provider.categories.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat,
                            child: Text(cat),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedCategory = val;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 14),

                      // Notes field
                      TextField(
                        controller: notesController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'ملاحظات إضافية (اختياري)',
                          prefixIcon: Icon(Icons.note_rounded),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Add Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedType == TransactionType.income
                                ? AppTheme.income
                                : AppTheme.expense,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            selectedType == TransactionType.income ? 'إضافة الدخـل' : 'إضافة المصروف',
                            style: const TextStyle(
                              color: AppTheme.darkBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            final title = titleController.text.trim();
                            final amount = double.tryParse(amountController.text) ?? 0.0;
                            
                            if (title.isNotEmpty && amount > 0) {
                              final newTx = Transaction(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                title: title,
                                amount: amount,
                                category: selectedCategory,
                                type: selectedType,
                                date: DateTime.now(),
                                notes: notesController.text.trim(),
                              );
                              
                              provider.addTransaction(newTx);
                              Navigator.pop(ctx);
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تم تسجيل المعاملة بنجاح!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(stContext).showSnackBar(
                                const SnackBar(
                                  content: Text('يرجى ملء الحقول وتحديد مبلغ صحيح.'),
                                  backgroundColor: AppTheme.expense,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
              
                          
