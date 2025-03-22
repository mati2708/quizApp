import 'package:firstapp/services/database.dart';
import 'package:firstapp/views/addquestion.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../widget/widgets.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _formKey = GlobalKey<FormState>();
  late String quizImageURL, quizTitle, quizDestription, quizId;
  DatabaseService databaseService = DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async{

    setState(() {
      _isLoading = true;
    });

    if(_formKey.currentState!.validate()){

      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgURL" : quizImageURL,
        "quizTitle" : quizTitle,
        "quizDescription" : quizDestription,
      };

      await databaseService.addQuizData(quizMap, quizId).then((value){
        setState(() {
      _isLoading = false;
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => AddQuestion(quizId)
        ));
        });
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val==null ? "Enter Image URL" : null,
                decoration: InputDecoration(
                  hintText: "Quiz Image URL",
                ),
                onChanged: (val){
                  quizImageURL = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val==null ? "Enter Quiz Title" : null,
                decoration: InputDecoration(
                  hintText: "Quiz Title",
                ),
                onChanged: (val){
                  quizTitle = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val==null ? "Enter Quiz Description" : null,
                decoration: InputDecoration(
                  hintText: "Quiz Description",
                ),
                onChanged: (val){
                  quizDestription = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuizOnline();
                },
                child: blueButton(
                  context: context, 
                  label: "Create Quizz",
                  )),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }
}