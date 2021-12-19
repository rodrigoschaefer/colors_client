import 'package:colors_client/features/color/data/datasources/color_local_rpc_datasource.dart';
import 'package:colors_client/features/color/data/models/color_model.dart';
import 'package:colors_client/features/color/domain/repositories/color_repository.dart';

class ColorRepositoryLocalImpl implements ColorRepository {
  final ColorDatasource _colorDatasource;

  ColorRepositoryLocalImpl(this._colorDatasource);

  @override
  Future<List<ColorModel>> getColors(ownerAddress) async {
    List<ColorModel> colors = [];
    BigInt supply = await _colorDatasource.totalSupply(ownerAddress);
    int s = supply.toInt();
    for (int i = 0; i < s; i++) {
      ColorModel color = await _colorDatasource.getColor(ownerAddress, i);
      colors.add(color);
    }
    return colors;
  }

  @override
  Future<String?> mint(ownerAddress, int red, int green, int blue) async {
    try {
      await _colorDatasource.mintColor(ownerAddress, red, green, blue);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
