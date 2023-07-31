import 'package:chat_app/data/hive_boxes.dart';
import 'package:chat_app/data/repository/dialogs_data_repository_impl.dart';
import 'package:chat_app/data/repository/dialogs_preview_repository_impl.dart';
import 'package:chat_app/data/sources/dialogs_data_source_mock.dart';
import 'package:chat_app/data/sources/dialogs_data_storage.dart';
import 'package:chat_app/data/sources/dialogs_preview_source_mock.dart';
import 'package:chat_app/domain/models/day_dialog_history.dart';
import 'package:chat_app/domain/models/dialog_data.dart';
import 'package:chat_app/domain/models/message.dart';
import 'package:chat_app/domain/use_case/dialogs_preview_use_case.dart';
import 'package:chat_app/domain/use_case/dialogs_use_case.dart';
import 'package:chat_app/presentation/bloc/dialogs_bloc/dialogs_bloc.dart';
import 'package:chat_app/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(DayDialogHistoryAdapter());
  Hive.registerAdapter(DialogDataAdapter());

  final dialogsBox = await Hive.openBox(HiveBoxes.dialogDataList.name);
  await Hive.openBox(HiveBoxes.previewMessages.name);
  initializeDateFormatting('ru');
  const dialogsPreviewSource = DialogsPreviewSourceMock();
  const dialogsPreviewRepository =
      DialogsPreviewRepositoryImpl(source: dialogsPreviewSource);
  const dialogsPreviewUseCase =
      DialogsPreviewUseCase(dialogsPreviewRepository: dialogsPreviewRepository);

  final dialogsDataStorage = DialogsDataStorage(dialogsBox: dialogsBox);
  const dialogsDataSourceMock = DialogsDataSourceMock();
  final dialogsDataRepository = DialogsDataRepositoryImpl(
      remoteSource: dialogsDataSourceMock, storage: dialogsDataStorage);
  final dialogsUseCase =
      DialogsUseCase(dialogsDataRepository: dialogsDataRepository);

  runApp(MyApp(
    dialogsPreviewUseCase: dialogsPreviewUseCase,
    dialogsUseCase: dialogsUseCase,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.dialogsPreviewUseCase,
      required this.dialogsUseCase});

  final DialogsPreviewUseCase dialogsPreviewUseCase;
  final DialogsUseCase dialogsUseCase;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => DialogsBloc(
            dialogsUseCase: dialogsUseCase,
            previewsUseCase: dialogsPreviewUseCase),
        child: ChatPage(
          previewsUseCase: dialogsPreviewUseCase,
          dialogsUseCase: dialogsUseCase,
        ),
      ),
    );
  }
}
