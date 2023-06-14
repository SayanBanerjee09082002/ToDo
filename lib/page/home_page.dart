import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/api/firebase_api.dart';
import '/model/todo.dart';
import '/provider/todos.dart';
import '/widget/add_todo_dialog_widget.dart';
import '/widget/completed_list_widget.dart';
import '/widget/todo_list_widget.dart';
import '/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '/widget/calender_widgete.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
      CalenderWidget(title: '',),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do's",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.amber,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 28),
            label: 'Calender',
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text('Opps Something not right!');
              } else {
                final todos = snapshot.data;
                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos!);
                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
