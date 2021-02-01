import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrint(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

PrettyPrint(
    {int methodCount,
    int errorMethodCount,
    int lineLength,
    bool colors,
    bool printEmojis,
    bool printTime}) {}
