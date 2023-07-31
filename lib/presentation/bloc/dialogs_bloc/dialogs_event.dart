part of 'dialogs_bloc.dart';

abstract class DialogsEvent extends Equatable {
  const DialogsEvent();
  @override
  List<Object?> get props => [];
}

class GetPreviews extends DialogsEvent {
  const GetPreviews();
}

class ChoseDialog extends DialogsEvent {
  const ChoseDialog(this.dialogIndex);

  final int dialogIndex;

  @override
  List<Object?> get props => [dialogIndex];
}

class CheckMessage extends DialogsEvent {
  const CheckMessage();
}

class SendMessage extends DialogsEvent {
  const SendMessage(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
