import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/shared_methods.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/contat_us/contact_us_bloc/contact_us_cubit.dart';
import 'package:elnasser/screens/contat_us/contact_us_bloc/contat_us_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../widget/image_widget.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key, required this.info, required this.title, required this.colorsValue, required this.contactSubject})
      : super(key: key);
  final Info info;
  final List<ContactSubject> contactSubject;
  final String title;
  final ColorsInitialValue colorsValue;

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController suggestionController = TextEditingController();
  late bool? isNameValid = null;

  TextEditingController phoneController = TextEditingController();

  late bool? isPhoneValid = null;
  var nodes = [];

  validateName() {
    setState(() {
      if (nameController.text.toString().contains(" ")) {
        nameController.text = nameController.text.trim();
      }
      isNameValid = Validations.nameValidation(nameController.text.toString().trim());

      // errorText = isNameValid != true ? "nameNotValid".tr().toString() : "";
    });
  }

  validatePhone() {
    setState(() {
      if (phoneController.text.toString().contains(" ")) {
        phoneController.text = phoneController.text.trim();
      }

      isPhoneValid = Validations.mobileValidationWithoutCountryCode(phoneController.text.toString().trim(),
          int.parse("${SplashCubit.get(context).theInitialModel.data!.account!.accountsCountryMobileDigitsCount}"));

      // errorText = !isPhoneValid! ? "phoneNotValid".tr().toString() : "";
    });
  }

  List<Marker> branches = [];
  @override
  void initState() {
    // TODO: implement initState
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes[0].addListener(() {
      if (!nodes[0].hasFocus) {
        validateName();
      } else if (nameController.text.toString().isNotEmpty) {
        nameController.addListener(() {
          validateName();
        });
      }
    });
    ContactUsCubit.get(context).getID(null);
    nameController.text =
        ContactUsCubit.get(context).customer.customersName != null ? ContactUsCubit.get(context).customer.customersName! : "";
    phoneController.text =
        ContactUsCubit.get(context).customer.customersPhone != null ? "0" + ContactUsCubit.get(context).customer.customersPhone! : "";

    nodes[1].addListener(() {
      if (!nodes[1].hasFocus) {
        validatePhone();
      } else if (phoneController.text.toString().isNotEmpty) {
        phoneController.addListener(() {
          validatePhone();
        });
      }
    });
    // nodes[2].addListener(() {
    //   if (!nodes[2].hasFocus) {
    //     validatePhone();
    //   } else if (suggestionController.text.toString().isNotEmpty) {
    //     suggestionController.addListener(() {
    //       validatePhone();
    //     });
    //   }
    // });

    (widget.info.infosGps != null && widget.info.infosGps!.isNotEmpty)
        ? branches.add(Marker(
            onTap: () async {
              SharedMethods.launchMap(lat: widget.info.infosGps!.split(",").first, long: widget.info.infosGps!.split(",").last);
            },
            markerId: MarkerId("55"),
            position: LatLng(double.parse(widget.info.infosGps!.split(",").first), double.parse(widget.info.infosGps!.split(",").last)),
          ))
        : null;
    super.initState();
  }

  List<Widget> widgetIcon = [];

  addWidget() {
    widgetIcon.clear();

    widgetIcon.add(InkWell(
      onTap: () {
        SharedMethods.launchURL(widget.info.infosFacebook!);
      },
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Color(0xff3B5998),
        child: Icon(
          FontAwesomeIcons.facebookF,
          color: Colors.white,
        ),
      ),
    ));
    widgetIcon.add(InkWell(
      onTap: () {
        SharedMethods.launchURL(widget.info.infosInstagram!);
      },
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Color(0xffde5246),
        child: Icon(
          FontAwesomeIcons.instagram,
          color: Colors.white,
        ),
      ),
    ));
    widgetIcon.add(InkWell(
      onTap: () {
        SharedMethods.launchURL(widget.info.infosTwitter!);
      },
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Color(0xff3B5998),
        child: Icon(
          FontAwesomeIcons.twitter,
          color: Colors.white,
        ),
      ),
    ));
    widget.info.infosYoutube != null
        ? widgetIcon.add(SocialWidget(
            link: widget.info.infosYoutube!,
            color: Color(0xffde5246),
            icon: FontAwesomeIcons.youtube,
          ))
        : print("");
    widget.info.infosTiktok != null
        ? widgetIcon.add(SocialWidget(
            link: widget.info.infosTiktok!,
            color: Color(0xff000000),
            icon: FontAwesomeIcons.tiktok,
          ))
        : print("");
    widget.info.infosTelegram != null
        ? widgetIcon.add(SocialWidget(
            link: widget.info.infosTelegram!,
            color: Color(0xff2AABED),
            icon: FontAwesomeIcons.telegramPlane,
          ))
        : print("");
    widget.info.infosEmail != null
        ? widgetIcon.add(SocialWidget(
            isEmail: true,
            link: widget.info.infosEmail!,
            color: Color(0xffde5246),
            icon: FontAwesomeIcons.mailBulk,
          ))
        : print("");
    widget.info.infosSnapchat != null
        ? widgetIcon.add(SocialWidget(
            link: widget.info.infosSnapchat!,
            color: Color(0xffF7F404),
            icon: FontAwesomeIcons.snapchatGhost,
          ))
        : print("");

    widget.info.infosFoursquare != null
        ? widgetIcon.add(SocialWidget(
            link: widget.info.infosFoursquare!,
            color: Color(0xffF24574),
            icon: FontAwesomeIcons.foursquare,
          ))
        : print("");
  }

  @override
  Widget build(BuildContext context) {
    addWidget();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "${widget.title}".tr().toString(),
              style: TextStyleConstant.headerText(context, widget.colorsValue),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  CustomText(text: "messageUs".tr().toString(), style: TextStyleConstant.headerTextLargeBlack(context, widget.colorsValue)),
                  SizedBox(
                    height: 2.h,
                  ),
                  BlocConsumer<ContactUsCubit, ContactUsState>(builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: SizeDataConstant.customWidth(context, 1.1),
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey, width: .5)),
                            child: subjectWidget(
                              colorsValue: widget.colorsValue,
                              contactSubject: widget.contactSubject,
                            )),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          width: SizeDataConstant.customWidth(context, 1.1),
                          height: 6.5.h,
                          child: AppTextFiled(
                            prefixIcon: null,
                            password: false,
                            enable: ContactUsCubit.get(context).suggestionId != null,
                            labelText: 'fullName'.tr().toString(),
                            textAlign: TextAlign.left,
                            node: nodes[0],
                            nextNode: null,
                            hintText: 'fullName'.tr().toString(),
                            inputType: TextInputType.text,
                            validation: isNameValid,
                            validationWidget: ValidateText(
                              validation: isNameValid,
                            ),
                            controller: nameController,
                            colorsInitialValue: widget.colorsValue,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          width: SizeDataConstant.customWidth(context, 1.1),
                          height: 6.5.h,
                          child: AppTextFiled(
                            prefixIcon: null,
                            password: false,
                            enable: ContactUsCubit.get(context).suggestionId != null,
                            labelText: 'mobileNumber'.tr().toString(),
                            textAlign: TextAlign.left,
                            node: nodes[1],
                            nextNode: null,
                            hintText: 'mobileNumber'.tr().toString(),
                            inputType: TextInputType.phone,
                            validation: isPhoneValid,
                            validationWidget: ValidateText(
                              validation: isPhoneValid,
                            ),
                            controller: phoneController,
                            colorsInitialValue: widget.colorsValue,
                          ),
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            width: SizeDataConstant.customWidth(context, 1.1),
                            child: AppTextFiled(
                              enable: ContactUsCubit.get(context).suggestionId != null,
                              password: false,
                              validation: null,
                              hintText: "note".tr().toString(),
                              nextNode: null,
                              controller: suggestionController,
                              inputType: TextInputType.text,
                              labelText: "note".tr().toString(),
                              node: nodes[2],
                              validationWidget: Container(),
                              colorsInitialValue: widget.colorsValue,
                              maxLines: 5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Center(
                          child: AppButton(
                              disable: ContactUsCubit.get(context).suggestionId == null,
                              colorsInitialValue: widget.colorsValue,
                              color: ColorsConstant.getColorBackground3(widget.colorsValue),
                              textStyle: TextStyleConstant.buttonText(context, widget.colorsValue),
                              title: "send".tr().toString(),
                              onPressed: () {
                                if (suggestionController.text.isNotEmpty) {
                                  ContactUsCubit.get(context).submitLogin(
                                      context: context,
                                      message: suggestionController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                } else {
                                  DataErrorAlert.showError(
                                      title: "missing",
                                      data: "messageRequired".tr().toString(),
                                      colorValue: widget.colorsValue,
                                      context: context);
                                }
                              }),
                        ),
                      ],
                    );
                  }, listener: (context, state) {
                    if (state is ContactUsStateSuccess) {
                      DataErrorAlert.SuggestionSuccess(
                          colorValue: widget.colorsValue, context: context, data: ContactUsCubit.get(context).response!.data!["message"]);
                      suggestionController.clear();
                    }
                  }),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomText(
                      text: "getInTouch".tr().toString(), style: TextStyleConstant.headerTextLargeBlack(context, widget.colorsValue)),
                  SizedBox(
                    height: 1.h,
                  ),
                  widget.info.infosPhone1 != null
                      ? phoneWidget(
                          phone: widget.info.infosPhone1!,
                          colorsValue: widget.colorsValue,
                        )
                      : Container(),
                  widget.info.infosPhone2 != null
                      ? phoneWidget(
                          phone: widget.info.infosPhone2!,
                          colorsValue: widget.colorsValue,
                        )
                      : Container(),
                  widget.info.infosPhone3 != null
                      ? phoneWidget(
                          phone: widget.info.infosPhone3!,
                          colorsValue: widget.colorsValue,
                        )
                      : Container(),
                  Column(
                    children: [
                      widget.info.infosWhatsapp != null
                          ? IconWidget(
                              colorsValue: widget.colorsValue,
                              text: "whatsApp".tr().toString(),
                              iconData: FontAwesomeIcons.whatsapp,
                              data: "",
                              color: Colors.green,
                              onTap: () {
                                SharedMethods.launchWithURLWhats(widget.info.infosWhatsapp!);
                              },
                            )
                          : Container(),
                      widget.info.infosMessengerAccount != null
                          ? IconWidget(
                              colorsValue: widget.colorsValue,
                              text: "messenger".tr().toString(),
                              iconData: FontAwesomeIcons.facebookMessenger,
                              data: "",
                              color: ColorsConstant.getColorBackground3(widget.colorsValue),
                              onTap: () {
                                SharedMethods.launchURL("http://m.me/${widget.info.infosMessengerAccount}");
                              },
                            )
                          : Container(),
                      widget.info.infosEmail != null
                          ? IconWidget(
                              colorsValue: widget.colorsValue,
                              text: widget.info.infosEmail!,
                              iconData: Icons.email,
                              data: "",
                              color: ColorsConstant.getColorBackground3(widget.colorsValue),
                              onTap: () async {
                                print(widget.info.infosEmail!);
                                final Uri params = Uri(
                                  scheme: 'mailto',
                                  path: widget.info.infosEmail!,
                                  query: '',
                                );

                                var url = params.toString();
                                SharedMethods.launchURL(url);
                              },
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomText(text: "followUs".tr().toString(), style: TextStyleConstant.headerTextLargeBlack(context, widget.colorsValue)),
                  SizedBox(
                    height: 1.h,
                  ),
                  Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,

                      // alignment: WrapAlignment.center,

                      // children: [
                      //
                      //   ,
                      //
                      // ,
                      //
                      //  ,
                      //
                      //  // widget.info.infosYoutube !=null ? SocialWidget(link:  widget.info.infosYoutube!,color: Color(0xffde5246),icon: FontAwesomeIcons.youtube,):Container(width: 0,height: 0,),
                      //  //  widget.info.infosTiktok !=null ? SocialWidget(link:  widget.info.infosTiktok!,color: Color(0xff000000),icon: FontAwesomeIcons.tiktok,):Container(width: 0,height: 0,),
                      //  //
                      //  //  widget.info.infosTelegram !=null ? SocialWidget(link:  widget.info.infosTelegram!,color: Color(0xff2AABED),icon: FontAwesomeIcons.telegramPlane,):Container(width: 0,height: 0,),
                      //  // widget.info.infosEmail !=null ? SocialWidget(link:  widget.info.infosEmail!,color: Color(0xffde5246),icon: FontAwesomeIcons.mailBulk,):Container(width: 0,height: 0,),
                      //  //  widget.info.infosFoursquare !=null ? SocialWidget(link:  widget.info.infosFoursquare!,color: Color(0xffF24574),icon: FontAwesomeIcons.foursquare,):Container(width: 0,height: 0,),
                      //  //  widget.info.infosSnapchat !=null ? SocialWidget(link:  widget.info.infosSnapchat!,color: Color(0xffF7F404),icon: FontAwesomeIcons.snapchatGhost,):Container(width: 0,height: 0,),
                      //
                      // ],
                      children: List.generate(widgetIcon.length, (index) => widgetIcon[index]),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  (widget.info.infosGps != null && widget.info.infosGps!.isNotEmpty)
                      ? SizedBox(
                          height: 35.h,
                          child: GoogleMap(
                            onTap: (v) {},
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(double.parse(widget.info.infosGps!.split(",").first),
                                  double.parse(widget.info.infosGps!.split(",").last)),
                              zoom: 10.4746,
                            ),
                            compassEnabled: true,
                            markers: branches.toSet(),
                            onMapCreated: (GoogleMapController controller) {},
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class phoneWidget extends StatelessWidget {
  const phoneWidget({Key? key, required this.colorsValue, required this.phone}) : super(key: key);
  final String phone;
  final ColorsInitialValue colorsValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          SharedMethods.launchTel(phone);
        },
        child: SizedBox(
          height: 5.h,
          child: Row(
            children: [
              SizedBox(
                  height: 2.5.h,
                  width: 2.5.h,
                  child: ImageView(
                    path: ImageConstants.phone,
                    color: ColorsConstant.getColorBackground3(colorsValue),
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(child: CustomText(text: "$phone", style: TextStyleConstant.bodyText(context, colorsValue))),
            ],
          ),
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget(
      {Key? key,
      required this.color,
      required this.text,
      required this.colorsValue,
      required this.data,
      required this.iconData,
      required this.onTap})
      : super(key: key);
  final String data;
  final Color color;
  final IconData iconData;
  final Function() onTap;
  final ColorsInitialValue colorsValue;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // ImageView(path: ImageConstants.phone,color: ColorsConstant.getColorBackground3(colorsValue),),
            Icon(
              iconData,
              color: color,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            // Expanded(child:       CustomText(
            //     text: "$phone",
            //     style: TextStyleConstant.bodyText(
            //         context, colorsValue),),
            // ),
            CustomText(
              text: text,
              style: TextStyleConstant.bodyText(context, colorsValue),
            )
          ],
        ),
      ),
    );
  }
}

class subjectWidget extends StatefulWidget {
  subjectWidget({Key? key, required this.colorsValue, required this.contactSubject}) : super(key: key);
  final ColorsInitialValue colorsValue;
  final List<ContactSubject> contactSubject;

  @override
  State<subjectWidget> createState() => _subjectWidgetState();
}

class _subjectWidgetState extends State<subjectWidget> {
  ContactSubject? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<ContactSubject>(
      underline: Container(),
      //isDense: true,
      hint: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('chooseSubject'.tr().toString()),
      ),
      value: value,
      iconSize: 24,

      elevation: 16,
      isExpanded: true,
      style: TextStyleConstant.dropDown(context, widget.colorsValue),

      onChanged: (newValue) {
        setState(() {
          value = newValue;
          ContactUsCubit.get(context).getID(value!.contactsSubjectsId!);
        });
      },
      items: widget.contactSubject.map<DropdownMenuItem<ContactSubject>>((value) {
        return DropdownMenuItem<ContactSubject>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              text: value.contactsSubjectsTitle,
              style: TextStyleConstant.dropDown(context, widget.colorsValue),
            ),
          ),
        );
      }).toList(),
    );
  }

  DropdownMenuItem<String> items(String item) => DropdownMenuItem(
        value: item,
        child: CustomText(
          text: item.tr().toString(),
          style: TextStyle(fontSize: 16, color: ColorsConstant.getColorText1(widget.colorsValue)),
        ),
      );
}

class SocialWidget extends StatelessWidget {
  SocialWidget({Key? key, required this.color, required this.icon, required this.link, this.isEmail = false}) : super(key: key);
  final String link;
  final Color color;
  final IconData icon;
  bool isEmail;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            print(link);
            if (isEmail == true) {
              final Uri params = Uri(
                scheme: 'mailto',
                path: link,
                query: '',
              );

              var url = params.toString();

              SharedMethods.launchURL(url);
            } else {}
            SharedMethods.launchURL(link);
          },
          child: CircleAvatar(
            radius: 22,
            backgroundColor: color,
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
