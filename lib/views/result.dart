import 'package:firstapp/widget/widgets.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int correct, incorrect, total;
  const Result(this.correct, this.incorrect, this.total, {super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}", style: TextStyle(fontSize: 25,),),
              SizedBox(height: 8,),
              Text("You answered ${widget.correct} answers correctly"
              "and ${widget.incorrect} answers incorrectly", 
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 14,),
              GestureDetector(
                onTap: (() {
                  Navigator.pop(context);
                }),
                child: blueButton(context: context, label: "Go to Home", buttonWidth: MediaQuery.of(context).size.width/2))
            ],
          ),
        ),
      )
    );
  }
}