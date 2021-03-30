import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

var bytes;
String assetsPath = "assets/form.xlsx";
Directory dir;

Future loadAsset() async {
  var status = await Permission.storage.status;
  if (status.isDenied || status.isPermanentlyDenied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[
        Permission.storage]); // it should print PermissionStatus.granted
  }
  dir = await getExternalStorageDirectory();
  ByteData data = await rootBundle.load(assetsPath);
// This would be your equivalent bytes variable
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  return bytes;
}

/*class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}*/

void createExcelFile() async {
  ByteData data = await rootBundle.load("assets/form.xlsx");
// This would be your equivalent bytes variable
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// You can also copy it to the device when the app starts
  final directory = await getApplicationDocumentsDirectory();
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

void createXL() {
  //var file = "assets/form.xlsx";
  var bytes;

  //(await getApplicationDocumentsDirectory()).path;
  //var bytes = File(file).readAsBytesSync();
  //loadAsset().then((value) => bytes = value);
  //var excel = Excel.createExcel();
  // or
  loadAsset().then((value) {
    print('${dir.path}');

    var file = "${dir.path}/form.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.createExcel();

    //bytes = value;

    //var excel = Excel.decodeBytes(bytes);
    //print(bytes);
    // print('-------------bytes----------');
    for (var table in excel.tables.keys) {
      print(table);
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);
      for (var row in excel.tables[table].rows) {
        print("$row");
      }
    }
    print(dir);

    CellStyle cellStyle = CellStyle(
      bold: true,
      italic: true,
      fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
    );

    var sheet = excel['Sheet1'];

    var cell = sheet.cell(CellIndex.indexByString("A1"));
    cell.value = "Heya How are you I am fine ok goood night";
    cell.cellStyle = cellStyle;

    var cell2 = sheet.cell(CellIndex.indexByString("E5"));
    cell2.value = "Heya How night";
    cell2.cellStyle = cellStyle;

    /// printing cell-type
    print("CellType: " + cell.cellType.toString());

    /// Iterating and changing values to desired type
    /*for (int row = 0; row < sheet.maxRows; row++) {
    sheet.row(row).forEach((cell) {
      var val = cell.value; //  Value stored in the particular cell

      cell.value = ' My custom Value ';
    });
  }*/

    /*excel.rename("mySheet", "myRenamedNewSheet");

    // fromSheet should exist in order to sucessfully copy the contents
    excel.copy('myRenamedNewSheet', 'toSheet');

    excel.rename('oldSheetName', 'newSheetName');

    excel.delete('Sheet1');

    excel.unLink('sheet1');

    sheet = excel['sheet'];

     */

    /// appending rows
    /*
  List<List<String>> list = List.generate(
      6000, (index) => List.generate(20, (index1) => '$index $index1'));

  Stopwatch stopwatch = new Stopwatch()..start();
  list.forEach((row) {
    sheet.appendRow(row);
  });

  print('doSomething() executed in ${stopwatch.elapsed}');

  sheet.appendRow([8]);
  excel.setDefaultSheet(sheet.sheetName).then((isSet) {
    // isSet is bool which tells that whether the setting of default sheet is successful or not.
    if (isSet) {
      print("${sheet.sheetName} is set to default sheet.");
    } else {
      print("Unable to set ${sheet.sheetName} to default sheet.");
    }
  });


   */

    // Saving the file

    //String outputFile = "assets/form.xlsx";
    excel.encode().then((onValue) {
      File(join('${dir.path}/form.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
    print('${dir.path}');
    print('Complete');
  });
}
