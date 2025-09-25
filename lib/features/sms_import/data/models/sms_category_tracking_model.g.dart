// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_category_tracking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmsCategoryTrackingModelAdapter
    extends TypeAdapter<SmsCategoryTrackingModel> {
  @override
  final int typeId = 4;

  @override
  SmsCategoryTrackingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmsCategoryTrackingModel(
      smsId: fields[0] as String,
      category: fields[1] as String,
      mainCategory: fields[2] as String,
      addedAt: fields[3] as DateTime,
      transactionId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SmsCategoryTrackingModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.smsId)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.mainCategory)
      ..writeByte(3)
      ..write(obj.addedAt)
      ..writeByte(4)
      ..write(obj.transactionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmsCategoryTrackingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
