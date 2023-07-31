import 'package:chat_app/domain/models/dialog_preview.dart';

abstract interface class DialogsPreviewRepository {
  Future<List<DialogPreview>> getAll();
}
