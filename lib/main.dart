import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Task {
  String title;
  bool isDone;
  Task({required this.title, this.isDone = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabToDoList(),
    );
  }
}

class TabToDoList extends StatefulWidget {
  const TabToDoList({super.key});

  @override
  State<TabToDoList> createState() => _TabToDoListState();
}

class _TabToDoListState extends State<TabToDoList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

// Elenco attività (il nostro database in memoria)
  final List<Task> _tasks = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textFieldController.dispose();
    super.dispose();
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  int doneTask = 0;
  int todoTask = 0;
  void taskToDo() {
    doneTask = 0;
    todoTask = 0;
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].isDone) {
        doneTask++;
      } else {
        todoTask++;
      }
    }
  }

  double get efficiency {
    if (_tasks.isEmpty) return 0.0; 
    int doneCount = _tasks.where((t) => t.isDone).length;
    return (doneCount / _tasks.length) * 100;
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete task?"),
          content: Text(
            'Are you sure you want to delete${_tasks[index].title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the window
              child: const Text('Abolition'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                _deleteTask(index);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Видалити',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String get efficiencyImage {
    if (efficiency < 25) {
      return 'assets/efficiency0.jpg';
    } else if (efficiency < 75) {
      return 'assets/efficiency25.jpg';
    } else if (efficiency < 90) {
      return 'assets/efficiency75.jpg';
    } else {
      return 'assets/efficiency100.jpg';
    }
  }

// Funzione per visualizzare la finestra di dialogo
  void _displayDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new task'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Enter a title..."),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Abolition'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  setState(() {
                    _tasks.add(Task(title: _textFieldController.text));
                  });
                  _textFieldController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: "Lista"),
            Tab(icon: Icon(Icons.settings), text: "Stats"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
      // PRIMA SCHEDA
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("My tasks", style: TextStyle(fontSize: 20)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: _tasks.length,
            
                    itemBuilder: (context, index) {
                      return InkWell(
                      
                        onTap: () => _showDeleteDialog(
                          index,
                        ), 
                        borderRadius: BorderRadius.circular(12),
                        child: TodoItem(
                          task: _tasks[index],
                          onChanged: () {
                            setState(() {
                              _tasks[index].isDone = !_tasks[index].isDone;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),


         // SECONDA SCHEDA
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
                Column(
                  children: [
                    Text(
                      "Total tasks: ${_tasks.length}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Done: ${_tasks.where((t) => t.isDone).length}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Remaining: ${_tasks.where((t) => !t.isDone).length}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Efficiency: ${efficiency.toStringAsFixed(1)}%",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30), 
       
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), 
                      child: Image.asset(
                        efficiencyImage,
                        height: 200, 
                        width: 400,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 100,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: _displayDialog,
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// COSTRUTTORE DI WIDGET SEPARATO PER L'ATTIVITÀ
class TodoItem extends StatelessWidget {
  final Task task;
  final VoidCallback onChanged;

  const TodoItem({super.key, required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8), 
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              color: task.isDone ? Colors.grey : Colors.black,
            ),
          ),
          IconButton(
            onPressed: onChanged,
            icon: Icon(
              task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: task.isDone ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
