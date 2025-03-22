import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/views/signin.dart';
import 'package:flutter/material.dart';
import '../helper/functions.dart';
import '../widget/widgets.dart';
import 'home.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

final _formKey = GlobalKey<FormState>();
late String name, email, password;
bool _isLoading = false;
 UserService userService = UserService();

signUp() async {
  if(_formKey.currentState!.validate()){
    setState(() {
      _isLoading = true;
    });

    await userService.createUserWithEmailAndPass(email,password).then((value){
        if(value != null){
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
        elevation: 0.0
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Wprowadz nazwę" : null;},
                decoration: InputDecoration(
                  hintText: "Nazwa"
                ),
                onChanged: (val){
                  name = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Wprowadź poprawny mail" : null;},
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                onChanged: (val){
                  email = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                obscureText:  true,
                validator: (val){return val!.isEmpty ? "Wprowadź poprawne hasło" : null;},
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
                  signUp();
                },
                child: blueButton(
                  context: context, 
                  label: "Zarejestruj się",
                ),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Masz już konto? ", style: TextStyle(fontSize: 15.5,),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => SignIn())
                        );
                    },
                    child: Text("Zaloguj się ", style: TextStyle(fontSize: 15.5, decoration: TextDecoration.underline),)),
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