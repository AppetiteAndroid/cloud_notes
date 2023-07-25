// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:cloud_notes/core/model/accounts_category_model.dart';

enum CategoriesBottomSheetType { categories, payType }

class CategoriesBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final CategoriesBottomSheetType categoriesBottomSheetType;
  const CategoriesBottomSheet({
    Key? key,
    required this.scrollController,
    required this.categoriesBottomSheetType,
  }) : super(key: key);
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
                child: const TextField(
                  decoration: InputDecoration.collapsed(hintText: "title"),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {},
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
              valueListenable: Hive.box<AccountsCategoryModel>(categoriesBottomSheetType == CategoriesBottomSheetType.payType ? "payment_types" : "categories").listenable(),
              builder: (context, box, widget) {
                return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final item = (box.values.toList()[index] as AccountsCategoryModel);
                      return SizedBox(
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
                          ],
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
