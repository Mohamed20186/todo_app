import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/services/utils.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseUtils {
  static CollectionReference<TaskModel> getCollectionRef(
      {required String collectionName}) {
    var db = FirebaseFirestore.instance;
    return db.collection(collectionName).withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFirestore(),
        );
  }

  Future<void> addTaskToFirestore(
      {required TaskModel taskModel, required String collectionName}) async {
    var collectionRef = getCollectionRef(collectionName: collectionName);
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getOnetimeReadFromFirestore(
      {required DateTime selectedDate, required String collectionName}) async {
    var collectionRef = getCollectionRef(collectionName: collectionName).where(
        "selectedDate",
        isEqualTo:
            extractDate(selectedDateTime: selectedDate).microsecondsSinceEpoch);
    var data = await collectionRef.get();
    var tasksList = data.docs.map((e) => e.data()).toList();
    return tasksList;
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFirestore(
      {required DateTime selectedDate, required String collectionName}) {
    var collectionRef = getCollectionRef(collectionName: collectionName).where(
        "selectedDate",
        isEqualTo:
            extractDate(selectedDateTime: selectedDate).microsecondsSinceEpoch);

    return collectionRef.snapshots();
  }

  static Future<void> deleteTask(
      {required String? id, required String collectionName}) async {
    var collectionRef = getCollectionRef(collectionName: collectionName);
    var doc = collectionRef.doc(id);
    doc.delete();
  }

  static Future<void> updateisDone(
      {required TaskModel taskModel, required String collectionName}) {
    var collectionRef = getCollectionRef(collectionName: collectionName);
    var doc = collectionRef.doc(taskModel.id);
    return doc.update({'isDone': true});
  }

  static Future<void> updateTaskData(
      {required TaskModel taskModel, required String collectionName}) {
    var collectionRef = getCollectionRef(collectionName: collectionName);
    var doc = collectionRef.doc(taskModel.id);
    return doc.update(taskModel.toFirestore());
  }
}
