import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/models/account_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_repository.g.dart';

/// Singleton for repository
/// `not using class based provider
/// because it's not have the ability to not using build method`
@riverpod
AccountsRepository accountsRepository(AccountsRepositoryRef ref) {
  return AccountsRepository._(ref);
}

class AccountsRepository {
  const AccountsRepository._(this._ref);

  // ignore: unused_field
  final Ref _ref;

  Future<List<AccountModel>> getAll() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      AccountModel.active(
        number: "123456789",
        serviceName: 'MasterCard ISC Branded',
        balance: '1,000,000',
        currency: 'IQD',
        lastUpdate: DateTime.now(),
      ),
      AccountModel.blocked(
        number: "123456789",
        serviceName: 'MasterCard ISC Branded',
        balance: '0',
        currency: 'USD',
        lastUpdate: DateTime.now(),
        reason: 'Blocked by user',
      ),
    ];
  }
}
