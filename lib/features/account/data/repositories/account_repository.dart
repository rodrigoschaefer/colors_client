import 'dart:math';

import 'package:flutter/material.dart';
import 'package:colors_client/core/util/constants.dart';
import 'package:colors_client/features/account/data/datasources/account_datasource.dart';
import 'package:colors_client/features/account/data/datasources/private_key_datasource.dart';
import 'package:colors_client/features/account/data/models/account.dart';
import 'package:web3dart/web3dart.dart';
import 'package:convert/convert.dart';

class AccountRepository {
  final AccountDatasource _accountDatasource =
      AccountDatasource(Constants.accountBox);

  Account? getAccountByAddress(address) {
    return _accountDatasource.get(address);
  }

  List<Account> getAllAccounts() {
    return _accountDatasource.getAll();
  }

  Future<Account> createRandomAccount() async {
    var rng = Random.secure();
    EthPrivateKey key = EthPrivateKey.createRandom(rng);
    var address = await key.extractAddress();
    PrivateKeyDatasource.store(address.hexEip55, hex.encode(key.privateKey));
    Account acc = Account(address: address.hexEip55, balanceWei: 0);
    _accountDatasource.store(acc);
    return acc;
  }

  Future<Account> importAccount(String pKey) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(pKey);
    var address = await credentials.extractAddress();
    PrivateKeyDatasource.store(
        address.hexEip55, hex.encode(credentials.privateKey));
    Account acc = Account(address: address.hexEip55, balanceWei: 0);
    _accountDatasource.store(acc);
    return acc;
  }

  void deleteAccount(address) {
    try {
      _accountDatasource.delete(address);
      PrivateKeyDatasource.delete(address);
    } catch (e) {
      debugPrint('Error deleting account');
    }
  }
}
