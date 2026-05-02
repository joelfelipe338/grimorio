import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/spell_list_screen.dart';
import 'theme/app_theme.dart';
import 'utils/app_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const GrimorioApp());
}

class GrimorioApp extends StatelessWidget {
  const GrimorioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grimorio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.gold,
        ),
      ),
      builder: (context, child) {
        return ValueListenableBuilder<double>(
          valueListenable: AppSettings.fontScale,
          builder: (context, scale, _) {
            final mq = MediaQuery.of(context);
            return MediaQuery(
              data: mq.copyWith(textScaler: TextScaler.linear(scale)),
              child: child!,
            );
          },
        );
      },
      home: const SpellListScreen(),
    );
  }
}
