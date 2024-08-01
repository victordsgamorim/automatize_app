part of 'client_cubit.dart';

@immutable
sealed class ClientState {
  final List<Client> clients;

  const ClientState({required this.clients});
}

final class ClientEmpty extends ClientState with EquatableMixin {
  const ClientEmpty() : super(clients: const []);

  @override
  List<Object?> get props => [clients];
}

final class ClientLoading extends ClientState with EquatableMixin {
  const ClientLoading({required super.clients});

  @override
  List<Object?> get props => [clients];
}

final class ClientSuccess extends ClientState {
  const ClientSuccess({required super.clients});
}

final class ClientError extends ClientState with EquatableMixin {
  final String message;

  const ClientError({
    required this.message,
    required super.clients,
  });

  @override
  List<Object?> get props => [message, clients];
}
