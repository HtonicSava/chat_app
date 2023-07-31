import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message {
  const Message(
      {required this.text, required this.sendingDate, this.isMine = true});

  @HiveField(0)
  final String text;
  @HiveField(1)
  final DateTime sendingDate;
  @HiveField(2)
  final bool isMine;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      text: json['text'] as String,
      sendingDate: DateTime.parse(json['sendingDate'] as String),
      isMine: json['isMine'] as bool? ?? true,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'text': instance.text,
      'sendingDate': instance.sendingDate.toIso8601String(),
      'isMine': instance.isMine,
    };
