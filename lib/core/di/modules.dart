part of 'injector.dart';

void _controllersModule() {
  GetIt.I.registerFactory(() => ClientCubit(GetIt.I()));
}

void _repositoryModule() {
  GetIt.I.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(
        GetIt.I(),
        GetIt.I(),
      ));
}

void _remoteModule() {
  GetIt.I.registerLazySingleton<ClientRemoteDatasource>(
      () => ClientRemoteDatasourceImpl(GetIt.I()));
}

void _coreModule() {
  GetIt.I.registerLazySingleton(() => Supabase.instance.client);

  GetIt.I.registerLazySingleton(() => Connectivity());
  GetIt.I.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(GetIt.I()));
}
