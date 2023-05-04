import 'package:easy_localization/easy_localization.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_ui/home_screen.dart';
import 'package:elnasser/screens/initial_pages/forget_password/forget_password.dart';
import 'package:elnasser/screens/initial_pages/login/login_bloc/login_cubit.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/mobile_register.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/initial_pages/widget/logo_register.dart';
import 'package:elnasser/screens/initial_pages/widget/shared_register_widget.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/country_code_widget.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'login_bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.theInitialModel, required this.close}) : super(key: key);
  final TheInitialModel? theInitialModel;
  final bool close;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  var nodes = [];
  late bool? isPhoneValid = null;
  late bool? isPasswordValid = null;
  String errorText = "error";

  validatePhone() {
    setState(() {
      if (phoneController.text.toString().contains(" ")) {
        phoneController.text = phoneController.text.trim();
      }

      isPhoneValid = Validations.mobileValidation(phoneController.text.toString().trim(),
          int.parse("${SplashCubit.get(context).theInitialModel.data!.account!.accountsCountryMobileDigitsCount}"));

      errorText = !isPhoneValid!
          ? !phoneController.text.startsWith("0")
              ? "phoneNotValid".tr().toString()
              : "phoneNumberMustNotStartWith0".tr().toString()
          : "";
    });
  }

  validatePassword() {
    setState(() {
      isPasswordValid = Validations.passwordValidation(passwordController.text.toString());
      // errorText = !isPasswordValid! ? "PasswordNotValid".tr().toString() : "";
    });
  }

  @override
  void initState() {
    nodes.add(FocusNode());
    nodes.add(FocusNode());

    nodes[0].addListener(() {
      if (!nodes[0].hasFocus) {
        validatePhone();
      } else if (phoneController.text.toString().isNotEmpty) {
        phoneController.addListener(() {
          validatePhone();
        });
      }
    });

    nodes[1].addListener(() {
      if (!nodes[1].hasFocus) {
        validatePassword();
      } else if (passwordController.text.toString().isNotEmpty) {
        passwordController.addListener(() {
          passwordController.removeListener(() {});
          validatePassword();
        });
      } else {
        passwordController.addListener(() {
          if (isPasswordValid != null && isPasswordValid!) validatePassword();

          if (passwordController.text.toString().length >= 6) {
            setState(() {
              isPasswordValid = true;
            });
          }
        });
      }
    });

    HomeMobileCubit.get(context).getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        HomeMobileCubit.get(context).getMobileHome(context);
        return true;
      },
      child: BlocConsumer<ConnectionCubit, InternetState>(builder: (context, state) {
        print('Current State $state');
        if (state is InternetDisconnectedState) {
          return NoInterNetWidget();
        } else {
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  title: CustomText(
                    text: "login".tr().toString(),
                    style: TextStyleConstant.headerText(context, widget.theInitialModel!.data!.account!.mobileAppColors!),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      HomeMobileCubit.get(context).getMobileHome(context);

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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Hero(tag: "LogoWidget", child: LogoRegister()),
                      SizedBox(
                        height: 4.h,
                      ),
                      Hero(
                        tag: "PhoneTag",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "phoneNumberMustNotStartWith0".tr().toString(),
                                style:
                                    TextStyleConstant.bodyTextMainColor(context, widget.theInitialModel!.data!.account!.mobileAppColors!)),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Material(
                              child: SizedBox(
                                width: SizeDataConstant.customWidth(context, 1.1),
                                height: 6.5.h,
                                child: EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
                                    ? AppTextFiled(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: SizedBox(
                                            width: 25.w,
                                            height: 7.5.h,
                                            child: CountryCodeWidget(),
                                          ),
                                        ),
                                        password: false,
                                        labelText: 'mobileNumber'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        node: nodes[0],
                                        textInputAction: TextInputAction.next,
                                        nextNode: nodes[1],
                                        hintText: 'mobileNumber'.tr().toString(),
                                        inputType: TextInputType.phone,
                                        validation: isPhoneValid,
                                        validationWidget: ValidateText(
                                          validation: isPhoneValid,
                                        ),
                                        controller: phoneController,
                                        colorsInitialValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                                      )
                                    : AppTextFiledArabic(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: SizedBox(
                                            height: 6.5.h,
                                            width: 20.w,
                                            child: CountryCodeWidget(),
                                          ),
                                        ),
                                        password: false,
                                        labelText: 'mobileNumber'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        node: nodes[0],
                                        nextNode: nodes[1],
                                        textInputAction: TextInputAction.next,
                                        hintText: 'mobileNumber'.tr().toString(),
                                        inputType: TextInputType.phone,
                                        validation: isPhoneValid,
                                        validationWidget: ValidateText(
                                          validation: isPhoneValid,
                                        ),
                                        controller: phoneController,
                                        colorsInitialValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.h,
                      ),
                      isPhoneValid != true
                          ? SizedBox(
                              width: SizeDataConstant.customWidth(context, 1.1),
                              child: Row(
                                children: [
                                  CustomText(
                                      text: errorText.tr().toString(),
                                      style: TextStyleConstant.errorText(context, widget.theInitialModel!.data!.account!.mobileAppColors!)),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: SizeDataConstant.customWidth(context, 1.1),
                        height: 6.5.h,
                        child: AppTextFiled(
                          password: hidePassword,
                          labelText: 'password'.tr().toString(),
                          node: nodes[1],
                          hintText: 'password'.tr().toString(),
                          nextNode: null,
                          inputType: TextInputType.text,
                          validation: true,
                          validationWidget: IconButton(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye)),
                          controller: passwordController,
                          colorsInitialValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
                        return AppButton(
                          color: ColorsConstant.getColorBackground3(widget.theInitialModel!.data!.account!.mobileAppColors!),
                          textStyle: TextStyleConstant.whiteText(context, widget.theInitialModel!.data!.account!.mobileAppColors!),
                          title: "signIn".tr().toString(),
                          colorsInitialValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                          onPressed: () {
                            LoginCubit.get(context)
                                .submitLogin(context: context, phone: phoneController.text, password: passwordController.text);
                          },
                          widthRatio: 1.1,
                          heightRatio: 7,
                        );
                      }, listener: (context, state) {
                        if (state is LoginStateSuccess) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => HomePageScreen(theInitialModel: widget.theInitialModel)));
                          SplashCubit.get(context).getAppData(context: context);

                          HomeMobileCubit.get(context).getData(context);
                          HomeMobileCubit.get(context).getMobileHome(context);
                        } else if (state is LoginStateFailed) {
                          DataErrorAlert.showError(
                              title: LoginCubit.get(context).errorModel!.message!,
                              data: LoginCubit.get(context).errorModel!.errors![0],
                              colorValue: widget.theInitialModel!.data!.account!.mobileAppColors!,
                              context: context);
                        }
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      InkWell(
                          onTap: () {
                            /// go to forget password
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword(
                                          theInitialModel: widget.theInitialModel!,
                                          title: "forgetPasswordTitle",
                                        )));
                          },
                          child: CustomText(
                              text: "forgotPassword".tr().toString(),
                              style: TextStyleConstant.bodyText(context, widget.theInitialModel!.data!.account!.mobileAppColors!))),
                      SizedBox(
                        height: 4.h,
                      ),
                      Hero(
                        tag: "SharedRegisterWidget",
                        child: SharedRegisterWidget(
                          theInitialModel: widget.theInitialModel,
                          onPressed: () {
                            if (widget.close != true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MobileRegister(
                                            theInitialModel: SplashCubit.get(context).theInitialModel,
                                            close: true,
                                          )));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: "don'tHaveAnAccount",
                          buttonTitle: "register",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }, listener: (context, state) {
        if (state is InternetConnectedState) {
          LoginCubit.get(context).getData();
        }
      }),
    );
  }
}
