import 'package:chat_app/domain/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogMessageWidget extends StatelessWidget {
  const DialogMessageWidget({Key? key, required this.message})
      : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: message.isMine ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: message.isMine
                ? const Radius.circular(25)
                : const Radius.circular(0),
            topRight: const Radius.circular(25),
            bottomLeft: const Radius.circular(25),
            bottomRight: message.isMine
                ? const Radius.circular(0)
                : const Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  message.text,
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(DateFormat('HH:mm').format(message.sendingDate),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
