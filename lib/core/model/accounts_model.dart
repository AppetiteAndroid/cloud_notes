// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_enum.dart';

part 'accounts_model.g.dart';

@HiveType(typeId: 2)
class Accounts extends Equatable {
  @HiveField(0)
  final double sum;
  @HiveField(1)
  final AccountsCategoryModel category;
  @HiveField(2)
  final AccountsCategoryModel payType;
  @HiveField(3, defaultValue: null)
  final String? note;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final AccountsEnum accountsType;

  const Accounts(
    this.sum,
    this.category,
    this.payType,
    this.note,
    this.date,
    this.accountsType,
  );

  @override
  List<Object?> get props {
    return [sum, category, payType, note, date, accountsType];
  }

  Accounts copyWith({
    double? sum,
    AccountsCategoryModel? category,
    AccountsCategoryModel? payType,
    String? note,
    DateTime? date,
    AccountsEnum? accountsType,
  }) {
    return Accounts(
      sum ?? this.sum,
      category ?? this.category,
      payType ?? this.payType,
      note ?? this.note,
      date ?? this.date,
      accountsType ?? this.accountsType,
    );
  }
}
