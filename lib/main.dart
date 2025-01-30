import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sound_swap/sound_swap_app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

void main() async {
  _initializeFlutterBindings();
  _initializeDependencies();
  await _initializeVkIdLogs();
  runApp(const SoundSwapApp());
}

Future<void> _initializeVkIdLogs() async {
  await VKID.getInstance().then((vkId) => vkId.setLogsEnabled(true));
}

void _initializeFlutterBindings() {
  WidgetsFlutterBinding.ensureInitialized();
}

void _initializeDependencies() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
}

