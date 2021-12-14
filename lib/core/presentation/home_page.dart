import 'package:flutter/material.dart';
import 'package:colors_client/core/presentation/widgets/account_item.dart';
import 'package:colors_client/core/util/size_utils.dart';
import 'package:colors_client/core/util/utils.dart';

import 'package:colors_client/features/account/data/models/account.dart';
import 'package:colors_client/features/account/data/repositories/account_repository.dart';
import 'package:colors_client/features/account/presentation/account_home_page.dart';
import 'package:colors_client/features/account/presentation/import_account_page.dart';
import 'package:colors_client/features/color/domain/repositories/color_repository.dart';

class HomePage extends StatefulWidget {
  final ColorRepository colorRepository;
  const HomePage({Key? key, required this.colorRepository}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AccountRepository _accountRepository = AccountRepository();

  List<Account> accounts = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _accountRepository = AccountRepository();
    accounts = _accountRepository.getAllAccounts();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils.init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accounts',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.verticalBlockSize * 1),
              itemCount: accounts.length,
              itemBuilder: (BuildContext context, int index) {
                return AccountItem(
                  address: accounts[index].address,
                  onTapAddress: () {
                    Utils.navigateToPage(
                        context,
                        AccountHomePage(
                          accountAddress: accounts[index].address,
                          colorRepository: widget.colorRepository,
                        ));
                  },
                  onTapDelete: () {
                    Navigator.pop(context);
                    setState(() {
                      _accountRepository.deleteAccount(accounts[index].address);
                      accounts = _accountRepository.getAllAccounts();
                    });
                  },
                );
              },
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Utils.navigateToPage(
              context,
              ImportAccountPage(
                accountRepository: _accountRepository,
              ));
          setState(() {
            accounts = _accountRepository.getAllAccounts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
