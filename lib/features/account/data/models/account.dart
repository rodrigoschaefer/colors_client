import 'package:hive_flutter/hive_flutter.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account {
  @HiveField(0)
  String address;
  @HiveField(1)
  int balanceWei;
  Account({required this.address, required this.balanceWei});
}
