import 'package:colors_client/features/color/data/models/color_model.dart';

abstract class ColorRepository {
  Future<List<ColorModel>> getColors(ownerAddress);
  Future<String?> mint(ownerAddress, int red, int green, int blue);
}
