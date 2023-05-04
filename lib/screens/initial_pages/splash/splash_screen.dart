import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/constants/size_data.dart';
import 'package:elnasser/helpers/connection_bloc/connection_cubit.dart';
import 'package:elnasser/helpers/connection_bloc/connection_state.dart';
import 'package:elnasser/screens/home_mop/home_mop_bloc/home_mobil_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_bloc/home_cubit.dart';
import 'package:elnasser/screens/home_page_screen/home_ui/home_screen.dart';
import 'package:elnasser/screens/initial_pages/login/login_screen.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_state.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_bloc_state.dart';
import 'package:elnasser/screens/offers/offer_bloc/offer_event.dart';
import 'package:elnasser/widget/no_internet_widget.dart';
import 'package:elnasser/widget/no_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    SplashCubit.get(context).getInitial(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionCubit, InternetState>(
        builder: (context, state) {
      if (state is InternetDisconnectedState) {
        return NoInterNetWidget();
      } else {
        return BlocConsumer<SplashCubit, SplashState>(
            builder: (context, state) {
          print(state);
          if (state is SplashSuccess) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeDataConstant.customWidth(context, 2),
                    child: Center(
                      child: Image.asset(
                        ImageConstants.blueLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is SplashLoading) {
            return Container(
              color: Colors.white,
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: SizeDataConstant.customWidth(context, 2),
                        child: Image.asset(
                          ImageConstants.blueLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is SplashShared) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: SizeDataConstant.customWidth(context, 2),
                      child: Image.asset(
                        ImageConstants.blueLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is SplashGetAppData) {
            return Container(
              color: Colors.white,
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: SizeDataConstant.customWidth(context, 2),
                        child: Image.asset(
                          ImageConstants.blueLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Scaffold(
                body: Center(
                  child: Text(""),
                ),
              ),
            );
          }
        }, listener: (context, state) {
          if (state is SplashSuccess) {
            // SplashCubit.get(context).isUserLogin == true ?
            //  HomeCubit.get(context).getCurrentLanguage(context);
            SplashCubit.get(context).getAppData(context: context);

            // :  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  LoginPage(theInitialModel: SplashCubit.get(context).theInitialModel)));
          }
          if (state is SplashGetAppData) {
            if (SplashCubit.get(context)
                    .theInitialModel
                    .data!
                    .setting!
                    .websiteStatus ==
                "1") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageScreen(
                          theInitialModel:
                              SplashCubit.get(context).theInitialModel)));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebSiteStop(
                            mesg: SplashCubit.get(context)
                                .theInitialModel
                                .data!
                                .setting!
                                .stopWebsiteMsg,
                          )));
            }
          }
          if (state is SplashFailure) {
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomePageScreen(theInitialModel: SplashCubit.get(context).theInitialModel)));
          }
        });
      }
    }, listener: (context, state) {
      if (state is InternetConnectedState) {
        // print('InternetConnectedState $state');
      }
    });
  }
}
