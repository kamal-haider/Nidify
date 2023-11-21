import 'dart:io';

import 'package:nidify/nidify.dart' as nidify;

void main(List<String> arguments) {
  if (arguments.length < 2) {
    print(
        "Please provide the feature name and template file location as command-line arguments.");
    return;
  }

  var featureName = arguments[0];
  var templateFilePath = arguments[1];
  var rootDirectory = arguments.length > 2 ? arguments[2] : null;

  try {
    var jsonBlob = File(templateFilePath).readAsStringSync();
    nidify.createStructureFromJsonAndName(featureName, jsonBlob, rootDirectory);
  } catch (e) {
    print("Error reading file: $e");
  }
}
