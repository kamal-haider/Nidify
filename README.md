# Nidify

## Installation

To install this application, you need to have Dart installed on your machine. If you don't have it installed, you can download it from [here](https://dart.dev/get-dart). After installing Dart, clone this repository to your local machine.

Once you have cloned the repository, navigate to the project directory. There you will find a Dart file named `nidify.dart`. This script is used to build the Dart application. Run this script by navigating into the nidify directory and typing the following command in your terminal:
```bash
dart run nidify.dart
```

## Running the Application

To run the application, ensure that the `nidify.dart` file is in your project's directory. Then, in your terminal, run the following command: 
```bash
dart run nidify.dart test template.json
```

## Configure the template

The JSON template should be structured as a nested object where each key represents a directory and each value can either be an array of filenames or another nested object. Filenames and directories can include a `${feature}` tag that will be replaced with the feature name provided when running the application. Here is an example of a template:
```json
{
    "directory_name": [
        "file_name.dart",
        "${feature}_feature_name.dart"
    ]
}
```

