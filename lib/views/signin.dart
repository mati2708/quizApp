import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/helper/functions.dart';
import 'package:firstapp/views/home.dart';
import 'package:firstapp/views/signup.dart';
import 'package:flutter/material.dart';
import '../widget/widgets.dart';
import 'package:firstapp/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{

  final _formKey = GlobalKey<FormState>();
  late String email, password;

  bool _isLoading = false;

  var userService = UserService();


  signIn() async {
    if(_formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true;
      });


      await userService.signInEmailAndPass(email,password).then((val){
        if(val != null){
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home()
            ));
        }
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
      ),
      body: _isLoading ? Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Wprowadź prawidłowe dane", style: TextStyle(fontSize: 20),),
              SizedBox(height: 22,),
              GestureDetector(
                onTap: (() {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => SignIn())
                        );
                }),
                child: blueButton(context: context, label: "Powrót do logowania", buttonWidth: MediaQuery.of(context).size.width/2))
            ],
          ),
        ),
      )
    ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Wprowadź poprawny email" : null;},
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                onChanged: (val){
                  email = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Wprowadż poprawne hasło" : null;},
                decoration: InputDecoration(
                  hintText: "Hasło"
                ),
                onChanged: (val){
                  password = val;
                },
              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap: () {
                  signIn();
                },
                child: blueButton(
                  context: context, 
                  label: "Zaloguj się",
                )
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nie masz konta? ", style: TextStyle(fontSize: 15.5,),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => SignUp())
                        );
                    },
                    child: Text("Zarejestruj się ", style: TextStyle(fontSize: 15.5, decoration: TextDecoration.underline),)),
                ],
              ),


              SizedBox(height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}