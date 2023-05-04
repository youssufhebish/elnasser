import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_ui/home_screen.dart';
import 'package:elnasser/screens/initial_pages/register/register_bloc/register_cubit.dart';
import 'package:elnasser/screens/initial_pages/register/register_bloc/register_state.dart';
import 'package:elnasser/screens/initial_pages/widget/logo_register.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  const Register(
      {Key? key,
      required this.theInitialModel,
      required this.phone,
      required this.countryCode})
      : super(key: key);
  final TheInitialModel? theInitialModel;
  final String phone;
  final String countryCode;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  var nodes = [];
  var birthDateNodes = [];
  late bool? isPasswordValid = null;
  late bool? isPasswordConfirmValid = null;
  late bool? isNameValid = null;
  late bool? isEmailValid = null;
  String errorText = "";

  validateEmail() {
    setState(() {
      if (emailController.text.toString().contains(" ")) {
        emailController.text = emailController.text.trim();
      }
      isEmailValid =
          Validations.emailValidation(emailController.text.toString().trim());

      errorText = isEmailValid != true ? "emailNotValid".tr().toString() : "";
    });
  }

  validateName() {
    setState(() {
      if (nameController.text.toString().contains(" ")) {
        nameController.text = nameController.text.trim();
      }
      isNameValid =
          Validations.nameValidation(nameController.text.toString().trim());

      errorText = isNameValid != true ? "nameNotValid".tr().toString() : "";
    });
  }

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
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    // nodes.add(FocusNode());
    birthDateNodes.add(FocusNode());
    birthDateNodes.add(FocusNode());
    birthDateNodes.add(FocusNode());
    nodes[0].addListener(() {
      if (!nodes[0].hasFocus) {
        validateName();
      } else if (nameController.text.toString().isNotEmpty) {
        nameController.addListener(() {
          validateName();
        });
      }
    });

    // nodes[1].addListener(() {
    //   if (!nodes[1].hasFocus) {
    //     validatePhone();
    //   } else if (phoneController.text.toString().isNotEmpty) {
    //     phoneController.addListener(() {
    //       validatePhone();
    //     });
    //   }
    // });

    nodes[1].addListener(() {
      if (!nodes[1].hasFocus) {
        validateEmail();
      } else if (emailController.text.toString().isNotEmpty) {
        emailController.addListener(() {
          validateEmail();
        });
      }
    });

    nodes[2].addListener(() {
      if (!nodes[2].hasFocus) {
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
    nodes[3].addListener(() {
      if (!nodes[3].hasFocus) {
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

  String? gander;
  @override
  Widget build(BuildContext context) {
    String phone = (widget.countryCode + widget.phone).replaceAll("+", "");
    phoneController.text =
        EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
            ? widget.countryCode + widget.phone
            : "$phone+";

    return BlocConsumer<ConnectionCubit, InternetState>(
        builder: (context, state) {
      print('Current State $state');
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
                  text: "register".tr().toString(),
                  style: TextStyleConstant.headerText(context,
                      widget.theInitialModel!.data!.account!.mobileAppColors!),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Hero(tag: "LogoWidget", child: LogoRegister()),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      height: 6.5.h,
                      child: AppTextFiled(
                        enable: false,
                        password: false,
                        labelText: 'mobileNumber'.tr().toString(),
                        textAlign: TextAlign.left,
                        hintText: 'mobileNumber'.tr().toString(),
                        inputType: TextInputType.phone,
                        validation: true,
                        validationWidget: ValidateText(
                          validation: true,
                        ),
                        controller: phoneController,
                        colorsInitialValue: widget
                            .theInitialModel!.data!.account!.mobileAppColors!,
                        node: null,
                        nextNode: null,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      height: 6.5.h,
                      child: AppTextFiled(
                        password: false,
                        labelText: 'fullName'.tr().toString(),
                        node: nodes[0],
                        nextNode: nodes[1],
                        hintText: 'fullName'.tr().toString(),
                        inputType: TextInputType.text,
                        validation: isNameValid,
                        validationWidget: ValidateText(
                          validation: isNameValid,
                        ),
                        controller: nameController,
                        colorsInitialValue: widget
                            .theInitialModel!.data!.account!.mobileAppColors!,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      height: 6.5.h,
                      child: AppTextFiled(
                        password: false,
                        labelText: 'email'.tr().toString(),
                        node: nodes[1],
                        nextNode: nodes[2],
                        hintText: 'email'.tr().toString(),
                        inputType: TextInputType.emailAddress,
                        validation: isEmailValid,
                        validationWidget: ValidateText(
                          validation: isEmailValid,
                        ),
                        controller: emailController,
                        colorsInitialValue: widget
                            .theInitialModel!.data!.account!.mobileAppColors!,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      height: 6.5.h,
                      child: AppTextFiled(
                        password: hidePassword,
                        labelText: 'password'.tr().toString(),
                        node: nodes[2],
                        hintText: 'password'.tr().toString(),
                        nextNode: nodes[3],
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
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      height: 6.5.h,
                      child: AppTextFiled(
                        password: hidePasswordConfirm,
                        labelText: 'confirmPassword'.tr().toString(),
                        node: nodes[3],
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
                        colorsInitialValue: widget
                            .theInitialModel!.data!.account!.mobileAppColors!,
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
                      height: 1.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      child: Row(
                        children: [
                          CustomText(
                            text: "dateOfBirth".tr().toString(),
                            style: TextStyleConstant.optionalText(
                                context,
                                widget.theInitialModel!.data!.account!
                                    .mobileAppColors!),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 50,
                            child: AppTextFiled(
                              maxLength: 2,
                              password: false,
                              labelText: 'dd'.tr().toString(),
                              node: birthDateNodes[0],
                              nextNode: birthDateNodes[1],
                              hintText: 'dd'.tr().toString(),
                              inputType: TextInputType.number,
                              validation: null,
                              validationWidget: ValidateText(
                                validation: null,
                              ),
                              controller: dayController,
                              colorsInitialValue: widget.theInitialModel!.data!
                                  .account!.mobileAppColors!,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                            width: 60,
                            child: AppTextFiled(
                              maxLength: 2,
                              password: false,
                              labelText: 'mm'.tr().toString(),
                              node: birthDateNodes[1],
                              nextNode: birthDateNodes[2],
                              hintText: 'mm'.tr().toString(),
                              inputType: TextInputType.number,
                              validation: null,
                              validationWidget: ValidateText(
                                validation: null,
                              ),
                              controller: monthController,
                              colorsInitialValue: widget.theInitialModel!.data!
                                  .account!.mobileAppColors!,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                            width: 70,
                            child: AppTextFiled(
                              maxLength: 4,
                              password: false,
                              labelText: 'yyyy'.tr().toString(),
                              node: birthDateNodes[2],
                              nextNode: null,
                              hintText: 'dd'.tr().toString(),
                              inputType: TextInputType.number,
                              validation: null,
                              validationWidget: ValidateText(
                                validation: null,
                              ),
                              controller: yearController,
                              colorsInitialValue: widget.theInitialModel!.data!
                                  .account!.mobileAppColors!,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      child: Row(
                        children: [
                          CustomText(
                            text: "gender".tr().toString(),
                            style: TextStyleConstant.optionalText(
                                context,
                                widget.theInitialModel!.data!.account!
                                    .mobileAppColors!),
                          ),
                          Spacer(),
                          RadioButtonWidget(
                              theInitialModel: widget.theInitialModel!)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocConsumer<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                      return AppButton(
                        disable: (isNameValid == true &&
                                isPasswordValid == true &&
                                isPasswordConfirmValid == true)
                            ? false
                            : true,
                        color: ColorsConstant.getColorBackground3(widget
                            .theInitialModel!.data!.account!.mobileAppColors!),
                        textStyle: TextStyleConstant.whiteText(
                            context,
                            widget.theInitialModel!.data!.account!
                                .mobileAppColors!),
                        title: "register".tr().toString(),
                        colorsInitialValue: widget
                            .theInitialModel!.data!.account!.mobileAppColors!,
                        onPressed: () {
                          print(gander);

                          RegisterCubit.get(context).submitRegister(
                              context: context,
                              email: emailController.text,
                              name: nameController.text,
                              phone: widget.phone.replaceFirst("+20", ""),
                              countryCode: "+20",
                              password: passwordController.text,
                              dateOfBirth: yearController.text.isNotEmpty
                                  ? "${yearController.text}-${monthController.text}-${dayController.text}"
                                  : "");
                        },
                        widthRatio: 1.1,
                        heightRatio: 7,
                      );
                    }, listener: (context, state) {
                      if (state is RegisterStateSuccess) {
                        HomeMobileCubit.get(context).getData(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageScreen(
                                    theInitialModel: widget.theInitialModel!)));
                      } else if (state is RegisterStateFailed) {
                        DataErrorAlert.showError(
                            title:
                                RegisterCubit.get(context).errorModel!.message!,
                            data: RegisterCubit.get(context)
                                .errorModel!
                                .errors![0],
                            colorValue: widget.theInitialModel!.data!.account!
                                .mobileAppColors!,
                            context: context);
                      }
                    }),
                    SizedBox(
                      height: 3.h,
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
        RegisterCubit.get(context).getData();
      }
    });
  }
}

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({Key? key, required this.theInitialModel})
      : super(key: key);
  final TheInitialModel? theInitialModel;

  @override
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  Object _value = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
                width: 100,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    RegisterCubit.get(context).getGander("Male");
                    setState(() {
                      _value = value!;
                    });
                  },
                  title: CustomText(
                    text: "male".tr().toString(),
                    style: TextStyleConstant.subText(
                        context,
                        widget
                            .theInitialModel!.data!.account!.mobileAppColors!),
                  ),
                )),
            SizedBox(
                width: 110,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    RegisterCubit.get(context).getGander("Female");
                    setState(() {
                      _value = value!;
                    });
                  },
                  title: CustomText(
                    text: "female".tr().toString(),
                    style: TextStyleConstant.subText(
                        context,
                        widget
                            .theInitialModel!.data!.account!.mobileAppColors!),
                  ),
                )),
          ],
        );
      },
    );
  }
}
