import 'package:elnasser/animation/loader.dart';
import 'package:elnasser/services/google_service/google_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FaceBookLoginService {
  final fb = FacebookLogin();
  User? user;
  FirebaseAuth? auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    await fb.logOut();
  }

  fbSignIn(BuildContext context) async {
// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    Loader.showLoader(context);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Acces Token $accessToken');
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        print("authCredential");
        print(authCredential.providerId);
        print(authCredential.signInMethod);
        print(authCredential.token);
        print("authCredential");
        user =
            (await FirebaseAuth.instance.signInWithCredential(authCredential))
                .user;

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        print(user!.uid);
        print(user!.tenantId);
        // print(user.credential.token);
        // print(result.credential.providerId);
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: ${user!.providerData}');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>WebPage(userToken: profile.userId,email:result.user.email,name:result.user.displayName,phone: result.user.phoneNumber!= null ?result.user.phoneNumber :"",type: "faceBook",)));

        print('user data');
        print(user);
        print(user!.providerData.first.uid);
        print(user!.providerData.first.uid);
        print('user data******\n');

        GoogleServiceCubit.get(context).submitLogin(
            user: user!,
            context: context,
            name: user!.displayName!,
            email: user!.providerData.first.email ?? "",
            providerId: user!.providerData.first.uid,
            provider: "facebook");

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        Loader.hideLoader(context);

        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        Loader.hideLoader(context);

        break;
    }
  }
}
