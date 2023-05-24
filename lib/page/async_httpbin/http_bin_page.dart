import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'http_bin_view_model.dart';

class DioPage extends ConsumerWidget {
  const DioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(asyncHttpBinProvider);

    return Scaffold(
      body: Center(
        child: asyncTodos.when(
          data: (httpbin) => Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(httpbin.url),
                  Text(httpbin.headers.userAgent),
                ],
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => Text('Error: $err'),
        ),
      ),
    );
  }
}
