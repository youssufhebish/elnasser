import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/initial_pages/forget_password/forget_password_bloc/forget_password_cubit.dart';
import 'package:elnasser/screens/initial_pages/forget_password/forget_password_bloc/forget_password_state.dart';
import 'package:elnasser/screens/initial_pages/login/login_screen.dart';
import 'package:elnasser/screens/initial_pages/mobile_register/sms_bloc/sms_bloc.dart';
import 'package:elnasser/screens/initial_pages/widget/logo_register.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChangeForgetPassword extends StatefulWidget {
  const ChangeForgetPassword(
      {Key? key, required this.theInitialModel, required this.phone})
      : super(key: key);
  final TheInitialModel? theInitialModel;
  final String phone;
  @override
  _ChangeForgetPasswordState createState() => _ChangeForgetPasswordState();
}

class _ChangeForgetPasswordState extends State<ChangeForgetPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  var nodes = [];

  late bool? isPasswordValid = null;
  late bool? isPasswordConfirmValid = null;

  String errorText = "";

  validateConfirmPassword() {
    setState(() {
      if (confirmPasswordController.text.toString().contains(" ")) {
        confirmPasswordController.text = confirmPasswordController.text.trim();
      }
      isPasswordConfirmValid = Validations.confirmPasswordValidation(
          confirmPasswordController.text.toString().trim(),
          passwordController.text);

      errorText = isPasswordConfirmValid != true
          ? "passwordNotMatch".tr().toString()
          : "";
    });
  }

  validatePassword() {
    setState(() {
      isPasswordValid =
          Validations.passwordValidation(passwordController.text.toString());
      errorText =
          isPasswordValid != true ? "PasswordNotValid".tr().toString() : "";
    });
  }

  @override
  void initState() {
    nodes.add(FocusNode());
    nodes.add(FocusNode());

    // nodes.add(FocusNode());

    // nodes[1].addListener(() {
    //   if (!nodes[1].hasFocus) {
    //     validatePhone();
    //   } else if (phoneController.text.toString().isNotEmpty) {
    //     phoneController.addListener(() {
    //       validatePhone();
    //     });
    //   }
    // });

    nodes[0].addListener(() {
      if (!nodes[0].hasFocus) {
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
    nodes[1].addListener(() {
      if (!nodes[1].hasFocus) {
        validateConfirmPassword();
      } else if (confirmPasswordController.text.toString().isNotEmpty) {
        confirmPasswordController.addListener(() {
          confirmPasswordController.removeListener(() {});
          validateConfirmPassword();
        });
      } else {
        confirmPasswordController.addListener(() {
          if (isPasswordConfirmValid != null && isPasswordConfirmValid!)
            validateConfirmPassword();

          if (confirmPasswordController.text.toString().length >= 6 &&
              passwordController.text.toString() ==
                  confirmPasswordController.text.toString()) {
            setState(() {
              isPasswordValid = true;
              isPasswordConfirmValid = true;
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                color: ColorsConstant.getColorBackground6(
                    widget.theInitialModel!.data!.account!.mobileAppColors!),
              ),
            ),
            title: CustomText(
              text: "changePassword".tr().toString(),
              style: TextStyleConstant.headerText(context,
                  widget.theInitialModel!.data!.account!.mobileAppColors!),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Hero(tag: "LogoWidget", child: LogoRegister()),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: SizedBox(
                    width: SizeDataConstant.customWidth(context, 1.1),
                    height: 6.5.h,
                    child: AppTextFiled(
                      password: hidePassword,
                      labelText: 'password'.tr().toString(),
                      node: nodes[0],
                      hintText: 'password'.tr().toString(),
                      nextNode: nodes[1],
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
                      colorsInitialValue: widget
                          .theInitialModel!.data!.account!.mobileAppColors!,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: SizeDataConstant.customWidth(context, 1.1),
                  height: 6.5.h,
                  child: AppTextFiled(
                    password: hidePasswordConfirm,
                    labelText: 'confirmPassword'.tr().toString(),
                    node: nodes[1],
                    hintText: 'confirmPassword'.tr().toString(),
                    nextNode: null,
                    inputType: TextInputType.text,
                    validation: true,
                    validationWidget: IconButton(
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            hidePasswordConfirm = !hidePasswordConfirm;
                          });
                        },
                        icon: const Icon(Icons.remove_red_eye)),
                    controller: confirmPasswordController,
                    colorsInitialValue:
                        widget.theInitialModel!.data!.account!.mobileAppColors!,
                  ),
                ),
                SizedBox(
                  height: errorText.isNotEmpty ? 2.h : 0,
                ),
                SizedBox(
                  width: SizeDataConstant.customWidth(context, 1.2),
                  child: Row(
                    children: [
                      CustomText(
                        text: errorText,
                        style: TextStyleConstant.errorText(
                            context,
                            widget.theInitialModel!.data!.account!
                                .mobileAppColors!),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (context, state) {
                  return AppButton(
                    disable: (isPasswordValid == true &&
                            isPasswordConfirmValid == true)
                        ? false
                        : true,
                    color: ColorsConstant.getColorBackground3(widget
                        .theInitialModel!.data!.account!.mobileAppColors!),
                    textStyle: TextStyleConstant.whiteText(
                        context,
                        widget
                            .theInitialModel!.data!.account!.mobileAppColors!),
                    title: "submit".tr().toString(),
                    colorsInitialValue:
                        widget.theInitialModel!.data!.account!.mobileAppColors!,
                    onPressed: () {
                      ForgetPasswordCubit.get(context).changePassword(
                          context: context,
                          phone: widget.phone,
                          password: passwordController.text);
                    },
                    widthRatio: 1.1,
                    heightRatio: 7,
                  );
                }, listener: (context, state) {
                  if (state is ForgetPasswordSuccessState) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(
                                  theInitialModel: widget.theInitialModel!,
                                  close: false,
                                )));
                  } else if (state is ForgetPasswordFailedState) {
                    DataErrorAlert.showError(
                        title: ForgetPasswordCubit.get(context)
                            .errorModel!
                            .message!,
                        data: ForgetPasswordCubit.get(context)
                                .errorModel!
                                .errors!
                                .isNotEmpty
                            ? ForgetPasswordCubit.get(context)
                                .errorModel!
                                .errors![0]
                            : "",
                        colorValue: widget
                            .theInitialModel!.data!.account!.mobileAppColors!,
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
}
