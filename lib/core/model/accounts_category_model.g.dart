// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsCategoryModelAdapter extends TypeAdapter<AccountsCategoryModel> {
  @override
  final int typeId = 1;

  @override
  AccountsCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountsCategoryModel(
      id: fields[0] as int,
      title: fields[1] as String,
      path: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
