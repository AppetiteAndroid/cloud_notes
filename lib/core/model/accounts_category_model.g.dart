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
      title: fields[0] as String,
      path: fields[1] as String?,
      isDefault: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.isDefault);
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
