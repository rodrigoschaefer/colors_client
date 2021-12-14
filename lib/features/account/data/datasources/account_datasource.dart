import 'package:hive_flutter/hive_flutter.dart';
import 'package:colors_client/features/account/data/models/account.dart';

class AccountDatasource {
  late Box<Account> accountBox;

  AccountDatasource(box) {
    accountBox = Hive.box<Account>(box);
  }

  List<Account> getAll() {
    List<Account> accounts = [];
    for (var e in accountBox.values) {
      accounts.add(e);
    }
    return accounts;
  }

  void store(Account acc) {
    accountBox.put(acc.address, acc);
  }

  Account? get(String address) {
    return accountBox.get(address);
  }

  void delete(address) {
    accountBox.delete(address);
  }
}
