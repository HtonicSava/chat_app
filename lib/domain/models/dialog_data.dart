import 'package:chat_app/domain/models/day_dialog_history.dart';
import 'package:chat_app/domain/models/message.dart';
import 'package:hive/hive.dart';

part 'dialog_data.g.dart';

@HiveType(typeId: 2)
class DialogData {
  const DialogData({required this.messagesPerDay});
  @HiveField(0)
  final List<DayDialogHistory> messagesPerDay;

  DialogData pushMessage(Message message) {
    final lastDayHistory = messagesPerDay.last.pushMessage(message);
    return DialogData(messagesPerDay: [
      ...messagesPerDay.sublist(0, messagesPerDay.length - 1),
      lastDayHistory
    ]);
  }

  factory DialogData.fromJson(Map<String, dynamic> json) =>
      _$DialogDataFromJson(json);
  Map<String, dynamic> toJson() => _$DialogDataToJson(this);
}

DialogData _$DialogDataFromJson(Map<String, dynamic> json) => DialogData(
      messagesPerDay: (json['messagesPerDay'] as List<dynamic>)
          .map((e) => DayDialogHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DialogDataToJson(DialogData instance) =>
    <String, dynamic>{
      'messagesPerDay': instance.messagesPerDay.map((e) => e.toJson()).toList(),
    };
