part of 'dialogs_bloc.dart';

enum DialogsPreviewStatus { initial, loading, downloaded }

enum DialogsDataStatus { initial, loading, downloaded }

class DialogsState extends Equatable {
  const DialogsState(
      {this.previewsStatus = DialogsPreviewStatus.initial,
      this.dataStatus = DialogsDataStatus.initial,
      this.previews,
      this.data,
      this.chosenDialogIndex});

  final DialogsPreviewStatus previewsStatus;
  final DialogsDataStatus dataStatus;
  final List<DialogPreview>? previews;
  final DialogData? data;
  final int? chosenDialogIndex;

  DialogsState copyWith(
          {DialogsPreviewStatus? previewsStatus,
          DialogsDataStatus? dataStatus,
          List<DialogPreview>? Function()? previews,
          DialogData? Function()? data,
          int? Function()? chosenDialogIndex}) =>
      DialogsState(
        previewsStatus: previewsStatus ?? this.previewsStatus,
        dataStatus: dataStatus ?? this.dataStatus,
        previews: previews == null ? this.previews : previews(),
        data: data == null ? this.data : data(),
        chosenDialogIndex: chosenDialogIndex == null
            ? this.chosenDialogIndex
            : chosenDialogIndex(),
      );

  @override
  List<Object?> get props =>
      [previewsStatus, dataStatus, previews, data, chosenDialogIndex];
}
