import 'package:chat_app/domain/models/dialog_preview.dart';

abstract interface class DialogsPreviewSource {
  Future<List<DialogPreview>> getAll();
}
