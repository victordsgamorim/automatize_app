import 'dart:async';

import 'package:automatize_app/feature/data/repository/client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../model/client.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository _repository;

  ClientBloc(this._repository) : super(const ClientEmpty()) {
    on<WatchAllClientsEvent>(_watchClients);
    on<CreateClientEvent>(_create);
    on<UpdateClientEvent>(_update);
    on<DeleteClientByIdEvent>(_deleteClientById);
    on<DeleteAddressByIdEvent>(_deleteAddressById);
    on<DeletePhoneByIdEvent>(_deletePhoneById);
  }

  FutureOr<void> _watchClients(event, emit) async {
    emit(const ClientLoaded(clients: [], isLoading: true));
    final response = await _repository.getAll();
    response.fold(
      (failure) => emit(ClientLoaded(message: failure.message, clients: [])),
      (clients) {
        emit(ClientLoaded(clients: clients));
      },
    );
  }

  FutureOr<void> _create(event, emit) {}

  FutureOr<void> _update(event, emit) {}

  FutureOr<void> _deleteClientById(event, emit) {}

  FutureOr<void> _deleteAddressById(event, emit) {}

  FutureOr<void> _deletePhoneById(event, emit) {}
}
