import 'package:signals/signals_flutter.dart';
import 'package:signals_todo_app/core/models/todo.dart';

import 'models/app_info.dart';

final TodoStore todoStore = TodoStore();

class TodoStore {
  final ListSignal<Todo> todos = <Todo>[].toSignal();

  final Computed<String> header = computed(
      () => '${AppInfo.name.value} has ${todoStore.todos.value.length} todos');

  void add(Todo todo) {
    todos.value = [...todos.value, todo];
  }

  void remove(Todo todo) {
    todos.value = todos.value.where((Todo t) => t != todo).toList();
  }

  void markAsCompleted(Todo todo) {
    todos.value = todos.value.map((Todo t) {
      if (t == todo) {
        return t.copyWith(completed: true);
      }
      return t;
    }).toList();
  }
}
