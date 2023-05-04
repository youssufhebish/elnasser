class SocialResponseModel {
  SocialResponseModel({
    this.displayName,
    this.creationTime,
    this.lastSignInTime,
    this.phoneNumber,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.photoURL,
    this.providerId,
    this.userId,
    this.uid,
  });

  String? uid;
  String? displayName;
  String? creationTime;
  String? lastSignInTime;
  String? providerId;
  String? phoneNumber;
  String? photoURL;
  String? email;
  bool? emailVerified;
  bool? isAnonymous;
  String? userId;

  factory SocialResponseModel.fromJson(Map<String, dynamic> json) =>
      SocialResponseModel(
        photoURL: json["photoURL"],
        displayName: json["displayName"],
        uid: json["uid"],
        userId: json["userId"],
        phoneNumber: json["phoneNumber"],
        creationTime: json["creationTime"],
        lastSignInTime: json["lastSignInTime"],
        email: json["email"],
        emailVerified: json["emailVerified"],
        isAnonymous: json["isAnonymous"],
        providerId: json["providerId"],
      );

  Map<String, dynamic> toJson() => {
        "photoURL": photoURL,
        "displayName": displayName,
        "userId": userId,
        "phoneNumber": phoneNumber,
        "creationTime": creationTime,
        "lastSignInTime": lastSignInTime,
        "email": email,
        "emailVerified": emailVerified,
        "uid": uid,
        "isAnonymous": isAnonymous,
        "providerId": providerId,
      };
}
