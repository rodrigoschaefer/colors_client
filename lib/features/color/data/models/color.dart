import 'package:web3dart/credentials.dart';

class Color {
  int? id;
  String ownerAddress;
  String rgb;
  Color(
      {this.id,
      required this.ownerAddress,
      required this.rgb});

  factory Color.fromBlockchain(List<dynamic> fields) {
    return Color(
        id: (fields[0] as BigInt).toInt(),
        ownerAddress: (fields[1] as EthereumAddress).hexEip55,
        rgb: fields[2]
        );
  }
}
