import 'package:colors_client/core/util/size_utils.dart';
import 'package:colors_client/features/color/domain/repositories/color_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class CreateColorPage extends StatefulWidget {
  final String ownerAddress;

  final ColorRepository _colorRepository;

  const CreateColorPage(this.ownerAddress, this._colorRepository, {Key? key})
      : super(key: key);

  @override
  State<CreateColorPage> createState() => _CreateColorPageState();
}

class _CreateColorPageState extends State<CreateColorPage> {
  final TextEditingController _ammountController =
      TextEditingController(text: '1');
  bool isCreatingColor = false;

  late int red = 0, green = 0, blue = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Text> _colorValues(labelColor) {
    List<Text> colorValues = [];
    for (int i = 0; i < 256; i++) {
      colorValues.add(Text(
        i.toString(),
        style: TextStyle(color: labelColor),
      ));
    }
    return colorValues;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Color',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _picker(
                        SizeUtils.verticalBlockSize * 20,
                        MediaQuery.of(context).size.width / 3.5,
                        red,
                        Colors.red),
                    _picker(
                        SizeUtils.verticalBlockSize * 20,
                        MediaQuery.of(context).size.width / 3.5,
                        green,
                        Colors.green),
                    _picker(
                        SizeUtils.verticalBlockSize * 20,
                        MediaQuery.of(context).size.width / 3.5,
                        blue,
                        Colors.blue),
                  ],
                ))
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: !isCreatingColor
            ? () async {
                setState(() {
                  isCreatingColor = true;
                });
                var result = await widget._colorRepository
                    .mint(widget.ownerAddress, red, green, blue);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result ?? 'Color created!')));
                Navigator.of(context).pop();
              }
            : null,
        child: !isCreatingColor
            ? const Icon(Icons.check)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }

  Widget _picker(height, width, target, labelColor) {
    return SizedBox(
        height: height,
        width: width,
        child: CupertinoPicker(
          itemExtent:
              SizeUtils.verticalBlockSize * (SizeUtils.isTablet() ? 5 : 4),
          useMagnifier: true,
          children: _colorValues(labelColor),
          onSelectedItemChanged: (selectedIndex) {
            target = selectedIndex;
          },
        ));
  }
}
