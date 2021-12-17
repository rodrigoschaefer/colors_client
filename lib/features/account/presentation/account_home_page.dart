import 'package:colors_client/features/color/data/models/color_model.dart';
import 'package:colors_client/features/color/presentation/create_color_page.dart';
import 'package:colors_client/features/color/presentation/widgets/color_item.dart';
import 'package:flutter/material.dart';
import 'package:colors_client/core/util/size_utils.dart';
import 'package:colors_client/core/util/utils.dart';
import 'package:colors_client/features/color/domain/repositories/color_repository.dart';

class AccountHomePage extends StatefulWidget {
  const AccountHomePage(
      {Key? key, required this.accountAddress, required this.colorRepository})
      : super(key: key);
  final ColorRepository colorRepository;
  final String accountAddress;

  @override
  State<AccountHomePage> createState() => _AccountHomePageState();
}

class _AccountHomePageState extends State<AccountHomePage> {
  late List<ColorModel> colors;
  bool isCreatingColor = false;

  @override
  void initState() {
    super.initState();
    colors = [];
  }

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
                color: Colors.green,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.accountAddress,
                style: const TextStyle(color: Colors.green),
              )
            ],
          ),
          width: double.infinity,
          height: SizeUtils.verticalBlockSize * 6,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.verticalBlockSize * 1),
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ColorItem(
                    id: colors[index].id!,
                    ownerAddress: widget.accountAddress,
                    rgb: 'FFFFFF',
                  );
                },
              )),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Utils.navigateToPage(context,
              CreateColorPage(widget.accountAddress, widget.colorRepository));
        },
        child: !isCreatingColor
            ? const Icon(Icons.check)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}
