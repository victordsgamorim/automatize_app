part of 'injector.dart';

void _controllersModule() {
  GetIt.I.registerFactory(() => ClientBloc(GetIt.I()));
}

void _repositoryModule() {
  GetIt.I.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(
        GetIt.I(),
        GetIt.I(),
        GetIt.I(),
        GetIt.I(),
      ));
}

void _daoModule() {
  GetIt.I.registerLazySingleton<ClientDao>(() => ClientDao(GetIt.I()));
}

void _localModule() {
  GetIt.I.registerLazySingleton<UpdateLocalDatasource>(
          () => UpdateLocalDatasourceImpl(GetIt.I()));
}

void _remoteModule() {
  GetIt.I.registerLazySingleton<ClientRemoteDatasource>(
      () => ClientRemoteDatasourceImpl(GetIt.I()));
}

Future<void> _coreModule() async {
  // GetIt.I.registerLazySingleton(() => AppDatabase());
  final db = await getDatabase();
  GetIt.I.registerLazySingleton<Database>(() => db);
  GetIt.I.registerLazySingleton(() => Supabase.instance.client);

  GetIt.I.registerLazySingleton(() => Connectivity());
  GetIt.I.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(GetIt.I()));

  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton(() => sharedPreferences);
}
