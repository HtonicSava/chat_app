import 'dart:js_interop';

import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/dialog_preview.dart';
import 'package:chat_app/domain/models/message.dart';
import 'package:chat_app/domain/use_case/dialogs_preview_use_case.dart';
import 'package:chat_app/domain/use_case/dialogs_use_case.dart';
import 'package:equatable/equatable.dart';

part 'dialogs_event.dart';
part 'dialogs_state.dart';

class DialogsBloc extends Bloc<DialogsEvent, DialogsState> {
  DialogsBloc({required this.dialogsUseCase, required this.previewsUseCase})
      : super(const DialogsState()) {
    on<GetPreviews>(_getPreviews);
    on<ChoseDialog>(_choseDialog);
    on<CheckMessage>(_checkMessage);
    on<SendMessage>(_sendMessage);
  }

  final DialogsPreviewUseCase previewsUseCase;
  final DialogsUseCase dialogsUseCase;

  _getPreviews(GetPreviews event, Emitter<DialogsState> emit) async {
    final previews = await previewsUseCase.getAllDialogs();
    emit(state.copyWith(
        previews: () => previews,
        previewsStatus: DialogsPreviewStatus.downloaded));
  }

  _choseDialog(ChoseDialog event, Emitter<DialogsState> emit) async {
    if (event.dialogIndex == state.chosenDialogIndex) {
      return;
    }
    emit(state.copyWith(dataStatus: DialogsDataStatus.loading));
    final dialogData = await dialogsUseCase.getDialogData(event.dialogIndex);

    emit(state.copyWith(
        chosenDialogIndex: () => event.dialogIndex,
        dataStatus: DialogsDataStatus.downloaded,
        data: () => dialogData));
  }

  _checkMessage(CheckMessage event, Emitter<DialogsState> emit) async {
    if (state.chosenDialogIndex.isNull) {
      return;
    }
    final newMessage =
        await dialogsUseCase.checkNewMessage(state.chosenDialogIndex!);
    final updatedData = state.data!.pushMessage(newMessage);
    await dialogsUseCase.sendMessage(
        updatedData: updatedData, dialogIndex: state.chosenDialogIndex!);
    emit(state.copyWith(data: () => updatedData));
  }

  _sendMessage(SendMessage event, Emitter<DialogsState> emit) async {
    if (state.data.isNull) {
      return;
    }
    final message = Message(text: event.message, sendingDate: DateTime.now());
    final updatedData = state.data!.pushMessage(message);
    await dialogsUseCase.sendMessage(
        updatedData: updatedData, dialogIndex: state.chosenDialogIndex!);
    emit(state.copyWith(data: () => updatedData));
  }
}
