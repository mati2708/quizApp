import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';

class UserService{

FirebaseAuth _auth = FirebaseAuth.instance;

AppUser? _userFromFirebaseUser(User user){
  return user != null ? AppUser(uid: user.uid) : null;
}

Future signInEmailAndPass(String email, String password) async {
  try{
    UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = authResult.user; 
    return _userFromFirebaseUser(user!);
  }catch(e){
    print(e.toString());
  }
}

Future createUserWithEmailAndPass(String email, String password) async {

  try{
    UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = authResult.user; 
    return _userFromFirebaseUser(user!);
  }catch(e){
    print(e.toString());
  }
}

Future signOut() async{

  try{
    return await _auth.signOut();
  }catch(e){
    print(e.toString());
    return null;
  }
}

}