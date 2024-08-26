import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final FirestoreHelper _instance = FirestoreHelper._internal();
  factory FirestoreHelper() => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreHelper._internal();

  Future<void> insertTask(Map<String, dynamic> task) async {
    await _firestore.collection('tasks').add(task);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    QuerySnapshot querySnapshot = await _firestore.collection('tasks').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<void> updateTask(String id, Map<String, dynamic> task) async {
    await _firestore.collection('tasks').doc(id).update(task);
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }

  Stream<QuerySnapshot> tasksStream() {
    return _firestore.collection('tasks').snapshots();
  }

  // Método adicional para obtener una tarea específica
  Future<Map<String, dynamic>?> getTask(String id) async {
    DocumentSnapshot doc = await _firestore.collection('tasks').doc(id).get();
    return doc.data() as Map<String, dynamic>?;
  }
}