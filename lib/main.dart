import 'package:flutter/material.dart';
import 'package:my_weather/di/di.dart';
import 'package:my_weather/presentation/screen/daily_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  setup();
  await dotenv.load(fileName: ".env"); // โหลดไฟล์ .env
  runApp(
    const ProviderScope(   // <<< ต้องมีตรงนี้
      child: AppNavHost(),
    ),
  );
}


class AppNavHost extends StatelessWidget {
  const AppNavHost({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue, // สีหลัก
          scaffoldBackgroundColor: Colors.grey[200], // พื้นหลังของทุกหน้า
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        home: const DailyScreen(title: 'Flutter Demo Home'));
  }
}