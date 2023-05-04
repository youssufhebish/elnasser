import 'dart:convert';

import 'package:elnasser/services/google_service/google_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class TwitterService {
  TwitterService() {
    _auth.userChanges().listen((event) => user = event);
  }
  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithTwitter(
      {required BuildContext context,
      required String accessToken,
      required String secret}) async {
    late UserCredential userCredential;

    if (kIsWeb) {
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();
      await _auth.signInWithPopup(twitterProvider);
    } else {
      final AuthCredential credential = TwitterAuthProvider.credential(
          accessToken: "$accessToken", secret: "$secret");
      userCredential = await _auth.signInWithCredential(credential);
    }

    print('user data');

    String data = "${userCredential.user}";
    print(jsonEncode(data
        .replaceAll("User", "")
        .replaceAll("providerData, [UserInfo(", "")
        .replaceAll(")]", "")
        .replaceAll("(", "{")
        .replaceAll(")", "}")));

    print('user data******\n');

    GoogleServiceCubit.get(context).submitLogin(
        user: userCredential.user!,
        context: context,
        name: userCredential.user!.displayName!,
        email: userCredential.user!.email ?? null,
        providerId: userCredential.user!.providerData.first.uid,
        provider: "twitter");
  }
}
