// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_notes/core/customBottomSheet/CustomBottomSheetPage.dart';
import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_model.dart';
import 'package:cloud_notes/features/home/presentation/widgets/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_notes/core/model/accounts_enum.dart';
import 'package:cloud_notes/features/home/presentation/widgets/accounts_list.dart';
import 'package:intl/intl.dart';

import '../bloc/home_bloc.dart';

class AllPage extends StatefulWidget {
  final AccountsEnum? accountsEnum;
  const AllPage({
    Key? key,
    this.accountsEnum,
  }) : super(key: key);

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> with AutomaticKeepAliveClientMixin {
  @override
  bool wantKeepAlive = true;

  Filter filter = Filter.all;

  @override
  void dispose() {
    debugPrint(widget.accountsEnum.toString());
    super.dispose();
  }

  Widget _categoryWithTitle(AccountsCategoryModel item, String title) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                item.title[0].toString(),
                style: const TextStyle(color: Colors.white),
              )),
            ),
            const SizedBox(width: 8),
            Text(item.title),
          ],
        ),
      ],
    );
  }

  _openItemBottomSheet(BuildContext context, Accounts item) {
    showCustomBottomSheet(
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _categoryWithTitle(item.category!, "Category"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _categoryWithTitle(item.payType!, "Pay Type"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Date",
                style: TextStyle(fontSize: 20),
              ),
              Text(DateFormat("dd/MMMM/y HH:mm").format(item.date!)),
              if (item.note != null) ...[
                const SizedBox(height: 10),
                const Text(
                  "Note",
                  style: TextStyle(fontSize: 20),
                ),
                Text(item.note ?? ""),
              ],
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "${item.accountsType == AccountsEnum.expense ? "Expense" : "Income"}:",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${item.accountsType == AccountsEnum.expense ? "-" : "+"}${item.sum}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(DeleteAccount(item));
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.delete_rounded)),
                  )
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
      color: Colors.white,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.accountsEnum == null
        ? "Total:"
        : widget.accountsEnum == AccountsEnum.expense
            ? "Expenses:-"
            : "Incomes:+";
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountsList(
                items: state.getElements(accountsEnum: widget.accountsEnum, filter: filter),
                onItemTap: (accounts) {
                  _openItemBottomSheet(context, accounts);
                },
                widgetsBefore: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$title${state.getTotal(accountsEnum: widget.accountsEnum)}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        if (widget.accountsEnum == null) ...[
                          const SizedBox(height: 8),
                          Text(
                            "Incomes:+${state.getTotal(accountsEnum: AccountsEnum.income)}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Expenses:-${state.getTotal(accountsEnum: AccountsEnum.expense)}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        FilterItem(
                            onTap: () {
                              setState(() {
                                filter = Filter.all;
                              });
                            },
                            title: "All",
                            isSelected: filter == Filter.all),
                        const SizedBox(width: 8),
                        FilterItem(
                            onTap: () {
                              setState(() {
                                filter = Filter.byDate;
                              });
                            },
                            title: "By Date",
                            isSelected: filter == Filter.byDate),
                        const SizedBox(width: 8),
                        FilterItem(
                            onTap: () {
                              setState(() {
                                filter = Filter.byCategory;
                              });
                            },
                            title: "By Category",
                            isSelected: filter == Filter.byCategory),
                        const SizedBox(width: 8),
                        FilterItem(
                            onTap: () {
                              setState(() {
                                filter = Filter.byPayType;
                              });
                            },
                            title: "By Payment Method",
                            isSelected: filter == Filter.byPayType),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
