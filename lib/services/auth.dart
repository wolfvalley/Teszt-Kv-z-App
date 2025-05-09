import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance
      .authStateChanges(); // use stream when you want a UI to react to a state change, but you are not sure when it happens, a way to listen to asynchronous events
  final user = FirebaseAuth.instance
      .currentUser; // synchronous user access, when there is an event and the authentication state must be checked, for example: create records in the database

  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException {
      print("Anonymous Login Error");
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException {}
  }
}
