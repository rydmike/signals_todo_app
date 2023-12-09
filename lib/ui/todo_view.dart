import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../core/models/app_info.dart';
import '../core/models/building.dart';
import '../core/todo_store.dart';
import 'add_todo_view.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Watch((context) {
          debugPrint('Building AppBar title');
          return Text(AppInfo.name.value);
        }),
      ),
      body: Column(
        children: [
          Watch((_) {
            debugPrint('Building Todo header');
            return Center(
              child: Text(todoStore.header.value),
            );
          }),
          Watch((_) {
            debugPrint('Building Volume');
            return Center(
              child: Text('Volume: ${building.value.volume}'),
            );
          }),
          const VentOnSwitch(),
          Watch(
            (_) {
              return ListView(
                shrinkWrap: true,
                children: [
                  for (final todo in todoStore.todos.value)
                    ListTile(
                      title: Text(
                        todo.title,
                        style: todo.completed
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : null,
                      ),
                      subtitle: Text(
                        todo.description,
                        style: todo.completed
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : null,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => todoStore.remove(todo),
                      ),
                      onTap: () => todoStore.markAsCompleted(todo),
                    ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => AppInfo.name.value = value,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddTodoView(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'home',
            onPressed: () {
              building.value =
                  building.value.copyWith(area: building.value.area + 10);
            },
            child: const Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}

class VentOnSwitch extends StatelessWidget {
  const VentOnSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    // final ventON = computed(() => building.value.ventOn);

    return Watch((_) {
      debugPrint('Building ListTile');
      return SwitchListTile(
        title: const Text('Air ventilation ON/OFF'),
        value: building.value.ventOn, // entON.value,
        onChanged: (bool value) {
          building.value = building.value.copyWith(ventOn: value);
        },
      );
    });
  }
}
