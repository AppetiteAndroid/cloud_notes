// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_notes/core/constants.dart';
import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_model.dart';
import 'package:cloud_notes/core/widgets/app_unfocus.dart';
import 'package:cloud_notes/features/addIncomeExpense/widgets/category_picker.dart';
import 'package:cloud_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
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
  DateTime _currentDate = DateTime.now();
  late Accounts accounts;

  @override
  void initState() {
    final categoryBox = Hive.box<AccountsCategoryModel>(widget.accountsEnum == AccountsEnum.expense ? Constants.categoriesExpenses : Constants.categoriesIncomes);
    final payTypeBox = Hive.box<AccountsCategoryModel>(Constants.paymentTypes);
    accounts = Accounts(
      sum: 0,
      accountsType: widget.accountsEnum,
      category: categoryBox.isEmpty ? null : categoryBox.values.firstWhere((element) => element.isDefault),
      payType: payTypeBox.isEmpty ? null : payTypeBox.values.firstWhere((element) => element.isDefault),
    );
    super.initState();
  }

  _showBottomSheet(BuildContext context, CategoriesBottomSheetType categoriesBottomSheet) {
    showCustomBottomSheet(
            builder: (context, scrollController) {
              return BlocProvider.value(
                value: context.read<HomeBloc>(),
                child: CategoriesBottomSheet(
                  scrollController: scrollController,
                  categoriesBottomSheetType: categoriesBottomSheet,
                  accountsEnum: widget.accountsEnum,
                ),
              );
            },
            context: context,
            color: Colors.white,
            title: Text(categoriesBottomSheet == CategoriesBottomSheetType.categories ? "Categories" : "Payment Methods"),
            maxHeight: MediaQuery.of(context).size.height * 0.7)
        .then((value) {
      if (value is AccountsCategoryModel) {
        if (categoriesBottomSheet == CategoriesBottomSheetType.categories) {
          accounts = accounts.copyWith(category: value);
        } else {
          accounts = accounts.copyWith(payType: value);
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppUnfocus(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.accountsEnum == AccountsEnum.income ? "Income" : "Expense"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!Income
              const SizedBox(height: 16),
              Text(
                widget.accountsEnum == AccountsEnum.income ? "Income" : "Expense",
                style: const TextStyle(fontSize: 20, color: Colors.green),
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
                  decoration: InputDecoration.collapsed(hintText: widget.accountsEnum == AccountsEnum.income ? "Income" : "Expense"),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onChanged: (value) {
                    accounts = accounts.copyWith(sum: double.parse(value));
                    setState(() {});
                  },
                ),
              ),
              //!Category
              CategoryPicker(
                title: "Category",
                onTap: () => _showBottomSheet(context, CategoriesBottomSheetType.categories),
                model: accounts.category,
              ),
              //! Payment method
              CategoryPicker(
                title: "Payment method",
                onTap: () => _showBottomSheet(context, CategoriesBottomSheetType.payType),
                model: accounts.payType,
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
                child: TextField(
                  onChanged: (value) {
                    accounts = accounts.copyWith(note: value);
                  },
                  decoration: const InputDecoration.collapsed(hintText: "Not required"),
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
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _currentDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030),
                            );
                            if (pickedDate != null) {
                              _currentDate = pickedDate;
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(DateFormat("d / MM / y").format(_currentDate)),
                          ),
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
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: _currentDate.hour, minute: _currentDate.minute),
                            );
                            if (pickedTime != null) {
                              _currentDate = _currentDate.copyWith(hour: pickedTime.hour, minute: pickedTime.minute);
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(DateFormat("HH : mm").format(_currentDate)),
                          ),
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
                onPressed: accounts.isValid
                    ? () {
                        context.read<HomeBloc>().add(AddAccountToBack(accounts.copyWith(date: _currentDate)));
                        Navigator.of(context).pop();
                      }
                    : null,
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
