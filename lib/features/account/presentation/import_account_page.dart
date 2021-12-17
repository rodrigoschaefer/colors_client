import 'package:flutter/material.dart';
import 'package:colors_client/core/presentation/widgets/rounded_button.dart';
import 'package:colors_client/features/account/data/repositories/account_repository.dart';

class ImportAccountPage extends StatelessWidget {
  final AccountRepository accountRepository;
  ImportAccountPage({Key? key, required this.accountRepository})
      : super(key: key);

  final TextEditingController _pKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Enter the private key',
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _pKeyController,
                style: const TextStyle(color: Colors.green, fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.all(30),
                  child: RoundedButton(
                    text: 'Import account',
                    onTap: () async {
                      await accountRepository
                          .importAccount(_pKeyController.text);
                      Navigator.pop(context);
                    },
                  ))
            ]),
      ),
    );
  }
}
