part of 'client_bloc.dart';

@immutable
sealed class ClientEvent extends Equatable {
  const ClientEvent();
}

final class WatchAllClientsEvent extends ClientEvent {
  const WatchAllClientsEvent();

  @override
  List<Object?> get props => [];
}

final class CreateClientEvent extends ClientEvent {
  final Client client;

  const CreateClientEvent(this.client);

  @override
  List<Object?> get props => [client];
}

final class UpdateClientEvent extends ClientEvent {
  final Client client;

  const UpdateClientEvent(this.client);

  @override
  List<Object?> get props => [client];
}

final class DeleteClientByIdEvent extends ClientEvent {
  final String id;

  const DeleteClientByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

final class DeleteAddressByIdEvent extends ClientEvent {
  final String id;

  const DeleteAddressByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

final class DeletePhoneByIdEvent extends ClientEvent {
  final String id;

  const DeletePhoneByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}
