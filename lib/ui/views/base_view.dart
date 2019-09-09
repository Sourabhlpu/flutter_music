import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_music/core/viewmodels/base_model.dart';

import '../../locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;
  final Function(T) onDisponse;

  BaseView({this.builder, this.onModelReady, this.onDisponse});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        builder: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }

  @override
  void dispose() {
    if (widget.onDisponse != null) widget.onDisponse(model);
    super.dispose();
  }
}
