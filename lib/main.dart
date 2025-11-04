import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_intent.dart';
import 'package:fitness_app/fitness_app.dart';
import 'package:fitness_app/my_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  await configureDependencies();
  await getIt<GlobalCubit>().doIntent(intent: GlobalInitializationIntent());
  runApp(
    BlocProvider<GlobalCubit>(
      create: (context) =>
      getIt.get<GlobalCubit>()
        ..doIntent(intent: GlobalInitializationIntent()),
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const FitnessApp(),
      ),
    ),
  );
}
