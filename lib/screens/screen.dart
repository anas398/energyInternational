import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/taskbloc.dart';
import '../bloc/taskevent.dart';
import '../bloc/taskstate.dart';
import '../model/taskdatas.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _employeeList = ['Employee1', 'Employee2', 'Employee3', 'Employee4','Employee5','Employee6']; // Option 2
   String? _selectedEmployee;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text('Task Manager')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    tileColor: Colors.grey.shade300,
                    title: Text(task.taskName),
                    subtitle: Text('${task.taskDescription} - ${task.employeeName}'),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No tasks found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _showAddTaskDialog(context, taskBloc),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskBloc taskBloc) {
    final nameController = TextEditingController();
    final descController = TextEditingController();


    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context,setState){
            return Form(
              key: _formKey,
              child: AlertDialog(
                title: const Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(controller: nameController, decoration: const InputDecoration(labelText: 'Task Name',),
            validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },),
                    TextFormField(controller: descController,
            validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },

                       decoration: const InputDecoration(labelText: 'Task Description',
                    )),
                    const SizedBox(height: 10,),
                    DropdownButton(
                      hint: _selectedEmployee == null
                          ? const Text('Select Employee')
                          : Text(
                        _selectedEmployee!,
                        style: const TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black),
                      items: _employeeList.map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            _selectedEmployee = val!;
                          },
                        );
                      },
                    ),

                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {

            if (_formKey.currentState!.validate()) {
              if(_selectedEmployee!.isEmpty){
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please choose a Employee'),
                  ),
                );

              }

              final task = Task(
                taskName: nameController.text,
                taskDescription: descController.text,
                employeeName: _selectedEmployee!,
              );
              taskBloc.add(AddTask(task));
              Navigator.pop(context);
            }





                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          },
        );

      },
    );
  }

}

