import 'package:cloud_notes/core/model/accounts_enum.dart';
import 'package:cloud_notes/features/addIncomeExpense/presentation/add_income_or_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class IncomesPage extends StatefulWidget {
  const IncomesPage({Key? key}) : super(key: key);
  @override
  State<IncomesPage> createState() => _IncomesPageState();
}

class _IncomesPageState extends State<IncomesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AddIncomeExpenseScreen.route(AccountsEnum.income));
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total:${state.incomesTotal()}"),
                const SizedBox(height: 24),
                Expanded(
                    child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = state.accounts[index];
                    return SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Text(
                              item.category.title[0].toString(),
                              style: const TextStyle(color: Colors.white),
                            )),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.category.title),
                              Text(item.payType.title),
                            ],
                          )),
                          Text("${item.sum}")
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: state.accounts.length,
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
