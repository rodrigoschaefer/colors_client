// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:colors_client/core/presentation/widgets/rounded_button.dart';
import 'package:colors_client/core/util/size_utils.dart';


class ColorItem extends StatelessWidget {
  final BigInt id;
  final String ownerAddress;
  final String rgb;

  const ColorItem(
      {key, required this.id, required this.ownerAddress, required this.rgb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize),
      child: Column(
        children: [
          ClipOval(
              child: Container(
            height: SizeUtils.horizontalBlockSize * 30,
            width: SizeUtils.horizontalBlockSize * 30,
            color: Color.fromARGB(
                255,
                int.parse(rgb.substring(0, 2), radix: 16),
                int.parse(rgb.substring(2, 4), radix: 16),
                int.parse(rgb.substring(4, 6), radix: 16)),
          )),
          Card(
              child: Padding(
                  padding: EdgeInsets.all(SizeUtils.horizontalBlockSize),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text(
                                'Id:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text(
                                'rgb:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              id.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 3),
                            ),
                            Text(
                              rgb,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 3),
                            ),
                          ],
                        ),
                      ]))),
        ],
      ),
    );
  }

  _dialog(context, message, onYes) {
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
            title: Text(message, style: const TextStyle(color: Colors.blue)),
            actions: [
              RoundedButton(
                text: 'Yes',
                backgroundColor: Colors.lightBlueAccent,
                onTap: () {
                  Navigator.pop(context);
                  onYes();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              RoundedButton(
                  text: 'Cancel',
                  backgroundColor: Colors.lightBlueAccent,
                  onTap: () {
                    Navigator.pop(context);
                  })
            ]);
      },
    );
  }
}
