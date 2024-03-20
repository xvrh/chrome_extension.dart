import 'package:chrome_extension/tabs.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:web/web.dart' as web;

import 'qr_view.dart';

void main() => runApp(const MyApp());

Future<Tab> getActiveTab() async {
  List<Tab> tabs =
      await chrome.tabs.query(QueryInfo(active: true, currentWindow: true));
  return tabs.first;
}

void sizePopUp({int? heightPx, int? widthPx}) {
  String size = '';
  if (heightPx case int height) size += 'height: ${height}px;';
  if (widthPx case int width) size += 'width: ${width}px;';
  if (size.isEmpty) return;
  final styleTag = web.document.createElement('style');
  styleTag.textContent = 'html { $size }';
  web.document.head?.append(styleTag);
}

final Map<String, Widget Function(BuildContext)> routes = {
  'options': (_) {
    sizePopUp(heightPx: 400, widthPx: 400);
    return buildOptionsPage(_);
  },
  'popup': (_) {
    sizePopUp(heightPx: 350, widthPx: 650);
    return FutureBuilder<Tab>(
      future: getActiveTab(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return QRView(qrText: snapshot.data!.url!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
};

Widget buildOptionsPage(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.red,
    appBar: AppBar(
      title: const Text('Options'),
    ),
    body: const Center(
      child: Text('Options page'),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      title: 'Flutter Chrome Extension',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<String?>(
        future: getActiveTab().then((tab) => tab.url),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data case String url) {
                return QRView(qrText: url);
              }
              throw Exception('Error: Could not obtain url. ${snapshot.error}');
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
