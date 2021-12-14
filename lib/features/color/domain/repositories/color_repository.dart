import 'package:colors_client/features/color/data/models/color.dart';

abstract class ColorRepository {
  Future<List<Color>> getColorsByOwner(ownerAddress);
}
