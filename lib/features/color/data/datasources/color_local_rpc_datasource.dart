import 'package:colors_client/features/account/data/datasources/private_key_datasource.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:colors_client/core/util/constants.dart';
import 'package:colors_client/features/color/data/models/color_model.dart';
import 'package:web3dart/web3dart.dart';

abstract class ColorDatasource {
  Future<ColorModel> getColor(ownerAddress, id);
  Future<void> mintColor(ownerAddress, int red, int green, int blue);
  Future<BigInt> totalSupply(ownerAddress);
}

class ColorLocalRpcDatasource implements ColorDatasource {
  late Client httpClient;
  late Web3Client ethClient;
  late EthereumAddress contractAddress;
  late DeployedContract contract;
  late ContractFunction getColorsFunction, mintFunction, getTotalSupplyFunction;
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
    getColorsFunction = contract.function('mintedColors');
    getTotalSupplyFunction = contract.function('totalSupply');
    mintFunction = contract.function('mint');
  }

  @override
  Future<ColorModel> getColor(ownerAddress, id) async {
    var data = await ethClient.call(
      contract: contract,
      function: getColorsFunction,
      params: [BigInt.from(id)],
    );
    return ColorModel(
        id: BigInt.from(id), rgb: data[0], ownerAddress: ownerAddress);
  }

  @override
  Future<BigInt> totalSupply(ownerAddress) async {
    var data = await ethClient
        .call(contract: contract, function: getTotalSupplyFunction, params: []);
    return (data[0] as BigInt);
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
        parameters: [_rgbDecToHexString(red, green, blue)],
      ),
    );
  }

  String _rgbDecToHexString(int red, int green, int blue) {
    return '${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';
  }
}
