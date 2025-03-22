import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseService{

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async{
    await FirebaseFirestore.instance.collection("Quiz")
    .doc(quizId)
    .set(quizData)
    .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map<String, dynamic> questionData, String quizId) async{
    await FirebaseFirestore.instance.collection("Quiz")
    .doc(quizId)
    .collection("QNA")
    .add(questionData)
    .catchError((e){
      print(e.toString());
    });
  }

  getQuizezData(){
    return FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuizData(String quizId){
    return FirebaseFirestore.instance
    .collection("Quiz")
    .doc(quizId)
    .collection("QNA")
    .get();
  }
}