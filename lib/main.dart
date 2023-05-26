import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'global.dart';
import 'page/async_httpbin/http_bin_page.dart';
import 'page/dio_test/dio_test.dart';
import 'page/home/home_page.dart';

void main() => Global.init().then(
      (value) => runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TestDio(),
    );
  }
}
