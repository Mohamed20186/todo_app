import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/conf/page_route_name.dart';
import 'package:todo_app/core/conf/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/core/services/loading_service.dart';
import 'package:todo_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:todo_app/features/settings/manager/localization_cubit/localization_cubit.dart';
import 'package:todo_app/features/settings/manager/theme_cubit/theme_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
      Locale('fr'),
      Locale('ru')
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('ar'),
    child: const MyApp(),
  ));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationCubit>(
            create: (context) => LocalizationCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            initialRoute: PageRouteName.initial,
            onGenerateRoute: RouteGenerator.onGenerateRoute,
            title: 'Todo app',
            theme: theme,
            builder: EasyLoading.init(
              builder: BotToastInit(),
            ),
          );
        },
      ),
    );
  }
}
