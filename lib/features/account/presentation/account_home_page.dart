import 'package:flutter/material.dart';
import 'package:colors_client/core/presentation/widgets/rounded_button.dart';
import 'package:colors_client/core/util/size_utils.dart';
import 'package:colors_client/core/util/utils.dart';

import 'package:colors_client/features/color/domain/repositories/color_repository.dart';

import 'account_owned_colors_page.dart';


class AccountHomePage extends StatelessWidget {
  const AccountHomePage(
      {Key? key, required this.accountAddress, required this.colorRepository})
      : super(key: key);
  final ColorRepository colorRepository;
  final String accountAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selected account',
        ),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.folder_open,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                accountAddress,
                style: const TextStyle(color: Colors.blue),
              )
            ],
          ),
          width: double.infinity,
          height: SizeUtils.verticalBlockSize * 6,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedButton(
                    text: 'Owned Color Tokens',
                    onTap: () => Utils.navigateToPage(
                        context,
                        AccountOwnedColorsPage(
                            address: accountAddress,
                            colorRepository: colorRepository)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ]),
    );
  }
}
