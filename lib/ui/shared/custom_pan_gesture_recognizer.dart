import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';

class CustomPanGestureRecognizer extends OneSequenceGestureRecognizer {
  final Function onPanStart;
  final Function onPanUpdate;
  final Function onPanEnd;

  CustomPanGestureRecognizer(
      {@required this.onPanStart,
      @required this.onPanUpdate,
      @required this.onPanEnd});

  @override
  void addPointer(PointerEvent event) {
    if (onPanStart(event.position)) {
      startTrackingPointer(event.pointer);
      resolve(GestureDisposition.accepted);
    } else {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onPanUpdate(event.position);
    }
    if (event is PointerUpEvent) {
      onPanEnd(event.position);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
