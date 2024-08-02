import 'package:automatize_app/core/error/failure.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ClientRemoteDatasource {
  Future<List<Client>> getAll();

  Future<Client> insert(Client client);

  Future<Client> update(Client client);
}

final class ClientRemoteDatasourceImpl implements ClientRemoteDatasource {
  final SupabaseClient _client;

  const ClientRemoteDatasourceImpl(this._client);

  @override
  Future<List<Client>> getAll() async {
    final response =
        await _client.from("clients").select('*, addresses(*), phones(*)');
    return response.map<Client>((client) => Client.fromMap(client)).toList();
  }

  @override
  Future<Client> insert(Client client) async {
    try {
      final clientResponse = await _client
          .from("clients")
          .insert(client.toMap())
          .select()
          .single();
      final addressResponse = await _client
          .from("addresses")
          .insert(client.addresses
              .map((address) => address.toMap(client.id))
              .toList())
          .select();
      final phonesResponse = await _client
          .from("phones")
          .insert(client.phones.map((phone) => phone.toMap(client.id)).toList())
          .select();

      clientResponse
        ..putIfAbsent("addresses", () => addressResponse)
        ..putIfAbsent("phones", () => phonesResponse);

      return Client.fromMap(clientResponse);
    } on PostgrestException catch (e) {
      throw const ServerFailure(message: "Server Error");
    }
  }

  @override
  Future<Client> update(Client client) async {
    try {
      final clientResponse = await _client
          .from("clients")
          .update(client.toMap())
          .eq("id", client.id)
          .select()
          .single();
      final addressResponse = await _client
          .from("addresses")
          .upsert(client.addresses
              .map((address) => address.toMap(client.id))
              .toList())
          .select();
      final phonesResponse = await _client
          .from("phones")
          .upsert(client.phones.map((phone) => phone.toMap(client.id)).toList())
          .select();

      clientResponse
        ..putIfAbsent("addresses", () => addressResponse)
        ..putIfAbsent("phones", () => phonesResponse);

      return Client.fromMap(clientResponse);
    } on PostgrestException catch (e) {
      throw const ServerFailure(message: "Server Error");
    }
  }
}
