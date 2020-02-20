import 'package:flutter/widgets.dart';

typedef ViewModelBuilder<T extends ViewModel> = T Function();

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
/// Handles the lifecycle of a [ViewModel].
///
/// See also [ViewModel] and [ViewModelProviderState].
class ViewModelProvider<T extends ViewModel> extends StatefulWidget {
  ViewModelProvider({
    Key key,
    @required this.child,
    @required this.viewModelBuilder,
  }) : super(key: key);

  /// Builds the ViewModel.
  /// Will be called by [ViewModelProviderState].
  final ViewModelBuilder<T> viewModelBuilder;

  /// Includes the child to be rendered.
  /// Will be called by [ViewModelProviderState].
  final Widget child;

  @override
  ViewModelProviderState<T> createState() => ViewModelProviderState<T>();
}

/// [State] of [ViewModelProvider] which handles the lifecycle of a [ViewModel].
///
/// See also [ViewModel] and [ViewModelProvider].
class ViewModelProviderState<T extends ViewModel>
    extends State<ViewModelProvider<T>> {
  T _viewModel;

  T get viewModel => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelBuilder?.call();
    _viewModel?.init();
  }

  @override
  void dispose() {
    _viewModel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
