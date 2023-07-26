// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_notes/features/home/presentation/widgets/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_notes/core/model/accounts_enum.dart';
import 'package:cloud_notes/features/home/presentation/widgets/accounts_list.dart';

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
