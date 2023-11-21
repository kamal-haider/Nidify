import 'dart:io';

import 'package:nidify/nidify.dart';
import 'package:test/test.dart';

void main() {
  group('Nidify', () {
    group('createDirectory', () {
      test('createDirectory success', () {
        var dirPath = 'test_directory';
        createDirectory(dirPath);
        expect(Directory(dirPath).existsSync(), isTrue);
      });

      test('createDirectory failure', () {
        var dirPath = ''; // Invalid directory path
        try {
          createDirectory(dirPath);
        } catch (e) {
          expect(e, isNotNull);
        }
      });

      tearDown(() {
        final directory = Directory('test_directory');
        if (directory.existsSync()) {
          directory.deleteSync(recursive: true);
        }
      });
    });

    group('createFile', () {
      test('createFile success', () {
        var filePath = 'test_directory/test_file.txt';
        createFile(filePath);
        expect(File(filePath).existsSync(), isTrue);
      });

      test('createFile failure', () {
        var filePath = ''; // Invalid file path
        try {
          createFile(filePath);
        } catch (e) {
          expect(e, isNotNull);
        }
      });

      tearDown(() {
        final directory = Directory('test_directory');
        if (directory.existsSync()) {
          directory.deleteSync(recursive: true);
        }
      });
    });

    group('createStructureFromJsonAndName', () {
      test('createStructureFromJsonAndName success', () {
        var featureName = 'test_feature';
        var jsonBlob =
            '{"\${feature}_directory_name": ["file_name.dart", "\${feature}_feature_name.dart"]}';
        createStructureFromJsonAndName(featureName, jsonBlob);
        expect(
            Directory('$featureName/${featureName}_directory_name')
                .existsSync(),
            isTrue);
        expect(
            File('$featureName/${featureName}_directory_name/file_name.dart')
                .existsSync(),
            isTrue);
        expect(
            File('$featureName/${featureName}_directory_name/${featureName}_feature_name.dart')
                .existsSync(),
            isTrue);
      });

      test('createStructureFromJsonAndName failure', () {
        var featureName = 'test_feature';
        var jsonBlob = 'invalid_json';
        try {
          createStructureFromJsonAndName(featureName, jsonBlob);
        } catch (e) {
          expect(e, isNotNull);
        }
      });

      tearDown(() {
        final directory = Directory('test_feature');
        if (directory.existsSync()) {
          directory.deleteSync(recursive: true);
        }
      });
    });

    group('processEntry', () {
      test('processEntry success with list', () {
        var featureName = 'test_feature';
        var entry = {
          "\${feature}_directory_name": [
            "file_name.dart",
            "\${feature}_feature_name.dart"
          ]
        };
        var currentPath = '.';
        processEntry(currentPath, entry, featureName);
        expect(Directory('${featureName}_directory_name').existsSync(), isTrue);
        expect(
            File('${featureName}_directory_name/file_name.dart').existsSync(),
            isTrue);
        expect(
            File('${featureName}_directory_name/${featureName}_feature_name.dart')
                .existsSync(),
            isTrue);
      });

      test('processEntry success with map', () {
        var featureName = 'test_feature';
        var entry = {
          "\${feature}_directory_name": {
            "sub_directory": ["file_name.dart", "\${feature}_feature_name.dart"]
          }
        };
        var currentPath = '.';
        processEntry(currentPath, entry, featureName);
        expect(
            Directory('${featureName}_directory_name/sub_directory')
                .existsSync(),
            isTrue);
        expect(
            File('${featureName}_directory_name/sub_directory/file_name.dart')
                .existsSync(),
            isTrue);
        expect(
            File('${featureName}_directory_name/sub_directory/${featureName}_feature_name.dart')
                .existsSync(),
            isTrue);
      });

      test('processEntry success with map as element', () {
        var featureName = 'test_feature';
        var entry = {
          "\${feature}_directory_name": {
            "sub_directory": [
              "file_name.dart",
              {
                "\${feature}_sub_directory": [
                  "file_name.dart",
                  "\${feature}_feature_name.dart"
                ]
              }
            ]
          }
        };
        var currentPath = '.';
        processEntry(currentPath, entry, featureName);
        expect(
            Directory('${featureName}_directory_name/sub_directory')
                .existsSync(),
            isTrue);
        expect(
            File('${featureName}_directory_name/sub_directory/file_name.dart')
                .existsSync(),
            isTrue);
        expect(
            Directory(
                    '${featureName}_directory_name/sub_directory/${featureName}_sub_directory')
                .existsSync(),
            isTrue);
        expect(
            File('${featureName}_directory_name/sub_directory/${featureName}_sub_directory/file_name.dart')
                .existsSync(),
            isTrue);
        expect(
            File('${featureName}_directory_name/sub_directory/${featureName}_sub_directory/${featureName}_feature_name.dart')
                .existsSync(),
            isTrue);
      });

      tearDown(() {
        final directory = Directory('test_feature_directory_name');
        if (directory.existsSync()) {
          directory.deleteSync(recursive: true);
        }
      });
    });
  });
}
