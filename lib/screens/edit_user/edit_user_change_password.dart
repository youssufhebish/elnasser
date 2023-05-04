import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_state.dart';
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

class EditUserChangePassword extends StatefulWidget {
  const EditUserChangePassword({Key? key, required this.theInitialModel})
      : super(key: key);
  final TheInitialModel? theInitialModel;
  @override
  _EditUserChangePasswordState createState() => _EditUserChangePasswordState();
}

class _EditUserChangePasswordState extends State<EditUserChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideNewPassword = true;
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

      // errorText = isPasswordConfirmValid != true
      //     ? "passwordNotMatch".tr().toString()
      //     : "";
    });
  }

  validatePassword() {
    setState(() {
      isPasswordValid =
          Validations.passwordValidation(passwordController.text.toString());
      // errorText =
      // isPasswordValid != true ? "passwordNotValid".tr().toString() : "";
    });
  }

  @override
  void initState() {
    nodes.add(FocusNode());
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
    nodes[2].addListener(() {
      if (!nodes[2].hasFocus) {
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
                      controller: oldPasswordController,
                      colorsInitialValue: widget
                          .theInitialModel!.data!.account!.mobileAppColors!,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Center(
                  child: SizedBox(
                    width: SizeDataConstant.customWidth(context, 1.1),
                    height: 6.5.h,
                    child: AppTextFiled(
                      onchange: (v) {
                        setState(() {
                          errorText = "";
                        });
                      },
                      password: hideNewPassword,
                      labelText: 'newPassword'.tr().toString(),
                      node: nodes[1],
                      hintText: 'newPassword'.tr().toString(),
                      nextNode: nodes[2],
                      inputType: TextInputType.text,
                      validation: true,
                      validationWidget: IconButton(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              hideNewPassword = !hideNewPassword;
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
                    onchange: (v) {
                      setState(() {
                        errorText = "";
                      });
                    },
                    password: hidePasswordConfirm,
                    labelText: 'confirmNewPassword'.tr().toString(),
                    node: nodes[2],
                    hintText: 'confirmNewPassword'.tr().toString(),
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
                BlocConsumer<EditUserCubit, EditUserState>(
                    builder: (context, state) {
                  return AppButton(
                    // disable: (isPasswordValid == true && isPasswordConfirmValid == true)?false:true,
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
                      if (passwordController.text
                              .compareTo(confirmPasswordController.text) !=
                          0) {
                        setState(() {
                          errorText = "passwordNotMatch".tr().toString();
                        });
                      } else if ((passwordController.text.length < 6 ||
                          confirmPasswordController.text.length < 6)) {
                        setState(() {
                          errorText = "passwordToSmall".tr().toString();
                        });
                      } else {
                        EditUserCubit.get(context).changePassword(
                            context: context,
                            oldPassword: oldPasswordController.text,
                            newPassword: passwordController.text);
                      }
                      // ForgetPasswordCubit.get(context).changePassword(context: context, phone: widget.phone, password: passwordController.text);
                    },
                    widthRatio: 1.1,
                    heightRatio: 7,
                  );
                }, listener: (context, state) {
                  if (state is EditUserStateChangeSuccess) {
                    Navigator.pop(context);
                  } else if (state is EditUserStateChangeFail) {
                    DataErrorAlert.showError(
                        title: EditUserCubit.get(context).errorModel.message!,
                        data: EditUserCubit.get(context)
                                .errorModel
                                .errors!
                                .isNotEmpty
                            ? EditUserCubit.get(context).errorModel.errors![0]
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
