// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_dialog_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayDialogHistoryAdapter extends TypeAdapter<DayDialogHistory> {
  @override
  final int typeId = 1;

  @override
  DayDialogHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayDialogHistory(
      date: fields[0] as DateTime,
      messages: (fields[1] as List).cast<Message>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayDialogHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayDialogHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
