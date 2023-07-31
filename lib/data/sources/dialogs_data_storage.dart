import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:hive/hive.dart';

class DialogsDataStorage {
  const DialogsDataStorage({required this.dialogsBox});

  final Box dialogsBox;

  Future<DialogData?> getData(int dialogIndex) async {
    return dialogsBox.get(dialogIndex);
  }

  Future saveDialogData(int dialogIndex, DialogData updatedData) async {
    await dialogsBox.put(dialogIndex, updatedData);
  }
}
