import 'package:flutter_music/core/enums/viewstate.dart';

import 'base_model.dart';

class RepeatButtonModel extends BaseModel {
  void onRepeatPressed() {
    if (state == ViewState.RepeatAll)
      setState(ViewState.RepeatOne);
    else if (state == ViewState.RepeatOne)
      setState(ViewState.RepeatNone);
    else if (state == ViewState.RepeatNone) setState(ViewState.RepeatAll);
    notifyListeners();
  }
}
