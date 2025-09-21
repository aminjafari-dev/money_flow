// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardModelAdapter extends TypeAdapter<DashboardModel> {
  @override
  final int typeId = 0;

  @override
  DashboardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardModel(
      totalIncome: fields[0] as double,
      totalExpenses: fields[1] as double,
      totalCharity: fields[2] as double,
      totalInvestments: fields[3] as double,
      recentTransactions: (fields[4] as List).cast<TransactionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DashboardModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.totalIncome)
      ..writeByte(1)
      ..write(obj.totalExpenses)
      ..writeByte(2)
      ..write(obj.totalCharity)
      ..writeByte(3)
      ..write(obj.totalInvestments)
      ..writeByte(4)
      ..write(obj.recentTransactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
