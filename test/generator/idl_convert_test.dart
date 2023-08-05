library chrome_idl_convert_test;

import '../../tool/generator/chrome_type.dart' show Context;
import '../../tool/generator/idl_convert.dart';
import '../../tool/generator/idl_parser.dart';
import 'package:test/test.dart';

late ChromeIDLParser chromeIDLParser;

void main() {
  setUp(() {
    chromeIDLParser = ChromeIDLParser();
  });
  group('ChromeIDLParser convert', chromeIDLConvertTests);
}

void chromeIDLConvertTests() {
  test('Convert Test', () {
    var testData =
        """// Copyright (c) 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Use the <code>chrome.power</code> API to override the system's power
// management features.
namespace power {
  [noinline_doc] enum Level {
    // Prevent the system from sleeping in response to user inactivity.
    system,

    // Prevent the display from being turned off or dimmed or the system
    // from sleeping in response to user inactivity.
    display
  };

  interface Functions {
    // Requests that power management be temporarily disabled. |level|
    // describes the degree to which power management should be disabled.
    // If a request previously made by the same app is still active, it
    // will be replaced by the new request.
    static void requestKeepAwake(Level level);

    // Releases a request previously made via requestKeepAwake().
    static void releaseKeepAwake();
  };
};""";

    var namespace = chromeIDLParser.namespaceDeclaration.parse(testData).value;

    var context = Context();
    var chromeLibrary = IdlModelConverter(context, namespace).convert();
    expect(chromeLibrary, isNotNull);
    // TODO: finish testing this object.
  });
}
