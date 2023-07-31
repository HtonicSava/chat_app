import 'package:chat_app/data/sources/dialogs_data_source.dart';
import 'package:chat_app/data/sources/dialogs_data_storage.dart';
import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/message.dart';
import 'package:chat_app/domain/repository/dialogs_data_repository.dart';

class DialogsDataRepositoryImpl implements DialogsDataRepository {
  const DialogsDataRepositoryImpl(
      {required this.remoteSource, required this.storage});

  final DialogsDataSource remoteSource;
  final DialogsDataStorage storage;

  @override
  Future<Message> checkNewMessage(int dialogIndex) async {
    final message = await remoteSource.checkNewMessage(dialogIndex);
    return message;
  }

  @override
  Future<DialogData> getData(int dialogIndex) async {
    final localData = await storage.getData(dialogIndex);
    if (localData == null) {
      final remoteData = await remoteSource.getData(dialogIndex);
      storage.saveDialogData(dialogIndex, remoteData);
      return remoteData;
    } else {
      return localData;
    }
  }

  @override
  Future sendMessage(
      {required int dialogIndex, required DialogData updatedData}) async {
    return storage.saveDialogData(dialogIndex, updatedData);
  }
}
