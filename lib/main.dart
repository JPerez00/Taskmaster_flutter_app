import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskMaster',
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _tasks = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'TaskMaster 🔖',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        titleSpacing: 24,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Add Tasks To The list'),
            ),
            Divider(indent: 16),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 3, left: 5),
              child: Form(
                key: _formKey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: taskController,
                        decoration: InputDecoration(
                            hintText: 'New Task Here...',
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            )),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Task field required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 5),
                      child: RaisedButton(
                        child: Text('Add'),
                        onPressed: () {
                          debugPrint('Add button has been clicked');
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _tasks.add(taskController.text);
                            });
                            taskController.clear();
                          }
                        },
                        color: Colors.green,
                        textColor: Colors.white70,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_tasks[index]),
                      trailing:
                          Icon(Icons.delete_rounded, color: Colors.red[200]),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
