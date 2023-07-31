import 'package:chat_app/domain/models/dialog_preview.dart';
import 'package:chat_app/domain/repository/dialogs_preview_repository.dart';

class DialogsPreviewUseCase {
  const DialogsPreviewUseCase({required this.dialogsPreviewRepository});
  final DialogsPreviewRepository dialogsPreviewRepository;

  Future<List<DialogPreview>> getAllDialogs() async{
    return dialogsPreviewRepository.getAll();
  }
}
