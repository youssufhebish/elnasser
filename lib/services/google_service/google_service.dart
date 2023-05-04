import 'package:elnasser/animation/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'google_cubit.dart';

class GoogleSignService {
  GoogleSignService() {
    Firebase.initializeApp();
  }

  Future<bool> signinWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    Loader.showLoader(context);

    if (googleUser == null) {
      Loader.hideLoader(context);

      return false;
    }

    final GoogleSignInAuthentication googleAuthentication =
        await googleUser.authentication;

    final OAuthCredential credential = await GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential != null) {
      // Get user data

      print('user data');
      print(userCredential.user);
      print(userCredential.user!.providerData.first.uid);
      print('user data******\n');
      print('additionalUserInfo******');
      print(userCredential.additionalUserInfo);
      print('additionalUserInfo******\n');
      print('credentsial******');
      print(userCredential.credential);
      print('credentsial******\n');
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>WebPage(userToken: googleUser.id,email:userCredential.user.email,name:userCredential.user.displayName,phone: userCredential.user.phoneNumber!= null ?userCredential.user.phoneNumber :"",type: "google",)));
      GoogleServiceCubit.get(context).submitLogin(
          user: userCredential.user!,
          context: context,
          name: userCredential.user!.displayName!,
          email: userCredential.user!.providerData.first.email ?? "",
          providerId: userCredential.user!.providerData.first.uid,
          provider: "google");
    }

    return true;
  }

  void signOut() async {
    await GoogleSignIn().signOut();
  }
}
