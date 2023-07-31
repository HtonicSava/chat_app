import 'package:chat_app/domain/models/message.dart';
import 'package:hive/hive.dart';

part 'day_dialog_history.g.dart';

@HiveType(typeId: 1)
class DayDialogHistory {
  const DayDialogHistory({required this.date, required this.messages});

  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final List<Message> messages;

  DayDialogHistory pushMessage(Message message) {
    return DayDialogHistory(date: date, messages: [...messages, message]);
  }

  factory DayDialogHistory.fromJson(Map<String, dynamic> json) =>
      _$DayDialogHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$DayDialogHistoryToJson(this);
}

DayDialogHistory _$DayDialogHistoryFromJson(Map<String, dynamic> json) =>
    DayDialogHistory(
      date: DateTime.parse(json['date'] as String),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayDialogHistoryToJson(DayDialogHistory instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };
