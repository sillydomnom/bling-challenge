import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../bloc/agify__bloc.dart';
import '../repository/agify_repository.dart';
import '../repository/api/agify_api_client.dart';

class DiProvider {
  late GetIt _diInstance;

  DiProvider() {
    _diInstance = GetIt.asNewInstance();

    _registerGlobalDependencies();
  }

  void register<T extends Object>(T Function(DiProvider) factory) {
    _diInstance.registerLazySingleton<T>(() => factory.call(this));
  }

  T get<T extends Object>() {
    return _diInstance.get<T>();
  }

  void _registerGlobalDependencies() {
    register(
      (provider) => AgifyApiClient(
        httpClient: Client(),
      ),
    );
    register(
      (provider) => AgifyRepository(
        apiClient: provider.get<AgifyApiClient>(),
      ),
    );
    register(
      (provider) => AgifyBloc(
        agifyRepository: provider.get<AgifyRepository>(),
      ),
    );
  }
}

extension DIRetriever on BuildContext {
  T readDependency<T extends Object>() {
    final di = this.read<DiProvider>();

    return di.get<T>();
  }

  DiProvider getDi() {
    return this.read<DiProvider>();
  }
}
