import 'package:flutter/widgets.dart';

/// Defines a ViewModel in a MVVM context.
///
/// See also [ViewModelProvider].
abstract class ViewModel {
  /// Initializes the ViewModel.
  ///
  /// Called by [ViewModelProvider].
  void init();

  /// Disposes all resources at the end of a [ViewModel]'s lifecycle.
  ///
  /// Called by [ViewModelProvider].
  void dispose();
}

/// A [StatefulWidget] which provides a [ViewModel] to its child widgets.
/// Handles the lifecycle of a [ViewModel] by using the [State]'s dispose
/// functionality.
///
/// See also [ViewModel].
class ViewModelProvider<T extends ViewModel> extends StatefulWidget {
  ViewModelProvider({
    Key key,
    @required this.child,
    @required this.viewModelBuilder,
  }) : super(key: key);

  final T Function() viewModelBuilder;

  final Widget child;

  @override
  ViewModelProviderState<T> createState() => ViewModelProviderState<T>();
}

class ViewModelProviderState<T extends ViewModel>
    extends State<ViewModelProvider<T>> {
  T _viewModel;

  T get viewModel => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelBuilder();
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
