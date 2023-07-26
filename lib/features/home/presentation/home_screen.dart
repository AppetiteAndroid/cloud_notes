import 'package:cloud_notes/features/home/presentation/widgets/all_page.dart';
import 'package:flutter/material.dart';

import '../../../core/model/accounts_enum.dart';
import '../../addIncomeExpense/presentation/add_income_or_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this)..addListener(_tabsListener);
    super.initState();
  }

  _tabsListener() {
    _tabIndex = _tabController.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          duration: const Duration(milliseconds: 100),
          child: _tabIndex != 0
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(AddIncomeExpenseScreen.route(_tabIndex == 2 ? AccountsEnum.expense : AccountsEnum.income));
                  },
                  backgroundColor: Colors.lightBlue,
                  child: const Icon(Icons.add),
                )
              : const SizedBox()),
      body: SafeArea(
        child: Scaffold(
          appBar: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Incomes",
              ),
              Tab(
                text: "Expenses",
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              AllPage(
                key: Key("AllPage"),
              ),
              AllPage(
                key: Key("IncomePage"),
                accountsEnum: AccountsEnum.income,
              ),
              AllPage(
                key: Key("ExpensePage"),
                accountsEnum: AccountsEnum.expense,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
