// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsAdapter extends TypeAdapter<Accounts> {
  @override
  final int typeId = 2;

  @override
  Accounts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Accounts(
      sum: fields[0] as double,
      category: fields[1] as AccountsCategoryModel?,
      payType: fields[2] as AccountsCategoryModel?,
      note: fields[3] as String?,
      date: fields[4] as DateTime?,
      accountsType: fields[5] as AccountsEnum,
      id: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Accounts obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.sum)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.payType)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.accountsType)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
