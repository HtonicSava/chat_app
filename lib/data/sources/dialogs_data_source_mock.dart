import 'dart:convert';
import 'dart:js' as js;

import 'package:chat_app/data/sources/dialogs_data_source.dart';
import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/message.dart';

class DialogsDataSourceMock implements DialogsDataSource {
  const DialogsDataSourceMock();

  @override
  Future<Message> checkNewMessage(int dialogIndex) async {
    final res = js.context.callMethod('getMessage');
    return Message(
        text: res as String, sendingDate: DateTime.now(), isMine: false);
  }

  @override
  Future<DialogData> getData(int dialogIndex) async {
    await Future.delayed(const Duration(seconds: 2));
    final jsRes = js.context.callMethod('getDialog', [dialogIndex]);
    final jsonMap =
        jsonDecode(js.context['JSON'].callMethod('stringify', [jsRes]));
    return DialogData.fromJson(jsonMap);
  }
}
