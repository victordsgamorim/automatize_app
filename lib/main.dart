import 'dart:io';

import 'package:automatize_app/app_widget.dart';
import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/di/injector.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['URL'] ?? "",
    anonKey:dotenv.env['API_KEY'] ?? "",
  );

  // final dir = await getApplicationDocumentsDirectory();
  // final file = File(path.join(dir.path, 'automatize.db'));
  // if(await file.exists()){
  //   await file.delete();
  // }

  await setUp();
  runApp(const MyApp());
}
