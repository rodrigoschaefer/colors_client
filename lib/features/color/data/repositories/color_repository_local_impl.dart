import 'package:colors_client/features/color/data/datasources/color_local_rpc_datasource.dart';
import 'package:colors_client/features/color/data/models/color.dart';
import 'package:colors_client/features/color/domain/repositories/color_repository.dart';

class ColorRepositoryLocalImpl implements ColorRepository {
  final ColorDatasource _colorDatasource;

  ColorRepositoryLocalImpl(this._colorDatasource);

  @override
  Future<List<Color>> getColorsByOwner(ownerAddress) {
    return _colorDatasource.getColorsByOwner(ownerAddress);
  }
  
}
