// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_notes/core/constants.dart';
import 'package:cloud_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_enum.dart';

enum CategoriesBottomSheetType { categories, payType }

class CategoriesBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final CategoriesBottomSheetType categoriesBottomSheetType;
  final AccountsEnum accountsEnum;
  const CategoriesBottomSheet({
    Key? key,
    required this.scrollController,
    required this.categoriesBottomSheetType,
    required this.accountsEnum,
  }) : super(key: key);

  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  String _title = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) {
                    _title = value;
                    setState(() {});
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration.collapsed(hintText: "Title"),
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: _title.isNotEmpty
                    ? () {
                        context.read<HomeBloc>().add(widget.categoriesBottomSheetType == CategoriesBottomSheetType.categories ? AddNewCategory(_title, widget.accountsEnum) : AddNewPayType(_title));
                        Navigator.of(context).pop(AccountsCategoryModel(title: _title));
                      }
                    : null,
                child: const Text("Add"),
              ),
              const SizedBox(height: 24),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<Box>(
              valueListenable: Hive.box<AccountsCategoryModel>(
                widget.categoriesBottomSheetType == CategoriesBottomSheetType.payType
                    ? Constants.paymentTypes
                    : widget.accountsEnum == AccountsEnum.expense
                        ? Constants.categoriesExpenses
                        : Constants.categoriesIncomes,
              ).listenable(),
              builder: (context, box, widget) {
                return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    controller: this.widget.scrollController,
                    itemBuilder: (context, index) {
                      final item = (box.values.toList()[index] as AccountsCategoryModel);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(item);
                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
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
                              Expanded(child: Text(item.title)),
                              Checkbox(
                                value: item.isDefault,
                                onChanged: (value) {
                                  context.read<HomeBloc>().add(
                                        this.widget.categoriesBottomSheetType == CategoriesBottomSheetType.categories
                                            ? ChangeDefaultCategory(index, this.widget.accountsEnum)
                                            : ChangeDefaultPayType(index),
                                      );
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: box.length);
              }),
        )
      ],
    );
  }
}
