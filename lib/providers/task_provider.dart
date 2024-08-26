import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../helpers/firestore_helper.dart';



class TaskProvider with ChangeNotifier {
  final FirestoreHelper _firestoreHelper = FirestoreHelper();
  List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _firestoreHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Map<String, dynamic> task) async {
    await _firestoreHelper.insertTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(String id, Map<String, dynamic> task) async {
    await _firestoreHelper.updateTask(id, task);
    await fetchTasks();
  }

  Future<void> deleteTask(String id) async {
    await _firestoreHelper.deleteTask(id);
    await fetchTasks();
  }

  Stream<QuerySnapshot> tasksStream() {
    return _firestoreHelper.tasksStream();
  }
}