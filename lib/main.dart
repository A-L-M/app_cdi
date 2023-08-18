import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'provider/providers.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: anonKey,
  );

  await initGlobals();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DatosPersonalesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CDI2Provider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsuariosProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VisualStateProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('es');
  ThemeMode _themeMode = AppTheme.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        AppTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CDI',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('en', 'US')],
      theme: ThemeData(
        brightness: Brightness.light,
        dividerColor: Colors.grey,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        dividerColor: Colors.grey,
      ),
      themeMode: _themeMode,
      routerConfig: router,
    );
  }
}
