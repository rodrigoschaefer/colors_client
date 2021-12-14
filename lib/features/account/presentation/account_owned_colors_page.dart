import 'package:flutter/material.dart';

import 'package:colors_client/core/util/size_utils.dart';

import 'package:colors_client/features/color/data/models/color.dart';
import 'package:colors_client/features/color/domain/repositories/color_repository.dart';
import 'package:colors_client/features/color/presentation/widgets/color_item.dart';

class AccountOwnedColorsPage extends StatefulWidget {
  final String address;
  final ColorRepository colorRepository;

  // ignore: use_key_in_widget_constructors
  const AccountOwnedColorsPage(
      {required this.address, required this.colorRepository});

  @override
  State<AccountOwnedColorsPage> createState() => _AccountOwnedColorsPageState();
}

class _AccountOwnedColorsPageState extends State<AccountOwnedColorsPage> {
  List<Color>? colorsList = [];
  late bool isFetchingTokens;

  @override
  void initState() {
    super.initState();
    _fetchColors();
  }

  _fetchColors() async {
    setState(() {
      isFetchingTokens = true;
    });
    try {
      colorsList = await widget.colorRepository.getColorsByOwner(widget.address);
    } catch (e) {
      colorsList = null;
    }
    setState(() {
      isFetchingTokens = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Owned Colors',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
              child: isFetchingTokens
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : colorsList != null
                      ? colorsList!.isEmpty
                          ? const Text('No tokens found')
                          : ListView.builder(
                              shrinkWrap: false,
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeUtils.verticalBlockSize * 1),
                              itemCount: colorsList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ColorItem(
                                  id: BigInt.one,
                                  ownerAddress: '0000000',
                                  rgb: 'FF00FF',
                                );
                              })
                      : const Text(
                          'Error loading owned colors',
                          style: TextStyle(color: Colors.red),
                        ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
