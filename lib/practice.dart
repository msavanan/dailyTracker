import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

void createExcelFile() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await rootBundle.load("assets/form.xlsx");
// This would be your equivalent bytes variable
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// You can also copy it to the device when the app starts
  final directory =
      await getExternalStorageDirectory(); //getApplicationDocumentsDirectory();
  String filePath = join(directory.path, "form.xlsx");
  print(filePath);
  await File(filePath).writeAsBytes(bytes);
//  saveFile();
//  readFile();
}

Future<String> getFilePath() async {
  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory.path; // 2
  String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3
  print(filePath);
  return filePath;
}

void saveFile() async {
  File file = File(await getFilePath()); // 1
  file.writeAsString(
      "This is my demo text that will be saved to : demoTextFile.txt"); // 2
}

void readFile() async {
  File file = File(await getFilePath()); // 1
  String fileContent = await file.readAsString(); // 2

  print('File Content: $fileContent');
}
