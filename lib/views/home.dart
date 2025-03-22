import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/database.dart';
import 'package:firstapp/views/create_quiz.dart';
import 'package:firstapp/views/play_quiz.dart';
import 'package:firstapp/widget/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseService databaseService = DatabaseService();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: databaseService.getQuizezData(),
        builder: (context, snapshot){
          return snapshot.data == null ? Container() : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return QuizTile(
                imgUrl: snapshot.data!.docs[index].data()["quizImgURL"],
                desc: snapshot.data!.docs[index].data()["quizDescription"], 
                title: snapshot.data!.docs[index].data()["quizTitle"], 
                quizId: snapshot.data!.docs[index].data()["quizId"], 
                );
            },
          );
        },
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CreateQuiz()));
              },
              ),
    );
  }
}

class QuizTile extends StatelessWidget{
final String imgUrl;
final String title;
final String desc;
final String quizId;
QuizTile({
  required this.imgUrl, 
  required this.title, 
  required this.desc, 
  required this.quizId, super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imgUrl, height: 240,width: MediaQuery.of(context).size.width-48,fit: BoxFit.cover,)),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute
              (builder: (context) => PlayQuiz(
                quizId
              )
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title, 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),),
                    SizedBox(height: 6,),
                  Text(desc,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),),
                ],
              ),
            ),
          )
        ]
        ),
    );
  }
}