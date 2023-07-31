import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/message.dart';

abstract interface class DialogsDataRepository {
  Future<Message> checkNewMessage(int dialogIndex);
  Future<DialogData> getData(int dialogIndex);
  Future sendMessage(
      {required int dialogIndex, required DialogData updatedData});
}
