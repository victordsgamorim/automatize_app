part of 'client_bloc.dart';

@immutable
sealed class ClientState {
  final bool isLoading;
  final List<Client> clients;
  final String? message;

  const ClientState({
    required this.clients,
    this.isLoading = false,
    this.message,
  });
}

final class ClientEmpty extends ClientState {
  const ClientEmpty() : super(clients: const []);
}

final class ClientLoaded extends ClientState {
  const ClientLoaded({required super.clients, super.isLoading, super.message});
}
