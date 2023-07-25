// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'accounts_category_model.g.dart';

@HiveType(typeId: 1)
class AccountsCategoryModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? path;
  const AccountsCategoryModel({
    required this.id,
    required this.title,
    this.path,
  });

  @override
  List<Object?> get props => [id, title, path];

  AccountsCategoryModel copyWith({
    int? id,
    String? title,
    String? path,
  }) {
    return AccountsCategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
    );
  }
}
