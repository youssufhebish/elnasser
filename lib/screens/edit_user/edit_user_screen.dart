import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/helpers/validation.dart';
import 'package:elnasser/models/splash_model/the_initial_model.dart';
import 'package:elnasser/screens/edit_user/change_phone.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_cubit.dart';
import 'package:elnasser/screens/edit_user/edit_user_bloc/edit_user_state.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/initial_pages/widget/logo_register.dart';
import 'package:elnasser/widget/alert.dart';
import 'package:elnasser/widget/app_button.dart';
import 'package:elnasser/widget/app_text_field.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'edit_user_change_password.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser({Key? key, required this.theInitialModel, this.phone}) : super(key: key);
  final TheInitialModel theInitialModel;
  String? phone;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
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
  late bool? isPhoneValid = null;
  String errorText = "";

  validateEmail() {
    setState(() {
      if (emailController.text.toString().contains(" ")) {
        emailController.text = emailController.text.trim();
      }
      isEmailValid = Validations.emailValidation(emailController.text.toString().trim());

      errorText = isEmailValid != true ? "emailNotValid".tr().toString() : "";
    });
  }

  validatePhone() {
    setState(() {
      if (phoneController.text.toString().contains(" ")) {
        phoneController.text = phoneController.text.trim();
      }

      isPhoneValid = Validations.mobileValidation(phoneController.text.toString().trim(),
          int.parse("${SplashCubit.get(context).theInitialModel.data!.account!.accountsCountryMobileDigitsCount}"));

      errorText = !isPhoneValid! ? "phoneNotValid".tr().toString() : "";
    });
  }

  validatePassword() {
    setState(() {
      isPasswordValid = Validations.passwordValidation(passwordController.text.toString());
      errorText = isPasswordValid != true ? "PasswordNotValid".tr().toString() : "";
    });
  }

  @override
  void initState() {
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    // nodes.add(FocusNode());
    birthDateNodes.add(FocusNode());
    birthDateNodes.add(FocusNode());
    birthDateNodes.add(FocusNode());
    phoneController.text = widget.phone == null
        ? EditUserCubit.get(context).customer.customersPhone != null
            ? EditUserCubit.get(context).customer.customersPhone!
            : ""
        : widget.phone!;
    nameController.text = EditUserCubit.get(context).customer.customersName!;
    emailController.text = EditUserCubit.get(context).customer.customersEmail ?? "";
    // passwordController.text = "********";
    dayController.text = EditUserCubit.get(context).customer.customersBirthday != null
        ? EditUserCubit.get(context).customer.customersBirthday.toString().split("-")[2]
        : "";
    monthController.text = EditUserCubit.get(context).customer.customersBirthday != null
        ? EditUserCubit.get(context).customer.customersBirthday.toString().split("-")[1]
        : "";
    yearController.text = EditUserCubit.get(context).customer.customersBirthday != null
        ? EditUserCubit.get(context).customer.customersBirthday.toString().split("-")[0]
        : "";
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
        // validateName();
      } else if (nameController.text.toString().isNotEmpty) {
        nameController.addListener(() {
          // validateName();
        });
      }
    });
    nodes[2].addListener(() {
      if (!nodes[2].hasFocus) {
        validateEmail();
      } else if (emailController.text.toString().isNotEmpty) {
        emailController.addListener(() {
          validateEmail();
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

    super.initState();
  }

  String? gander;
  @override
  Widget build(BuildContext context) {
    // validateEmail();
    return BlocConsumer<ConnectionCubit, InternetState>(builder: (context, state) {
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
                    color: ColorsConstant.getColorBackground6(widget.theInitialModel.data!.account!.mobileAppColors!),
                  ),
                ),
                title: CustomText(
                  text: "profile".tr().toString(),
                  style: TextStyleConstant.headerText(context, widget.theInitialModel.data!.account!.mobileAppColors!),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTextFiled(
                              enable: false,
                              password: false,
                              labelText: 'mobileNumber'.tr().toString(),
                              textAlign: TextAlign.left,
                              hintText: 'mobileNumber'.tr().toString(),
                              inputType: TextInputType.phone,
                              validation: true,
                              validationWidget: Container(
                                width: 0,
                                height: 0,
                              ),
                              controller: phoneController,
                              colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
                              node: nodes[0],
                              nextNode: nodes[1],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: SizeDataConstant.customWidth(context, 4),
                            child: AppButton(
                                colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
                                color: ColorsConstant.getColorBackground3(widget.theInitialModel.data!.account!.mobileAppColors!),
                                textStyle: TextStyleConstant.buttonText(context, widget.theInitialModel.data!.account!.mobileAppColors!),
                                title: "change".tr().toString(),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChangePhone(
                                                theInitialModel: widget.theInitialModel,
                                              )));
                                }),
                          )
                        ],
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
                        labelText: 'name'.tr().toString(),
                        node: nodes[1],
                        nextNode: nodes[2],
                        hintText: 'name'.tr().toString(),
                        inputType: TextInputType.text,
                        validation: true,
                        validationWidget: ValidateText(
                          validation: true,
                        ),
                        controller: nameController,
                        colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
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
                        node: nodes[2],
                        nextNode: null,
                        hintText: 'email'.tr().toString(),
                        inputType: TextInputType.emailAddress,
                        validation: isEmailValid,
                        validationWidget: ValidateText(
                          validation: emailController.text.isNotEmpty ? isEmailValid : true,
                        ),
                        controller: emailController,
                        colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.2),
                      child: Row(
                        children: [
                          CustomText(
                            text: errorText,
                            style: TextStyleConstant.errorText(context, widget.theInitialModel.data!.account!.mobileAppColors!),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: SizeDataConstant.customWidth(context, 1.1),
                      height: 6.5.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTextFiled(
                              enable: false,
                              password: hidePassword,
                              labelText: '*********',
                              node: null,
                              hintText: "*********",
                              nextNode: null,
                              inputType: TextInputType.text,
                              validation: true,
                              validationWidget: Container(
                                width: 0,
                                height: 0,
                              ),
                              controller: passwordController,
                              colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: SizeDataConstant.customWidth(context, 4),
                            child: AppButton(
                                colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
                                color: ColorsConstant.getColorBackground3(widget.theInitialModel.data!.account!.mobileAppColors!),
                                textStyle: TextStyleConstant.buttonText(context, widget.theInitialModel.data!.account!.mobileAppColors!),
                                title: "change".tr().toString(),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditUserChangePassword(
                                                theInitialModel: widget.theInitialModel,
                                              )));
                                }),
                          )
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
                            style: TextStyleConstant.optionalText(context, widget.theInitialModel.data!.account!.mobileAppColors!),
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
                              colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
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
                              colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
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
                              colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
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
                            style: TextStyleConstant.optionalText(context, widget.theInitialModel.data!.account!.mobileAppColors!),
                          ),
                          Spacer(),
                          RadioButtonWidget(theInitialModel: widget.theInitialModel)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocConsumer<EditUserCubit, EditUserState>(builder: (context, state) {
                      return AppButton(
                        // disable: (isEmailValid == true) ? false:true,
                        color: ColorsConstant.getColorBackground3(widget.theInitialModel.data!.account!.mobileAppColors!),
                        textStyle: TextStyleConstant.whiteText(context, widget.theInitialModel.data!.account!.mobileAppColors!),
                        title: "edit".tr().toString(),
                        colorsInitialValue: widget.theInitialModel.data!.account!.mobileAppColors!,
                        onPressed: () {
                          print(gander);

                          EditUserCubit.get(context).editUserMethod(
                              context: context,
                              email: emailController.text,
                              name: nameController.text,
                              phone: "${phoneController.text}",
                              countryCode: "${EditUserCubit.get(context).customer.customersCountryCode}",
                              dateOfBirth: yearController.text.isNotEmpty
                                  ? "${yearController.text}-${monthController.text}-${dayController.text}"
                                  : "");
                        },
                        widthRatio: 1.1,
                        heightRatio: 7,
                      );
                    }, listener: (context, state) {
                      if (state is EditUserStateUpdateSuccess) {
                        DataErrorAlert.upDateSuccess(colorValue: widget.theInitialModel.data!.account!.mobileAppColors, context: context);
                      } else if (state is EditUserStateUpdateFail) {
                        DataErrorAlert.showError(
                            title: EditUserCubit.get(context).errorModel.message!,
                            data: EditUserCubit.get(context).errorModel.errors![0],
                            colorValue: widget.theInitialModel.data!.account!.mobileAppColors!,
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
        EditUserCubit.get(context).getData(context);
      }
    });
  }
}

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({Key? key, required this.theInitialModel}) : super(key: key);
  final TheInitialModel? theInitialModel;

  @override
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  Object _value = 0;
  @override
  void initState() {
    // TODO: implement initState
    _value = EditUserCubit.get(context).customer.customersGender != null
        ? EditUserCubit.get(context).customer.customersGender == "Male"
            ? 1
            : 2
        : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
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
                    EditUserCubit.get(context).getGander("Male");
                    setState(() {
                      _value = value!;
                    });
                  },
                  title: CustomText(
                    text: "male".tr().toString(),
                    style: TextStyleConstant.subText(context, widget.theInitialModel!.data!.account!.mobileAppColors!),
                  ),
                )),
            SizedBox(
                width: 110,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    EditUserCubit.get(context).getGander("Female");
                    setState(() {
                      _value = value!;
                    });
                  },
                  title: CustomText(
                    text: "female".tr().toString(),
                    style: TextStyleConstant.subText(context, widget.theInitialModel!.data!.account!.mobileAppColors!),
                  ),
                )),
          ],
        );
      },
    );
  }
}
