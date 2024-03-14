import 'package:compression/home.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(500, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle =
        TextStyle(color: Colors.black);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        textTheme: TextTheme(
          displayLarge: defaultTextStyle.copyWith(
              fontSize: 96, fontWeight: FontWeight.w300),
          displayMedium: defaultTextStyle.copyWith(
              fontSize: 60, fontWeight: FontWeight.w400),
          displaySmall: defaultTextStyle.copyWith(
              fontSize: 48, fontWeight: FontWeight.w400),
          headlineMedium: defaultTextStyle.copyWith(
              fontSize: 34, fontWeight: FontWeight.w400),
          headlineSmall: defaultTextStyle.copyWith(
              fontSize: 24, fontWeight: FontWeight.w400),
          titleLarge: defaultTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.w500),
          titleMedium: defaultTextStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w500),
          bodyLarge: defaultTextStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.w400),
          bodyMedium: defaultTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: defaultTextStyle.copyWith(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
          labelLarge: defaultTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

