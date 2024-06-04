import 'package:ekayzoneukapps/apps/views/splash/localization/app_localizations_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apps/bindings/app_bindings.dart';
import 'apps/core/utils/my_theme.dart';
import 'apps/global_widget/firebase_options.dart';
import 'apps/routes/pages.dart';
import 'apps/routes/routes.dart';

late final SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey =
  'pk_test_51LtUkeIH2i6FoGaE6IFfIDMGyP5Tnzm5fT4HM0340Eu8NnufyOmyvqBn14BRihpYaPdUrcVniN3AkmHZPFjLhR8t00QIxImi8s';

  await dotenv.load(fileName: "assets/.env");
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(344, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.theme,
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegate,
          localeResolutionCallback:
          AppLocalizationsSetup.localeResolutionCallBack,
          routingCallback: (routing) {
            if (routing?.current == Routes.initial) {}
          },
          navigatorKey: navigatorKey,
          initialBinding: AppBindings(),
          transitionDuration: const Duration(milliseconds: 300),
          defaultTransition: Transition.cupertino,
          home: child,
          getPages: Pages.pages,
        );
      },
      child: Pages.initial,
    );
  }
}
