import 'package:automatize_app/feature/model/client.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _timeoutDuration = Duration(seconds: 5);

abstract interface class ClientRemoteDatasource {
  Future<List<Client>> getAllByDate({DateTime? from});

  Future<Client?> getClientById(String id);

  Future<Client> insert(Client client);

  Future<Client> update(Client client);

  Future<String> deleteById(String id);

  Future<Client> deleteAddressById({
    required String clientId,
    required String addressId,
  });

  Future<Client> deletePhoneById({
    required String clientId,
    required String phoneId,
  });
}

final class ClientRemoteDatasourceImpl implements ClientRemoteDatasource {
  final SupabaseClient _client;

  const ClientRemoteDatasourceImpl(this._client);

  @override
  Future<List<Client>> getAllByDate({DateTime? from}) async {
    PostgrestFilterBuilder<PostgrestList> response =
        _client.from("clients").select('*, addresses(*), phones(*)');

    if (from != null) {
      response = response.gte("updated_at", from.toIso8601String());
    }

    return (await response)
        .map<Client>((client) => Client.fromMap(client))
        .toList();
  }

  @override
  Future<Client?> getClientById(String id) async {
    final response = await _client
        .from("clients")
        .select('*, addresses(*), phones(*)')
        .eq('id', id)
        .single()
        .timeout(_timeoutDuration);

    return Client.fromMap(response);
  }

  @override
  Future<Client> insert(Client client) async {
    final clientResponse = await _client
        .from("clients")
        .insert(client.toMap())
        .select()
        .single()
        .timeout(_timeoutDuration);
    final addressResponse = await _client
        .from("addresses")
        .insert(client.addresses
            .map((address) => address.toMap(client.id))
            .toList())
        .select()
        .timeout(_timeoutDuration);
    final phonesResponse = await _client
        .from("phones")
        .insert(client.phones.map((phone) => phone.toMap(client.id)).toList())
        .select()
        .timeout(_timeoutDuration);

    clientResponse
      ..putIfAbsent("addresses", () => addressResponse)
      ..putIfAbsent("phones", () => phonesResponse);

    return Client.fromMap(clientResponse);
  }

  @override
  Future<Client> update(Client client) async {
    final addressResponse = await _client
        .from("addresses")
        .upsert(client.addresses
            .map((address) => address.toMap(client.id))
            .toList())
        .select()
        .timeout(_timeoutDuration);

    final phonesResponse = await _client
        .from("phones")
        .upsert(client.phones.map((phone) => phone.toMap(client.id)).toList())
        .select()
        .timeout(_timeoutDuration);

    final clientResponse = await _client
        .from("clients")
        .update(client.toMap())
        .eq("id", client.id)
        .select()
        .single()
        .timeout(_timeoutDuration);

    clientResponse
      ..putIfAbsent("addresses", () => addressResponse)
      ..putIfAbsent("phones", () => phonesResponse);

    return Client.fromMap(clientResponse);
  }

  @override
  Future<String> deleteById(String id) async {
    await _client.from("clients").update({
      "is_active": false,
      "updated_at": DateTime.now().toIso8601String(),
    }).eq("id", id);
    return id;
  }

  @override
  Future<Client> deleteAddressById(
      {required String clientId, required String addressId}) async {
    await _client.from("addresses").update({
      "is_active": false,
    }).eq("id", addressId);

    final response = await _client
        .from("clients")
        .update({"updated_at": DateTime.now().toIso8601String()})
        .eq("id", clientId)
        .select('*, addresses(*), phones(*)')
        .single();

    return Client.fromMap(response);
  }

  @override
  Future<Client> deletePhoneById({
    required String clientId,
    required String phoneId,
  }) async {
    await _client.from("phones").update({
      "is_active": false,
    }).eq("id", phoneId);

    final response = await _client
        .from("clients")
        .update({"updated_at": DateTime.now().toIso8601String()})
        .eq("id", clientId)
        .select('*, addresses(*), phones(*)')
        .single();

    return Client.fromMap(response);
  }
}
