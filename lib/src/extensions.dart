import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/src/mvvm.dart';

extension ContextViewModel on BuildContext {
  /// Returns the nearest ancestor [ViewModel] in the widget tree by its type.
  T findViewModel<T extends ViewModel>() {
    ViewModelProviderState<T> state =
        this.findAncestorStateOfType<ViewModelProviderState<T>>()!;
    return state.viewModel;
  }
}
