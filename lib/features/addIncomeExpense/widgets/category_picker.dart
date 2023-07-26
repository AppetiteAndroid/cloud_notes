// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cloud_notes/core/model/accounts_category_model.dart';

class CategoryPicker extends StatelessWidget {
  final String title;
  final Function() onTap;
  final AccountsCategoryModel? model;
  const CategoryPicker({
    Key? key,
    required this.title,
    required this.onTap,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => onTap.call(),
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
                    color: model == null ? Colors.grey : Colors.amber,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: model != null
                      ? Center(
                          child: Text(
                          model!.title[0].toString().toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ))
                      : const SizedBox(),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(model == null ? "Choose" : model!.title)),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
