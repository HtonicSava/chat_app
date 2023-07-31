import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/message.dart';
import 'package:chat_app/domain/repository/dialogs_data_repository.dart';

class DialogsUseCase {
  const DialogsUseCase({required this.dialogsDataRepository});

  final DialogsDataRepository dialogsDataRepository;

  Future<Message> checkNewMessage(int dialogIndex) async {
    return dialogsDataRepository.checkNewMessage(dialogIndex);
  }

  Future<DialogData> getDialogData(int dialogIndex) async {
    return dialogsDataRepository.getData(dialogIndex);
  }

  Future sendMessage(
      {required int dialogIndex, required DialogData updatedData}) async {
    return dialogsDataRepository.sendMessage(
        dialogIndex: dialogIndex, updatedData: updatedData);
  }
}
