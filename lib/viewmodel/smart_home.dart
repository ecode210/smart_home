import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SmartHome extends ChangeNotifier {
  double temperature = 20;
  bool smartAC = true;
  int selectedTab = 0;
  bool voice = false;

  List<Widget> sliderImages = [
    ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Image.asset(
        "assets/jpg/login1.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Image.asset(
        "assets/jpg/login2.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Image.asset(
        "assets/jpg/login3.jpg",
        fit: BoxFit.cover,
      ),
    ),
  ];

  List<bool> switches = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
  );
  GoogleSignInAccount? user;

  Future<UserCredential> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      user = googleUser;
    }
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
