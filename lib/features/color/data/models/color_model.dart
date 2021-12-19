import 'package:web3dart/credentials.dart';

class ColorModel {
  BigInt? id;
  String ownerAddress;
  String rgb;
  ColorModel({this.id, required this.ownerAddress, required this.rgb});

  factory ColorModel.fromBlockchain(List<dynamic> fields) {
    return ColorModel(
        id: fields[0] as BigInt,
        ownerAddress: (fields[1] as EthereumAddress).hexEip55,
        rgb: fields[2]);
  }

}
