import 'dart:io';
import 'dart:convert';

void createDirectory(String dirPath) {
  try {
    Directory(dirPath).createSync(recursive: true);
    print("Directory '$dirPath' created successfully.");
  } catch (e) {
    print("Error creating directory: $e");
  }
}

void createFile(String filePath) {
  try {
    File(filePath).createSync(recursive: true);
    print("File '$filePath' created successfully.");
  } catch (e) {
    print("Error creating file: $e");
  }
}

void processEntry(
    String currentPath, Map<String, dynamic> entry, String featureName) {
  entry.forEach((key, value) {
    var targetPath = '$currentPath/$key'.replaceAll("\${feature}", featureName);
    createDirectory(targetPath);

    if (value is List) {
      value.forEach((element) {
        if (element is String) {
          var filePath =
              '$targetPath/${element.replaceAll("\${feature}", featureName)}';
          createFile(filePath);
        } else if (element is Map<String, dynamic>) {
          createDirectory(targetPath);
          processEntry(targetPath, element, featureName);
        }
      });
    } else if (value is Map<String, dynamic>) {
      processEntry(targetPath, value, featureName);
    }
  });
}

void createStructureFromJsonAndName(String featureName, String jsonBlob) {
  try {
    var jsonData = json.decode(jsonBlob);
    createDirectory(featureName);
    processEntry(featureName, jsonData, featureName);
    print("Structure in '$featureName' created successfully.");
  } catch (e) {
    print("Error parsing JSON: $e");
  }
}
