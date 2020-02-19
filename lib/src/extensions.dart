import 'package:flutter/widgets.dart';

import 'mvvm.dart';

extension ContextViewModel on BuildContext {
  /// Returns the nearest ancestor [ViewModel] in the widget tree.
  T findViewModel<T extends ViewModel>() {
    ViewModelProviderState<T> state =
        this.findAncestorStateOfType<ViewModelProviderState<T>>();
    return state.viewModel;
  }
}