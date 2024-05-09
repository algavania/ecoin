import 'package:ecoin/core/app_text_styles.dart';
import 'package:ecoin/core/app_theme_data.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/firebase_options.dart';
import 'package:ecoin/injector/injector.dart';
import 'package:ecoin/routes/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import 'database/shared_preferences_service.dart';

final appRouter = AppRouter();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Injector.init();
  await Injector.instance.allReady();
  await SharedPreferencesService.init();
  await Future<void>.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return AppTheme(
          textTheme: AppTextStyles.style(context),
          child: GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidgetBuilder: (_) => const Center(
              child: SpinKitChasingDots(
                size: 50,
                color: ColorValues.primary50,
              ),
            ),
            child: MaterialApp.router(
              theme: ecoinThemeData(context),
              routerDelegate: appRouter.delegate(),
              routeInformationParser: appRouter.defaultRouteParser(),
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
    );
  }
}
