import 'package:automatize_app/feature/data/repository/client_repository.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final ClientRepository _repository;

  ClientCubit(this._repository) : super(const ClientEmpty());

  void load() async {
    emit(ClientLoading(clients: state.clients));
    final response = await _repository.getAll();
    response.fold(
      (failure) =>
          emit(ClientError(message: failure.message, clients: state.clients)),
      (clients) {
        emit(ClientSuccess(clients: clients));
      },
    );
  }

  void insert(Client client) async {
    final response = await _repository.insert(client);
  }
}
