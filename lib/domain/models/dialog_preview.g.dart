// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogPreview _$DialogPreviewFromJson(Map<String, dynamic> json) =>
    DialogPreview(
      userName: UserName.fromJson(json['userName'] as Map<String, dynamic>),
      lastMessage:
          Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$DialogPreviewToJson(DialogPreview instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'lastMessage': instance.lastMessage,
      'imagePath': instance.imagePath,
    };
