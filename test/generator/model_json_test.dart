library model_json_test;

import 'dart:convert';
import 'dart:io';
import '../../tool/generator/json_model.dart' as json_model;
import 'package:test/test.dart';

void main() {
  group('json_model', () {
    // Define a test for each .json file in idl/
    // The unittest script likes to be run with the cwd set to the project root.
    var idlPath = 'idl';
    var jsonFiles = Directory(idlPath)
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'));

    for (var file in jsonFiles) {
      // skip _api_features.json, _manifest_features.json, _permission_features.json
      if (!file.path.contains('/_') &&
          !file.path.contains('test_presubmit') &&
          !file.path.endsWith('_private.json') &&
          !file.path.endsWith('_internal.json')) {
        test(file.path, () {
          var namespace =
              json_model.JsonNamespace.parse(file.readAsStringSync());
          expect(namespace.namespace, isNotNull);
        });
      }
    }
  });

  group("json model parameters", () {
    test("parse browser_action.json", () {
      var file = File('idl/chrome/browser_action.json');
      var namespace = json_model.JsonNamespace.parse(file.readAsStringSync());
      expect(namespace.namespace, isNotNull);
      expect(namespace.functions.any((e) => e.name == "setTitle"), isTrue);
      var function =
          namespace.functions.singleWhere((e) => e.name == "setTitle");
      expect(function.parameters.length, 1);
      var parameter = function.parameters[0];
      expect(parameter, isNotNull);
      expect(parameter.type, "object");
      expect(parameter.properties!.length, 2);
      var titleProperty = parameter.properties!['title']!;
      expect(titleProperty, isNotNull);
      expect(titleProperty.type, equals("string"));
      var tabIdProperty = parameter.properties!['tabId']!;
      expect(tabIdProperty, isNotNull);
      expect(tabIdProperty.type, equals("integer"));
      expect(tabIdProperty.optional, true);
    });
  });

  group('json enums', () {
    test('simple enum', () {
      var data = '''{
        "id": "simpleEnum",
        "type": "string",
        "description": "A simple enum with two values",
        "enum": ["firstVal", "secondVal"]
      }''';
      var jsonEnum = json_model.JsonDeclaredType.fromJson(
          json.decode(data) as Map<String, dynamic>);

      expect(jsonEnum.id, 'simpleEnum');
      expect(jsonEnum.enums!.length, 2);
      expect(jsonEnum.enums![0].name, contains('firstVal'));
      expect(jsonEnum.enums![1].name, contains('secondVal'));
    });

    test('enums with descriptions included', () {
      var data = '''{
        "id": "describedEnum",
        "type": "string",
        "description": "An enum with two values with descriptions",
        "enum": [
          {
            "name": "firstVal",
            "description": "The first value of the enum"
          },
          {
            "name": "secondVal",
            "description": "Some other bogus value"
          }
        ]
      }''';
      var jsonEnum = json_model.JsonDeclaredType.fromJson(
          json.decode(data) as Map<String, dynamic>);

      expect(jsonEnum.id, 'describedEnum');
      expect(jsonEnum.enums!.length, 2);
    });
  });

  group("individual parsing tests", () {
    test("parameters that have 'choices'", () {
      // TODO: move to file.
      var data = r"""[{
        "name": "setIcon",
        "type": "function",
        "description": "Sets the icon for the browser action. The icon can be specified either as the path to an image file or as the pixel data from a canvas element, or as dictionary of either one of those. Either the <b>path</b> or the <b>imageData</b> property must be specified.",
        "parameters": [
          {
            "name": "details",
            "type": "object",
            "properties": {
              "imageData": {
                "choices": [
                  { "$ref": "ImageDataType" },
                  {
                    "type": "object",
                    "properties": {
                      "19": {"$ref": "ImageDataType", "optional": true},
                      "38": {"$ref": "ImageDataType", "optional": true}
                     }
                  }
                ],
                "optional": true,
                "description": "Either an ImageData object or a dictionary {size -> ImageData} representing icon to be set. If the icon is specified as a dictionary, the actual image to be used is chosen depending on screen's pixel density. If the number of image pixels that fit into one screen space unit equals <code>scale</code>, then image with size <code>scale</code> * 19 will be selected. Initially only scales 1 and 2 will be supported. At least one image must be specified. Note that 'details.imageData = foo' is equivalent to 'details.imageData = {'19': foo}'"
              },
              "path": {
                "choices": [
                  { "type": "string" },
                  {
                    "type": "object",
                    "properties": {
                      "19": {"type": "string", "optional": true},
                      "38": {"type": "string", "optional": true}
                    }
                  }
                ],
                "optional": true,
                "description": "Either a relative image path or a dictionary {size -> relative image path} pointing to icon to be set. If the icon is specified as a dictionary, the actual image to be used is chosen depending on screen's pixel density. If the number of image pixels that fit into one screen space unit equals <code>scale</code>, then image with size <code>scale</code> * 19 will be selected. Initially only scales 1 and 2 will be supported. At least one image must be specified. Note that 'details.path = foo' is equivalent to 'details.imageData = {'19': foo}'"
              },
              "tabId": {
                "type": "integer",
                "optional": true,
                "description": "Limits the change to when a particular tab is selected. Automatically resets when the tab is closed."
              }
            }
          },
          {
            "type": "function",
            "name": "callback",
            "optional": true,
            "parameters": []
          }
        ]
      }]""";

      var functions = (json.decode(data) as List)
          .cast<Map<String, dynamic>>()
          .map(json_model.JsonFunction.fromJson)
          .toList();
      expect(functions, isNotNull);
      expect(functions, hasLength(1));
      var function = functions[0];
      expect(function, isNotNull);
      expect(function.name, equals("setIcon"));
      expect(function.parameters, hasLength(2));
      //json_model.JsonParamType objectType =
      //    function.parameters[0] as json_model.JsonParamType;
      //expect(objectType, isNotNull);
      //List<json_model.JsonProperty> properties = objectType.properties;
      //expect(properties, isNotNull);
      //expect(properties, hasLength(3));
      //json_model.JsonProperty imageDataProperty = properties[0];
      //expect(imageDataProperty.name, equals("imageData"));
      //expect(imageDataProperty.isComplexProperty, isFalse);
      // TODO: unit test the choices once implemented
    });
  });
}
