import 'dart:math';

import 'package:flutter_music/core/viewmodels/base_model.dart';
import 'package:flutter_music/ui/shared/radial_drag.dart';

class VinylSeekbarModel extends BaseModel {
  double progressPercent = 0.0;

  handleDrags(PolarCoord polarCoordinates) {
    var angle = (polarCoordinates.angle / (2 * pi)) * 360;
    angle = angle.abs().clamp(0.0, 180.0);
    progressPercent = 1 - angle / 180;
    notifyListeners();
  }
}
