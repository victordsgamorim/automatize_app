part of 'client_bloc.dart';

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

final class ClientSuccess extends ClientState with EquatableMixin {
  final bool canProceed;
  final bool canReturn;
  final bool showDeleteAddressMessage;
  final bool showDeletePhoneMessage;

  const ClientSuccess({
    required super.clients,
    this.canProceed = false,
    this.canReturn = false,
    this.showDeleteAddressMessage = false,
    this.showDeletePhoneMessage = false,
  });

  @override
  List<Object?> get props => [
        clients,
        canProceed,
        canReturn,
        showDeleteAddressMessage,
        showDeletePhoneMessage,
      ];
}

final class ClientError extends ClientState with EquatableMixin {
  final String message;

  const ClientError({
    required super.clients,
    required this.message,
  });

  @override
  List<Object?> get props => [clients, message];
}
