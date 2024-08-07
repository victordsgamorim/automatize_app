import 'dart:async';

import 'package:automatize_app/core/utils/extensions/iterable_extension.dart';
import 'package:automatize_app/feature/data/repository/client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../model/client.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository _repository;

  ClientBloc(this._repository) : super(const ClientEmpty()) {
    on<GetAllEvent>(_getAllClients);
    on<GetByIdEvent>(_getClientById);
    on<CreateEvent>(_create);
    on<UpdateEvent>(_update);
    on<DeleteByIdEvent>(_deleteClientById);
    on<DeleteAddressByIdEvent>(_deleteAddressById);
    on<DeletePhoneByIdEvent>(_deletePhoneById);
    on<SearchEvent>(_searchClient);
  }

  FutureOr<void> _getAllClients(event, emit) async {
    emit(ClientLoading(clients: state.clients));

    final response = await _repository.getAll();

    response.fold((failure) {
      emit(ClientError(clients: state.clients, message: failure.message));
    }, (clients) {
      emit(ClientSuccess(clients: clients));
    });
  }

  FutureOr<void> _getClientById(event, emit) async {
    emit(ClientLoading(clients: state.clients));
    final response = await _repository.getClientById(event.id);

    response.fold(
      (failure) {
        emit(ClientError(
          message: failure.message,
          clients: state.clients,
        ));
      },
      (client) {
        if (client != null) state.clients[event.index] = client;
        emit(ClientSuccess(clients: state.clients, canProceed: true));
      },
    );
  }

  FutureOr<void> _create(event, emit) async {
    emit(ClientLoading(clients: state.clients));
    final response = await _repository.create(event.client);

    response.fold((failure) {
      emit(ClientError(message: failure.message, clients: state.clients));
    }, (client) {
      int index = state.clients.binarySearch(
        client,
        (a, b) => a.name.compareTo(b.name),
      );
      emit(ClientSuccess(
          clients: state.clients..insert(index, client), canReturn: true));
    });
  }

  FutureOr<void> _update(event, emit) async {
    emit(ClientLoading(clients: state.clients));
    final response = await _repository.update(event.client);
    response.fold((failure) {
      emit(ClientError(message: failure.message, clients: state.clients));
    }, (client) {
      state.clients.remove(event.client);
      int index = state.clients.binarySearch(
        client,
        (a, b) => a.name.compareTo(b.name),
      );
      emit(ClientSuccess(
          clients: state.clients..insert(index, client), canReturn: true));
    });
  }

  FutureOr<void> _deleteClientById(event, emit) async {
    emit(ClientLoading(clients: state.clients));

    final response = await _repository.deleteById(event.id);

    response.fold(
      (failure) => emit(ClientError(
        message: failure.message,
        clients: state.clients,
      )),
      (_) {
        emit(ClientSuccess(clients: state.clients..removeAt(event.index)));
      },
    );
  }

  FutureOr<void> _deleteAddressById(event, emit) async {
    emit(ClientLoading(clients: state.clients));
    final response = await _repository.deleteAddressById(
      clientId: event.client.id,
      addressId: event.addressId,
    );

    response.fold(
      (failure) {
        emit(ClientError(
          message: failure.message,
          clients: state.clients,
        ));
      },
      (client) {
        state.clients.remove(event.client);
        int index = state.clients.binarySearch(
          client,
          (a, b) => a.name.compareTo(b.name),
        );
        emit(ClientSuccess(clients: state.clients..insert(index, client)));
      },
    );
  }

  FutureOr<void> _deletePhoneById(event, emit) async {
    emit(ClientLoading(clients: state.clients));
    final response = await _repository.deletePhoneById(
      clientId: event.client.id,
      phoneId: event.phoneId,
    );

    response.fold(
      (failure) {
        emit(ClientError(
          message: failure.message,
          clients: state.clients,
        ));
      },
      (client) {
        state.clients.remove(event.client);
        int index = state.clients.binarySearch(
          client,
          (a, b) => a.name.compareTo(b.name),
        );
        emit(ClientSuccess(clients: state.clients..insert(index, client)));
      },
    );
  }

  FutureOr<void> _searchClient(event, emit) async {
    final response = await _repository.getAll(search: event.text);

    response.fold((failure) {
      emit(ClientError(clients: state.clients, message: failure.message));
    }, (clients) {
      emit(ClientSuccess(clients: clients));
    });
  }
}
