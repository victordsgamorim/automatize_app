part of 'injector.dart';

void _controllersModule() {
  GetIt.I.registerFactory(() => ClientBloc(GetIt.I()));
}

void _repositoryModule() {
  GetIt.I.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(
        GetIt.I(),
        GetIt.I(),
        GetIt.I(),
      ));
}

void _daoModule() {
  GetIt.I.registerLazySingleton<ClientDao>(() => ClientDao(GetIt.I()));
  GetIt.I.registerLazySingleton<AddressDao>(() => AddressDao(GetIt.I()));
  GetIt.I.registerLazySingleton<PhoneDao>(() => PhoneDao(GetIt.I()));
}

void _localModule() {
  GetIt.I.registerLazySingleton<ClientLocalDatasource>(
      () => ClientLocalDatasourceImpl(
            GetIt.I(),
            GetIt.I(),
            GetIt.I(),
          ));
}

void _remoteModule() {
  GetIt.I.registerLazySingleton<ClientRemoteDatasource>(
      () => ClientRemoteDatasourceImpl(GetIt.I()));
}

void _coreModule() {
  GetIt.I.registerLazySingleton(() => AppDatabase());
  GetIt.I.registerLazySingleton(() => Supabase.instance.client);

  GetIt.I.registerLazySingleton(() => Connectivity());
  GetIt.I.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(GetIt.I()));
}
