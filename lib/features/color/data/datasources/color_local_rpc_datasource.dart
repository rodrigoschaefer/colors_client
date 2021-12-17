import 'package:colors_client/features/account/data/datasources/private_key_datasource.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:colors_client/core/util/constants.dart';
import 'package:colors_client/features/color/data/models/color_model.dart';
import 'package:web3dart/web3dart.dart';

abstract class ColorDatasource {
  Future<List<ColorModel>> getColorsByOwner(ownerAddress);
  Future<void> mintColor(ownerAddress, int red, int green, int blue);
}

class ColorLocalRpcDatasource implements ColorDatasource {
  late Client httpClient;
  late Web3Client ethClient;
  late EthereumAddress contractAddress;
  late DeployedContract contract;
  late ContractFunction getColorsByOwnerFunction, mintFunction;
  String rpcUrl = Constants.rpcUrl;

  ColorLocalRpcDatasource() {
    httpClient = Client();
    ethClient = Web3Client(rpcUrl, httpClient);
    contractAddress = EthereumAddress.fromHex(Constants.colorsContractAddress);
    init();
  }

  init() async {
    String abi = await rootBundle.loadString('lib/abis/Colors.abi.json');
    contract =
        DeployedContract(ContractAbi.fromJson(abi, "Colors"), contractAddress);
    getColorsByOwnerFunction = contract.function('colors');
    mintFunction = contract.function('mint');
  }

  @override
  Future<List<ColorModel>> getColorsByOwner(ownerAddress) async {
    /*
    var data = await ethClient.call(
        contract: contract,
        function: getColorsByOwnerFunction,
        params: [EthereumAddress.fromHex(ownerAddress)]);
        
    List<Color> colors = [];
    for (List<dynamic> fields in data[0]) {
      colors.add(Color.fromBlockchain(fields));
    }
    return colors;*/
    return [];
  }

  @override
  Future<void> mintColor(ownerAddress, int red, int green, int blue) async {
    String? pkey = await PrivateKeyDatasource.read(ownerAddress);
    if (pkey == null) throw Exception('pKey not found');
    final credentials = EthPrivateKey.fromHex(pkey);
    await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        from: EthereumAddress.fromHex(ownerAddress),
        contract: contract,
        function: mintFunction,
        parameters: ['${red.toRadixString(16)}${green.toRadixString(16)}${blue.toRadixString(16)}'],
        //value: EtherAmount.fromUnitAndValue(EtherUnit.wei, weiAmmount)
      ),
    );
  }
}
