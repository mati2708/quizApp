import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/views/result.dart';
import 'package:firstapp/widget/quiz_play_widgets.dart';
import 'package:flutter/material.dart';

import '../models/quastion_model.dart';
import '../services/database.dart';
import '../widget/widgets.dart';

class PlayQuiz extends StatefulWidget {
   final String quizId;
  PlayQuiz(this.quizId, {super.key});


  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int correct = 0;
int incorrect = 0;
int notAttemped = 0;


class _PlayQuizState extends State<PlayQuiz> {

late DatabaseService databaseService = DatabaseService();
QuerySnapshot<Map<String, dynamic>>? questionsSnapshot;

QuestionModel getQuestionModelFromDatasnaphot(DocumentSnapshot<Map<String, dynamic>> questionSnapshot){

  QuestionModel questionModel = QuestionModel();
  questionModel.question = questionSnapshot.data()?["question"];

  List<String> options = 
    [
      questionSnapshot.data()?["option1"],
      questionSnapshot.data()?["option2"],
      questionSnapshot.data()?["option3"],
      questionSnapshot.data()?["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.corectOption = questionSnapshot.data()?["option1"];
    questionModel.answered = false;

    return questionModel;

}

@override
  void initState() {
      print("${widget.quizId}");
      databaseService!.getQuizData(widget.quizId).then((value){
        setState(() {
          questionsSnapshot = value;
          notAttemped = 0;
          correct = 0;
          incorrect = 0;
          total = questionsSnapshot!.docs.length;
        });

        print("$total this is total");
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color:Colors.black54),
      ),
      body: questionsSnapshot == null ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: questionsSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return QuizPlayTile(
                questionModel: getQuestionModelFromDatasnaphot(questionsSnapshot!.docs[index]),
                index: index,
                );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Result(correct, incorrect, total))
              );
          },),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  
  QuizPlayTile({required this.questionModel, required this.index, super.key});


  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

late String optionSelected ="";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pytanie${widget.index+1}:\n${widget.questionModel.question}", style: TextStyle(fontSize: 18, color: Colors.black87),),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (() {
              if(!widget.questionModel.answered){
                //correct
                if(widget.questionModel.option1 == widget.questionModel.corectOption){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  correct = correct+1;
                  notAttemped=notAttemped -1;
                  setState(() {
                    
                  });
                }else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  incorrect = incorrect +1;
                  notAttemped = notAttemped-1;
                  setState(() {
                    
                  });
                }
              }
            }),
            child: OptionTile(
            corectAnswer: widget.questionModel.corectOption,
            description: widget.questionModel.option1,
            option: "A",
            optionSelected: optionSelected, 
            ),
          ),
           SizedBox(height: 4,),
          GestureDetector(
            onTap: (() {
              if(!widget.questionModel.answered){
                //correct
                if(widget.questionModel.option2 == widget.questionModel.corectOption){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  correct = correct+1;
                  notAttemped=notAttemped -1;
                  print("${widget.questionModel.corectOption}");
                  setState(() {
                    
                  });
                }else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  incorrect = incorrect +1;
                  notAttemped = notAttemped-1;
                  setState(() {
                    
                  });
                }
              }
            }),
            child: OptionTile(
            corectAnswer: widget.questionModel.corectOption,
            description: widget.questionModel.option2,
            option: "B",
            optionSelected: optionSelected, 
            ),
          ),
           SizedBox(height: 4,),
          GestureDetector(
            onTap: (() {
              if(!widget.questionModel.answered){
                //correct
                if(widget.questionModel.option3 == widget.questionModel.corectOption){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  correct = correct+1;
                  notAttemped=notAttemped -1;
                  setState(() {
                    
                  });
                }else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  incorrect = incorrect +1;
                  notAttemped = notAttemped-1;
                  setState(() {
                    
                  });
                }
              }
            }),
            child: OptionTile(
            corectAnswer: widget.questionModel.corectOption,
            description: widget.questionModel.option3,
            option: "C",
            optionSelected: optionSelected, 
            ),
          ),
           SizedBox(height: 4,),
          GestureDetector(
            onTap: (() {
              if(!widget.questionModel.answered){
                //correct
                if(widget.questionModel.option4 == widget.questionModel.corectOption){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  correct = correct+1;
                  notAttemped=notAttemped -1;
                  setState(() {
                    
                  });
                }else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  incorrect = incorrect +1;
                  notAttemped = notAttemped-1;
                  setState(() {
                    
                  });
                }
              }
            }),
            child: OptionTile(
            corectAnswer: widget.questionModel.corectOption,
            description: widget.questionModel.option4,
            option: "D",
            optionSelected: optionSelected, 
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}