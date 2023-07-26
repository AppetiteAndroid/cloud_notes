// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cloud_notes/core/model/accounts_model.dart';
import 'package:cloud_notes/core/model/ui_item.dart';
import 'package:cloud_notes/core/widgets/lazy_list_view.dart';

import '../../../../core/model/accounts_enum.dart';
import '../../../../core/model/group_title.dart';

class AccountsList extends StatelessWidget {
  final List<UiItem> items;
  final List<Widget> widgetsBefore;
  const AccountsList({
    Key? key,
    required this.items,
    required this.widgetsBefore,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LazyListView(
        childrenBefore: widgetsBefore,
        itemBuilder: (context, index) {
          var item = items[index];
          if (item is Accounts) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      item.category?.title[0].toString().toUpperCase() ?? "",
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.category?.title ?? ""),
                      Text(item.payType?.title ?? ""),
                    ],
                  )),
                  Text("${item.accountsType == AccountsEnum.expense ? '-' : '+'} ${item.sum}")
                ],
              ),
            );
          } else if (item is GroupTitle) {
            return Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [Expanded(child: Text(item.title)), Text("${item.total}")],
              ),
            );
          }
          return const SizedBox();
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: items.length,
      ),
    );
  }
}
