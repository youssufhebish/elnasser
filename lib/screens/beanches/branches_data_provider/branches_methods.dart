import 'package:url_launcher/url_launcher.dart';

class BranchesMethods {
  launchWithURLWhats(String url) async {
    //const url = 'https://flutter.dev';
    var whatsappUrl = "whatsapp://send?phone=$url";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  launchTel(String phone) async {
    String url = 'tel://${phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
