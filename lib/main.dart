import 'package:automatize_app/app_widget.dart';
import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/di/injector.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['URL'] ?? "",
    anonKey:dotenv.env['API_KEY'] ?? "",
  );

  setUp();

  runApp(const MyApp());
}
