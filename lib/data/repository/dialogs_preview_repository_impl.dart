import 'package:chat_app/data/sources/dialogs_preview_source.dart';
import 'package:chat_app/domain/models/dialog_preview.dart';
import 'package:chat_app/domain/repository/dialogs_preview_repository.dart';

class DialogsPreviewRepositoryImpl implements DialogsPreviewRepository {
  const DialogsPreviewRepositoryImpl({required this.source});
  final DialogsPreviewSource source;
  @override
  Future<List<DialogPreview>> getAll() async {
    return source.getAll();
  }
}
