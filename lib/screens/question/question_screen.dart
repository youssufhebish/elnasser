import 'package:easy_localization/src/public_ext.dart';
import 'package:elnasser/constants/test_style_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/question/question_bloc/question_state.dart';
import 'package:elnasser/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

import 'question_bloc/question_cubit.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen(
      {Key? key, required this.colorsValue, required this.title})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: CustomText(
              text: "${title}".tr().toString(),
              style: TextStyleConstant.headerText(context, colorsValue),
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
            child: Column(
              children: [
                BlocBuilder<QuestionCubit, QuestionState>(
                    builder: (context, state) {
                  if (state is QuestionStateSuccess) {
                    return ListView.builder(
                        itemCount: QuestionCubit.get(context)
                            .questionsModel
                            .data!
                            .questions!
                            .length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: .5),
                                  borderRadius: BorderRadius.circular(6)),
                              child: ExpansionTile(
                                title: CustomText(
                                  text:
                                      "${QuestionCubit.get(context).questionsModel.data!.questions![index].questionsQuestion}",
                                  style: TextStyleConstant.bodyTextMainColor(
                                      context, colorsValue),
                                ),
                                children: [
                                  Html(
                                    data: QuestionCubit.get(context)
                                            .questionsModel
                                            .data!
                                            .questions![index]
                                            .questionsAnswer ??
                                        "",
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return SizedBox(
                      height: 90.h,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
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
