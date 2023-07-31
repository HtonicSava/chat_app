import 'package:chat_app/domain/models/message.dart';
import 'package:chat_app/domain/models/user_name.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dialog_preview.g.dart';

@JsonSerializable()
class DialogPreview {
  const DialogPreview(
      {required this.userName,
      required this.lastMessage,
      required this.imagePath});

  final UserName userName;
  final Message lastMessage;
  final String imagePath;

  factory DialogPreview.fromJson(Map<String, dynamic> json) =>
      _$DialogPreviewFromJson(json);
  Map<String, dynamic> toJson() => _$DialogPreviewToJson(this);
}
