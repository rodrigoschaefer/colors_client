import 'package:flutter/material.dart';
import 'package:colors_client/core/presentation/widgets/rounded_button.dart';
import 'package:colors_client/core/util/size_utils.dart';

class AccountItem extends StatelessWidget {
  final String address;
  final VoidCallback onTapDelete;
  final VoidCallback onTapAddress;

  // ignore: use_key_in_widget_constructors
  const AccountItem(
      {required this.address,
      required this.onTapAddress,
      required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Flexible(
                  child: InkWell(
                child: Text(address,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: onTapAddress,
              )),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  size: SizeUtils.horizontalBlockSize * 8,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                          scrollable: true,
                          actionsOverflowDirection: VerticalDirection.down,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          title: const Text(
                            'Are you sure you want to delete this wallet? This cannot be reversed!',
                            style: TextStyle(color: Colors.blue),
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          actions: [
                            RoundedButton(
                              text: 'Yes',
                              backgroundColor: Colors.lightBlue,
                              onTap: onTapDelete,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RoundedButton(
                                text: 'Cancel',
                                backgroundColor: Colors.lightBlue,
                                onTap: () {
                                  Navigator.pop(context);
                                })
                          ]);
                    },
                  );
                },
              ),
            ],
          )),
    );
  }
}
