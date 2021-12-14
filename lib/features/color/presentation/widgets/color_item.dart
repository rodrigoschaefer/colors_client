// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:colors_client/core/presentation/widgets/rounded_button.dart';
import 'package:colors_client/core/util/size_utils.dart';
import 'package:colors_client/core/util/utils.dart';

class ColorItem extends StatelessWidget {
  final BigInt id;
  final String ownerAddress;
  final String rgb;
  
  const ColorItem(
      {
      key,required this.id,required this.ownerAddress,required this.rgb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            'Owner:',
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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ownerAddress,
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
                    )
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                ],
              )
            ],
          )),
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
