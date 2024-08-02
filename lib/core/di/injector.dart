import 'package:automatize_app/core/database/app_database.dart';
import 'package:automatize_app/core/database/dao/client_dao.dart';
import 'package:automatize_app/core/network/network_info.dart';
import 'package:automatize_app/feature/data/datasource/local/client_local_datasource.dart';
import 'package:automatize_app/feature/data/datasource/remote/client_remote_datasource.dart';
import 'package:automatize_app/feature/data/repository/client_repository.dart';
import 'package:automatize_app/feature/ui/controllers/client/client_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'modules.dart';

void setUp() {
  _controllersModule();
  _repositoryModule();
  _daoModule();
  _localModule();
  _remoteModule();
  _coreModule();
}
