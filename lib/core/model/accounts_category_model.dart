// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'accounts_category_model.g.dart';

@HiveType(typeId: 1)
class AccountsCategoryModel extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? path;
  @HiveField(2)
  final bool isDefault;
  const AccountsCategoryModel({
    required this.title,
    this.path,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [title, path, isDefault];

  AccountsCategoryModel copyWith({
    String? title,
    String? path,
    bool? isDefault,
  }) {
    return AccountsCategoryModel(
      title: title ?? this.title,
      path: path ?? this.path,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
