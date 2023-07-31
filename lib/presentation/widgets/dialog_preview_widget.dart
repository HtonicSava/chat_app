import 'package:chat_app/domain/models/dialog_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogPreviewWidget extends StatelessWidget {
  const DialogPreviewWidget(
      {Key? key,
      required this.dialogData,
      required this.callback,
      required this.isActive})
      : super(key: key);

  final DialogPreview dialogData;
  final VoidCallback callback;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? Colors.grey.shade200 : null,
      child: InkWell(
        onTap: callback,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 28, top: 18, bottom: 15, right: 15),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Image.asset(dialogData.imagePath),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${dialogData.userName.firstName} ${dialogData.userName.lastName}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      dialogData.lastMessage.text,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    DateFormat('HH:mm')
                        .format(dialogData.lastMessage.sendingDate),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
