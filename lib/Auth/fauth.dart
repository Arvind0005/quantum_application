import 'package:firebase_auth/firebase_auth.dart';

class Fauth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future Signupwithemailandpassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await user.sendEmailVerification();
      return "Signed up";
    } catch (e) {
      print(e.toString());
      return "e" + e.toString();
    }
  }

  Future Loginwithemailandpassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (user.emailVerified) {
        return user;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return "e" + e.toString();
    }
  }

  Future Logout() async {
    await auth.signOut();
    return;
  }
}
