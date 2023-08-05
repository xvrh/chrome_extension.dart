import 'package:chrome_apis/system_memory.dart';
import 'package:chrome_apis/tabs.dart';
import 'package:flutter/material.dart' hide Tab;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Tab>> _tabs;

  @override
  void initState() {
    super.initState();

    _tabs = chrome.tabs.query(QueryInfo(currentWindow: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Slider(value: 1, onChanged: (v) {}, divisions: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  var info = await chrome.system.memory.getInfo();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Memory ${info.capacity} / ${info.availableCapacity}')));
                  }
                },
                child: Text('Get Memory'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tabs = chrome.tabs.query(QueryInfo(currentWindow: false));
                  });
                },
                child: Text('List all Here'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tabs = chrome.tabs.query(QueryInfo(currentWindow: true));
                  });
                },
                child: Text('Current window'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              var newTab =
                  await chrome.tabs.create(CreateProperties(active: false));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New tab ${newTab.id}')));
              }
            },
            child: Text('Create'),
          ),
          Text('${chrome.tabs.maxCaptureVisibleTabCallsPerSecond}'),
          Expanded(
            child: FutureBuilder<List<Tab>>(
              future: _tabs,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorWidget(snapshot.error!);
                } else if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                var data = snapshot.requireData;
                return ListView(
                  children: [
                    ListTile(
                      title: Text('${data.length}'),
                    ),
                    for (var tab in data)
                      ListTile(
                        leading: Text(tab.id.toString()),
                        title: Text(tab.title ?? '<not-available>'),
                        subtitle: Text(tab.status?.name ?? 'no-status'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await chrome.tabs.remove([tab.id!]);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Tab deleted')));
                            }
                            setState(() {
                              _tabs = chrome.tabs
                                  .query(QueryInfo(currentWindow: true));
                            });
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
