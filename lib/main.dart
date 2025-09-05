import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_checklist/bootstrap.dart';
import 'package:flutter_checklist/ui/core/app.dart';

Future<List<String>> getPhotos() async {
  // final response = await http.get(
  //   Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  //   headers: {'User-Agent': 'FlutterApp/1.0'},
  // );
  // final parsed = (jsonDecode(response.body) as List<Object?>)
  //     .cast<Map<String, Object?>>();
  // return Future.value(parsed.map((photo) => photo['thumbnailUrl'] as String).toList());
  return await Future.delayed(Duration(seconds: 10), () => ['teste', 'teste2']);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );

  final receivePort = ReceivePort();

  Isolate.spawn((SendPort sendPort) async {
    final listPhotos = await getPhotos();
    sendPort.send(listPhotos);
  }, receivePort.sendPort);

  receivePort.listen((photos) {
    (photos as List<String>).forEach(log);
    receivePort.close();
  });
  // final listPhotos = await getPhotos();

  final (objectBox, userRepository) = await bootstrap();

  PlatformDispatcher.instance.onError = (error, stack) {
    // Log de erro - enviar para o Crashlytics/Sentry
    return true; // Retorna true para evitar que o erro seja propagado
  };

  runZonedGuarded(
    () {
      FlutterError.onError = (details) {
        // Apresenta o erro no console
        FlutterError.presentError(details);

        // Trata o erro não capturado
        Zone.current.handleUncaughtError(details.exception, details.stack!);

        // Log de erro - enviar para o Crashlytics/Sentry
        if (kReleaseMode) exit(1); // Finaliza o app em modo release
      };

      runApp(
        App(objectBox: objectBox, userRepository: userRepository),
      );
    },
    (error, stack) {
      // Log de erro - async
      // Enviar para o Crashlytics/Sentry
      // reportError(error, stack);

      // Finaliza ou não o app
    },
  );
}
