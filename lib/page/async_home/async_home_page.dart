import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'async_home_page.g.dart';
part 'async_home_page.freezed.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String description,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);
}

final dio = Dio();

@riverpod
class AsyncTodos extends _$AsyncTodos {
  Future<List<Todo>> _fetchTodo() async {
    final json = await dio.get('api/todos');
    final todos =
        jsonDecode(json.data.toString()) as List<Map<String, dynamic>>;
    return todos.map(Todo.fromJson).toList();
  }

  @override
  FutureOr<List<Todo>> build() async {
    // 从远程仓库获取初始的待办清单
    return _fetchTodo();
  }

  Future<void> addTodo(Todo todo) async {
    // 将当前状态设置为加载中
    state = const AsyncValue.loading();
    //  将新的待办清单添加到远程仓库
    state = await AsyncValue.guard(() async {
      await dio.post('api/todos');
      return _fetchTodo();
    });
  }

  // 让我们允许删除待办清单
  Future<void> removeTodo(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await dio.delete('api/todos/$todoId');
      return _fetchTodo();
    });
  }

  // 让我们把待办清单标记为已完成
  Future<void> toggle(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await dio.patch(
        'api/todos/$todoId',
      );
      return _fetchTodo();
    });
  }
}

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // rebuild the widget when the todo list changes
    final asyncTodos = ref.watch(asyncTodosProvider);

    // Let's render the todos in a scrollable list view
    return asyncTodos.when(
      data: (todos) => ListView(
        children: [
          for (final todo in todos)
            CheckboxListTile(
              value: todo.completed,
              // When tapping on the todo, change its completed status
              onChanged: (value) =>
                  ref.read(asyncTodosProvider.notifier).toggle(todo.id),
              title: Text(todo.description),
            ),
        ],
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
