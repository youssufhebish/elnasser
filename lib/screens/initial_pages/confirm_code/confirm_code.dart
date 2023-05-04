import 'dart:async';

import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/screens/edit_user/edit_user_screen.dart';
import 'package:elnasser/screens/initial_pages/forget_password/change_password.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_bloc.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_state.dart';
import 'package:elnasser/screens/initial_pages/register/register.dart';
import 'package:elnasser/screens/initial_pages/register/register_bloc/register_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/initial_pages/widget/logo_register.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class ConfirmCode extends StatefulWidget {
  ConfirmCode(
      {Key? key,
      required this.theInitialModel,
      required this.phone,
      required this.type})
      : super(key: key);
  final TheInitialModel? theInitialModel;
  final String type;
  final String phone;

  @override
  State<ConfirmCode> createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  TextEditingController codeController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;

  String currentText = "";

  final formKey = GlobalKey<FormState>();
  bool disable = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionCubit, InternetState>(
        builder: (context, state) {
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: ColorsConstant.getColorBackground6(widget
                        .theInitialModel!.data!.account!.mobileAppColors!),
                  ),
                ),
                title: CustomText(
                  text: "confirmCode".tr().toString(),
                  style: TextStyleConstant.headerText(context,
                      widget.theInitialModel!.data!.account!.mobileAppColors!),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Hero(tag: "LogoWidget", child: LogoRegister()),
                    SizedBox(
                      height: 5.h,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: TextStyle(
                                color: ColorsConstant.getColorBorder1(widget
                                    .theInitialModel!
                                    .data!
                                    .account!
                                    .mobileAppColors!),
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              obscureText: false,
                              obscuringCharacter: '*',

                              blinkWhenObscuring: true,

                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 3) {
                                  return "I'm from validator";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                activeColor: ColorsConstant.getColorBorder1(
                                    widget.theInitialModel!.data!.account!
                                        .mobileAppColors!),
                                inactiveColor: ColorsConstant.getColorBorder1(
                                    widget.theInitialModel!.data!.account!
                                        .mobileAppColors!),
                                inactiveFillColor:
                                    ColorsConstant.getColorBorder1(widget
                                        .theInitialModel!
                                        .data!
                                        .account!
                                        .mobileAppColors!),
                                selectedColor: ColorsConstant.getColorBorder1(
                                    widget.theInitialModel!.data!.account!
                                        .mobileAppColors!),
                                selectedFillColor: Colors.white,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                                disabledColor: Colors.white,
                              ),
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),
                              enableActiveFill: true,
                              errorAnimationController: errorController,
                              controller: codeController,
                              keyboardType: TextInputType.number,

                              onCompleted: (v) {
                                setState(() {
                                  disable = false;
                                });
                              },
                              // onTap: () {
                              //   print("Pressed");
                              // },
                              onChanged: (value) {
                                print(value);
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocConsumer<SmsCubit, SmsState>(builder: (context, state) {
                      return AppButton(
                        disable: disable,
                        color: ColorsConstant.getColorBackground3(widget
                            .theInitialModel!.data!.account!.mobileAppColors!),
                        textStyle: TextStyleConstant.whiteText(
                            context,
                            widget.theInitialModel!.data!.account!
                                .mobileAppColors!),
                        title: "submit".tr().toString(),
                        colorsInitialValue: widget
                            .theInitialModel!.data!.account!.mobileAppColors!,
                        onPressed: () {
                          SmsCubit.get(context).checkSms(
                              code: codeController.text,
                              phone: widget.phone,
                              context: context);
                        },
                        widthRatio: 1.1,
                        heightRatio: 7,
                      );
                    }, listener: (context, state) {
                      if (state is SmsStateCheckCodeSuccess) {
                        switch (widget.type) {
                          case "updateUser":
                            EditUserCubit.get(context).editUserMethod(
                                context: context,
                                email: EditUserCubit.get(context)
                                        .customer
                                        .customersEmail ??
                                    null,
                                name: EditUserCubit.get(context)
                                    .customer
                                    .customersName!,
                                phone: widget.phone,
                                countryCode:
                                    "${EditUserCubit.get(context).customer.customersCountryCode}",
                                dateOfBirth: EditUserCubit.get(context)
                                    .customer
                                    .customersBirthday);

                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateUser(
                                        theInitialModel:
                                            widget.theInitialModel!,
                                        phone: widget.phone)));
                            break;
                          case "register":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register(
                                          theInitialModel:
                                              SplashCubit.get(context)
                                                  .theInitialModel,
                                          phone: widget.phone,
                                          countryCode: SmsCubit.get(context)
                                              .countryCode!,
                                        )));
                            break;
                          case "forgetPassword":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangeForgetPassword(
                                        theInitialModel:
                                            widget.theInitialModel!,
                                        phone: widget.phone)));
                            break;
                        }
                      } else if (state is SmsStateCheckCodeFailure) {
                        DataErrorAlert.showError(
                            title: SmsCubit.get(context).errorModel!.message!,
                            data:
                                SmsCubit.get(context).errorModel!.errors != null
                                    ? SmsCubit.get(context)
                                        .errorModel!
                                        .errors!
                                        .first
                                    : "",
                            colorValue: widget.theInitialModel!.data!.account!
                                .mobileAppColors!,
                            context: context);
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        SmsCubit.get(context).getData();
      }
    });
  }
}
