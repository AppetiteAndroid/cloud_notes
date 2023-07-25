// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsEnumAdapter extends TypeAdapter<AccountsEnum> {
  @override
  final int typeId = 0;

  @override
  AccountsEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AccountsEnum.income;
      case 1:
        return AccountsEnum.expense;
      default:
        return AccountsEnum.income;
    }
  }

  @override
  void write(BinaryWriter writer, AccountsEnum obj) {
    switch (obj) {
      case AccountsEnum.income:
        writer.writeByte(0);
        break;
      case AccountsEnum.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
