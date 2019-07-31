import 'base_model.dart';
import 'package:flutter/material.dart';

class HomeModel extends BaseModel {
  ScrollController _scrollController;
  ValueNotifier<double> scrollPercent;

  void initScrollController(ScrollController controller) {
    _scrollController = controller;
  }

  void initScrollPercent(ValueNotifier<double> valueNotifier) {
    scrollPercent = valueNotifier;
  }

  bool handleScrollNotification(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      _updateScroll();
    } else if (notification is ScrollEndNotification) {
      _snapAppBar();
    }
  }

  _updateScroll() {
    double currentScrollPosition = _scrollController.position.pixels;
    currentScrollPosition = currentScrollPosition.clamp(0.0, 100.0);
    double currentScrollPercentOfAppBar = currentScrollPosition / 100.0;
    scrollPercent.value = currentScrollPercentOfAppBar;
  }

  _snapAppBar() {
    double currentPixelsScrolled = _scrollController.position.pixels;
    //snapping when in the range of 0 - 100
    if (currentPixelsScrolled < 30.0 && currentPixelsScrolled > 0.0) {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    } else if (currentPixelsScrolled >= 30 && currentPixelsScrolled < 100) {
      _scrollController.animateTo(100.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    }

    //snapping when in the range of 100 - 150
    else if (currentPixelsScrolled > 100 && currentPixelsScrolled < 125) {
      _scrollController.animateTo(100.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    } else if (currentPixelsScrolled >= 125 && currentPixelsScrolled < 150) {
      _scrollController.animateTo(150.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    }
  }
}
