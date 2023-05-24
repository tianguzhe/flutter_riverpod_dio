import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nanoid/non_secure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page.g.dart';

part 'home_page.freezed.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String description,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);
}

@riverpod
class Todos extends _$Todos {
  @override
  List<Todo> build() {
    return [
      const Todo(id: "id001", description: "001", completed: false),
      const Todo(id: "id002", description: "002", completed: false),
      const Todo(id: "id003", description: "003", completed: true),
      const Todo(id: "id004", description: "004", completed: false),
    ];
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    // 同样我们的状态是不可变的。
    // 所以我们创建了一个新的列表，而不是改变现存的列表。
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo
    ];
  }
}

@riverpod
int listSize(ListSizeRef ref) {
  return ref.watch(todosProvider).length;
}

@riverpod
Todo todo(TodoRef ref, {required int index}) {
  final todos = ref.watch(todosProvider);
  return todos[index];
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("重新绘制");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return const ListWrapper();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(todosProvider.notifier).addTodo(
              Todo(
                id: nanoid(),
                description: nanoid(10),
                completed: false,
              ),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListWrapper extends ConsumerWidget {
  const ListWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("ListView 重新绘制");
    final listSize = ref.watch(listSizeProvider);

    return ListView.builder(
      itemCount: listSize,
      itemBuilder: (context, index) {
        return ListItem(index: index);
      },
    );
  }
}

class ListItem extends ConsumerWidget {
  final int index;

  const ListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("CheckboxListTile 重新绘制");
    final todo = ref.watch(todoProvider(index: index));

    return CheckboxListTile(
      value: todo.completed,
      // When tapping on the todo, change its completed status
      onChanged: (value) => ref.read(todosProvider.notifier).toggle(todo.id),
      title: Text(todo.description),
    );
  }
}
