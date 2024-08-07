part of 'client_bloc.dart';

@immutable
sealed class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllEvent extends ClientEvent {
  const GetAllEvent();
}

final class CreateEvent extends ClientEvent {
  final Client client;

  const CreateEvent(this.client);

  @override
  List<Object?> get props => [client];
}

final class UpdateEvent extends ClientEvent {
  final Client client;

  const UpdateEvent(this.client);

  @override
  List<Object?> get props => [client];
}

final class DeleteByIdEvent extends ClientEvent {
  final String id;
  final int index;

  const DeleteByIdEvent({
    required this.id,
    required this.index,
  });

  @override
  List<Object?> get props => [id, index];
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

final class GetByIdEvent extends ClientEvent {
  final int index;
  final String id;

  const GetByIdEvent({
    required this.id,
    required this.index,
  });

  @override
  List<Object?> get props => [id, index];
}

final class SearchEvent extends ClientEvent {
  final String text;

  const SearchEvent(this.text);

  @override
  List<Object?> get props => [text];
}
