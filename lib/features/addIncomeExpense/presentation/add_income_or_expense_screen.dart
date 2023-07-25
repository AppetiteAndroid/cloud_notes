// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_model.dart';
import 'package:cloud_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:cloud_notes/core/customBottomSheet/CustomBottomSheetPage.dart';
import 'package:cloud_notes/core/model/accounts_enum.dart';
import 'package:cloud_notes/features/addIncomeExpense/widgets/categories_bottomsheet.dart';

class AddIncomeExpenseScreen extends StatefulWidget {
  static Route route(AccountsEnum accountsEnum) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: context.read<HomeBloc>(),
        child: AddIncomeExpenseScreen(
          accountsEnum: accountsEnum,
        ),
      ),
    );
  }

  final AccountsEnum accountsEnum;
  const AddIncomeExpenseScreen({
    Key? key,
    required this.accountsEnum,
  }) : super(key: key);

  @override
  State<AddIncomeExpenseScreen> createState() => _AddIncomeExpenseScreenState();
}

class _AddIncomeExpenseScreenState extends State<AddIncomeExpenseScreen> {
  final DateTime _currentDate = DateTime.now();
  late Accounts accounts;

  @override
  void initState() {
    accounts = Accounts(0, const AccountsCategoryModel(id: 0, title: "Onay"), const AccountsCategoryModel(id: 0, title: "Cash"), null, _currentDate, widget.accountsEnum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Income"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_box_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!Income
            const SizedBox(height: 16),
            const Text(
              "Income",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: const InputDecoration.collapsed(hintText: "Income"),
                keyboardType: TextInputType.number,
                maxLines: 1,
                onChanged: (value) {
                  accounts = accounts.copyWith(sum: double.parse(value));
                },
              ),
            ),
            //!Category
            const SizedBox(height: 12),
            const Text(
              "Category",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showCustomBottomSheet(
                    builder: (context, scrollController) {
                      return CategoriesBottomSheet(
                        scrollController: scrollController,
                        categoriesBottomSheetType: CategoriesBottomSheetType.categories,
                      );
                    },
                    context: context,
                    color: Colors.white,
                    title: const Text("Categories"),
                    maxHeight: MediaQuery.of(context).size.height * 0.7);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                          child: Text(
                        "O",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: Text("Onay")),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            //! Payment method
            const SizedBox(height: 12),
            const Text(
              "Payment method",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showCustomBottomSheet(
                    builder: (context, scrollController) {
                      return CategoriesBottomSheet(
                        scrollController: scrollController,
                        categoriesBottomSheetType: CategoriesBottomSheetType.payType,
                      );
                    },
                    context: context,
                    color: Colors.white,
                    title: const Text("Payment methods"),
                    maxHeight: MediaQuery.of(context).size.height * 0.7);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                          child: Text(
                        "K",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: Text("Kaspi Gold")),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            //! Note
            const SizedBox(height: 12),
            const Text(
              "Note",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: const TextField(
                decoration: InputDecoration.collapsed(hintText: "Not required"),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            //! Date
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Note
                      const Text(
                        "Date",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(DateFormat("d / MM / y").format(_currentDate)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Time
                      const Text(
                        "Time",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(DateFormat("HH : mm").format(_currentDate)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                context.read<HomeBloc>().add(AddAccountToBack(accounts));
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
