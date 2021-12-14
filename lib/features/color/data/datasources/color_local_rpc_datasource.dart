import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:colors_client/core/util/constants.dart';
import 'package:colors_client/features/color/data/models/color.dart';
import 'package:web3dart/web3dart.dart';

abstract class ColorDatasource {
  Future<List<Color>> getColorsByOwner(ownerAddress);
}

class ColorLocalRpcDatasource implements ColorDatasource {
  late Client httpClient;
  late Web3Client ethClient;
  late EthereumAddress contractAddress;
  late DeployedContract contract;
  late ContractFunction getColorsByOwnerFunction;
  String rpcUrl = Constants.rpcUrl;

  ColorLocalRpcDatasource() {
    httpClient = Client();
    ethClient = Web3Client(rpcUrl, httpClient);
    contractAddress =
        EthereumAddress.fromHex(Constants.colorsContractAddress);
    init();
  }

  init() async {
    String abi = await rootBundle.loadString('lib/abis/Colors.abi.json');
    contract = DeployedContract(
        ContractAbi.fromJson(abi, "Colors"), contractAddress);
    getColorsByOwnerFunction = contract.function('colors');
  }

  @override
  Future<List<Color>> getColorsByOwner(ownerAddress) async {
    var data = await ethClient.call(
        contract: contract,
        function: getColorsByOwnerFunction,
        params: [EthereumAddress.fromHex(ownerAddress)]);
    List<Color> colors = [];
    for (List<dynamic> fields in data[0]) {
      colors.add(Color.fromBlockchain(fields));
    }
    return colors;
  }

}
