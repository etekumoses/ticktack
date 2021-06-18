import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticktack/provider/task_data.dart';
import 'package:ticktack/screens/addproject.dart';
import 'package:ticktack/screens/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //TaskData Provider
        ChangeNotifierProvider(
          create: (context) {
            var taskData = TaskData();
            taskData.fetchTasks();
            return taskData;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project',
        
        initialRoute: Homepage.id,
        routes: {
          Homepage.id: (context) => Homepage(),
          AddProjectView.id: (context) => AddProjectView(),
          },
      ),
    );
  }
}

