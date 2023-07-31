import 'package:chat_app/data/sources/dialogs_preview_source.dart';
import 'package:chat_app/domain/models/dialog_preview.dart';
import 'package:chat_app/domain/models/message.dart';
import 'package:chat_app/domain/models/user_name.dart';

class DialogsPreviewSourceMock implements DialogsPreviewSource {
  const DialogsPreviewSourceMock();
  @override
  Future<List<DialogPreview>> getAll() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.of([
      DialogPreview(
        userName: const UserName(firstName: 'Олег', lastName: 'Захаров'),
        imagePath: 'images/user1.png',
        lastMessage: Message(
          text: 'lorem ipsum',
          sendingDate: DateTime(2023, 6, 11, 46),
        ),
      ),
      DialogPreview(
        userName: const UserName(firstName: 'Егор', lastName: 'Просвирин'),
        imagePath: 'images/user2.png',
        lastMessage: Message(
          text: 'lorem ipsum',
          sendingDate: DateTime(2023, 6, 10, 38),
        ),
      ),
    ]);
  }
}
