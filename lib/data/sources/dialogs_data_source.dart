import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/message.dart';

abstract interface class DialogsDataSource {
  Future<Message> checkNewMessage(int dialogIndex);
  Future<DialogData> getData(int dialogIndex);
}
