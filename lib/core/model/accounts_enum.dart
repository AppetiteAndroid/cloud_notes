import 'package:hive/hive.dart';
part 'accounts_enum.g.dart';

@HiveType(typeId: 0)
enum AccountsEnum {
  @HiveField(0)
  income,

  @HiveField(1)
  expense
}
