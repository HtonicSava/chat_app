import 'package:chat_app/domain/models/dialog_preview.dart';
import 'package:flutter/material.dart';

class DialogLabelWidget extends StatelessWidget {
  const DialogLabelWidget(
      {Key? key, required this.dialogPreview, required this.dialogIndex})
      : super(key: key);

  final DialogPreview dialogPreview;
  final int dialogIndex;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Image.asset(dialogPreview.imagePath),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${dialogPreview.userName.firstName} ${dialogPreview.userName.lastName}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'license: $dialogIndex',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
