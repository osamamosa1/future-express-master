import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/auth/cubit/auth_cubit.dart';
import 'package:future_express/modules/auth/screens/JoinServiceProvider/cubit/join_service_provider_cubit.dart';
import 'package:future_express/modules/notification/cubit/notification_cubit.dart';
import 'package:future_express/modules/profile/cubit/profie_cubit.dart';
import 'package:future_express/modules/store/orders/cubit/order_cubit.dart';
import 'package:future_express/modules/store/pickUp/cubit/pickup_cubit.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/user_local.dart';

// import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bloc_observer/bloc_observer.dart';
import 'layouts/cubit/cubit.dart';
import 'modules/home/cubit/home_cubit.dart';
import 'modules/profile/widgets/locale_cubit.dart';
import 'modules/report/cubit/report_cubit.dart';
import 'modules/restaurant_delivery/orders/cubit/order_cubit.dart';
import 'shared/firebase/firebase_options.dart';
import 'shared/firebase/notifications_service.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/palette.dart';
import 'package:path_provider/path_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await NotificationsService().handleFCMNotification();
  debugPrint(fcmToken);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await DioHelper.init();
  await CacheHelper.init();
  print(" in UserLocal ${UserLocal.token}");
  print("CacheHelper.getToken() ${await CacheHelper.getToken()}");
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit()..init(),
        child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AppCubit()),
              BlocProvider(create: (context) => LocaleCubit()),
              BlocProvider(create: (context) => PickupCubit()),
              BlocProvider(create: (context) => OrderCubit()),
              BlocProvider(create: (context) => OrdersRestaurantCubit()),
              BlocProvider(create: (context) => HomeCubit()),
              BlocProvider(create: (context) => NotificationCubit()),
              BlocProvider(create: (context) => JoinServiceProviderCubit()),
              BlocProvider(create: (context) => ProfieCubit()),
              BlocProvider(create: (context) => ReportCubit()),
            ],
            child: BlocBuilder<LocaleCubit, Locale?>(builder: (context, state) {
              return ScreenUtilInit(
                designSize: const Size(800, 1329),
                builder: (BuildContext context, Widget? child) {
                  return MaterialApp.router(
                    title: 'Future Express',
                    routerConfig: router,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                        // textTheme: GoogleFonts.tajawalTextTheme(),
                        dividerColor: Palette.greyColor,
                        primaryColor: Palette.primaryColor,
                        colorScheme: const ColorScheme.light()
                            .copyWith(primary: Palette.primaryColor),
                        scaffoldBackgroundColor: Palette.greyColor.shade100,
                        appBarTheme: const AppBarTheme(
                            backgroundColor: Palette.whiteColor)),
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'),
                      Locale('ar'),
                    ],
                    locale: state,
                  );
                },
              );
            }),
          );
        }));
  }
}
