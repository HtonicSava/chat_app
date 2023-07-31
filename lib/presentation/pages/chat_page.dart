import 'dart:async';

import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/dialog_preview.dart';
import 'package:chat_app/domain/use_case/dialogs_preview_use_case.dart';
import 'package:chat_app/domain/use_case/dialogs_use_case.dart';
import 'package:chat_app/presentation/bloc/dialogs_bloc/dialogs_bloc.dart';
import 'package:chat_app/presentation/widgets/dialog_label_widget.dart';
import 'package:chat_app/presentation/widgets/dialog_message_widget.dart';
import 'package:chat_app/presentation/widgets/dialog_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {Key? key, required this.previewsUseCase, required this.dialogsUseCase})
      : super(key: key);

  final DialogsPreviewUseCase previewsUseCase;
  final DialogsUseCase dialogsUseCase;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _focusNode = FocusNode();
  late final Timer timer;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      context.read<DialogsBloc>().add(const CheckMessage());
    });
  }

  cancelTimer() {}

  void _sendMessage() {
    if (_messageController.text.isEmpty) {
      return;
    }
    context.read<DialogsBloc>().add(SendMessage(_messageController.text));
    _messageController.clear();
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    context.read<DialogsBloc>().add(const GetPreviews());
    context.read<DialogsBloc>().add(const ChoseDialog(0));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DialogsBloc, DialogsState>(
        // buildWhen: (prev, curr) {
        //   return prev.previewsStatus != curr.previewsStatus;
        // },
        builder: (context, state) {
          return state.previewsStatus == DialogsPreviewStatus.downloaded
              ? Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 540),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: _Previews(
                          previews: state.previews!,
                          chosenDialogIndex: state.chosenDialogIndex,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    Image.asset('images/background.png').image),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(200),
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200,
                                                width: 1))),
                                    child: SizedBox(
                                      height: 80,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 9),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (state.dataStatus ==
                                                DialogsDataStatus.downloaded)
                                              DialogLabelWidget(
                                                  dialogPreview: state
                                                          .previews![
                                                      state.chosenDialogIndex!],
                                                  dialogIndex:
                                                      state.chosenDialogIndex!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                left: 0,
                                top: 80,
                                right: 0,
                                bottom: 90,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: Colors.grey.shade200,
                                              width: 1))),
                                  child: state.dataStatus ==
                                          DialogsDataStatus.downloaded
                                      ? _Dialog(dialogData: state.data!)
                                      : const Center(
                                          child: CircularProgressIndicator()),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 90,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            left: BorderSide(
                                                color: Colors.grey.shade200,
                                                width: 1))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: TextField(
                                            focusNode: _focusNode,
                                            controller: _messageController,
                                            onSubmitted: (_) => _sendMessage(),
                                            decoration: const InputDecoration(
                                              hintText:
                                                  'Начни писать что-нибудь...',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                            ),
                                          )),
                                          const SizedBox(width: 16),
                                          IconButton(
                                              onPressed: _sendMessage,
                                              icon: const Icon(
                                                Icons.send,
                                                size: 40,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class _Previews extends StatelessWidget {
  const _Previews(
      {Key? key, required this.previews, required this.chosenDialogIndex})
      : super(key: key);

  final List<DialogPreview> previews;
  final int? chosenDialogIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: previews.length,
      itemBuilder: (BuildContext context, int i) => DialogPreviewWidget(
        dialogData: previews[i],
        isActive: i == chosenDialogIndex,
        callback: () {
          context.read<DialogsBloc>().add(ChoseDialog(i));
        },
      ),
    );
  }
}

class _Dialog extends StatefulWidget {
  const _Dialog({Key? key, required this.dialogData}) : super(key: key);

  final DialogData dialogData;

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final _scrollController = ScrollController();

  void _scrollListToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollListToBottom();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DialogsBloc, DialogsState>(
      listenWhen: (prev, current) {
        return prev.data != current.data;
      },
      listener: (context, state) {
        _scrollListToBottom();
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.dialogData.messagesPerDay.length,
                itemBuilder: (BuildContext context, int dayIndex) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 4),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat.MMMMd('ru').format(widget
                                .dialogData.messagesPerDay[dayIndex].date),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      for (final item in widget
                          .dialogData.messagesPerDay[dayIndex].messages)
                        Align(
                            alignment: item.isMine
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32, bottom: 16),
                              child: DialogMessageWidget(message: item),
                            ))
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
