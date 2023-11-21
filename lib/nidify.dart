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

void processEntry(String currentPath, dynamic entry, String featureName) {
  if (entry is Map<String, dynamic>) {
    entry.forEach((key, value) {
      var targetPath =
          '$currentPath/$key'.replaceAll("\${feature}", featureName);
      createDirectory(targetPath);
      processNestedEntry(targetPath, value, featureName);
    });
  } else if (entry is List) {
    processNestedEntry(currentPath, entry, featureName);
  }
}

void processNestedEntry(String currentPath, dynamic entry, String featureName) {
  if (entry is List) {
    for (var element in entry) {
      if (element is String) {
        var filePath =
            '$currentPath/${element.replaceAll("\${feature}", featureName)}';
        createFile(filePath);
      } else if (element is Map<String, dynamic>) {
        processEntry(currentPath, element, featureName);
      }
    }
  } else if (entry is Map<String, dynamic>) {
    processEntry(currentPath, entry, featureName);
  }
}

void createStructureFromJsonAndName(String featureName, String jsonBlob,
    [String? rootDirectory]) {
  try {
    var jsonData = json.decode(jsonBlob);
    var currentPath = rootDirectory ?? featureName;
    createDirectory(currentPath);
    processEntry(currentPath, jsonData, featureName);
    print("Structure in '$featureName' created successfully.");
  } catch (e) {
    print("Error parsing JSON: $e");
  }
}
