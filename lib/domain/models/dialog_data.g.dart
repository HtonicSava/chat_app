// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DialogDataAdapter extends TypeAdapter<DialogData> {
  @override
  final int typeId = 2;

  @override
  DialogData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DialogData(
      messagesPerDay: (fields[0] as List).cast<DayDialogHistory>(),
    );
  }

  @override
  void write(BinaryWriter writer, DialogData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.messagesPerDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DialogDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
