import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/flutter_mvvm.dart';
import 'package:flutter_test/flutter_test.dart';

class TestViewModel extends ViewModel {
  bool initCalled = false;
  bool disposeCalled = false;

  @override
  void init() {
    initCalled = true;
  }

  @override
  void dispose() {
    disposeCalled = true;
  }
}

void main() {
  group('Provider', () {
    testWidgets('ViewModel is available in state', (WidgetTester tester) async {
      // After a ViewModelProvider is created with a -valid- ViewModelBuilder
      TestViewModel expectedViewModel = TestViewModel();
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
          viewModelBuilder: () => expectedViewModel, child: Placeholder());

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);

      // Expect the ViewModelProviderState to hold a ViewModel instance
      // created by the ViewModelBuilder
      ViewModelProviderState<TestViewModel> state =
          tester.state(find.byWidget(provider));
      expect(state.viewModel, expectedViewModel);
    });

    testWidgets('ViewModel is null if builder does not deliver any',
        (WidgetTester tester) async {
      // After a ViewModelProvider is created with an -invalid- ViewModelBuilder
      ViewModelProvider<TestViewModel> provider =
          ViewModelProvider(viewModelBuilder: () => null, child: Placeholder());

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);

      // Expect the ViewModelProviderState to have no ViewModel instance
      ViewModelProviderState<TestViewModel> state =
          tester.state(find.byWidget(provider));
      expect(state.viewModel, isNull);
    });

    testWidgets('ViewModel is null if builder is null',
        (WidgetTester tester) async {
      // After a ViewModelProvider is created without a ViewModelBuilder
      ViewModelProvider<TestViewModel> provider =
          ViewModelProvider(viewModelBuilder: null, child: Placeholder());

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);

      // Expect the ViewModelProviderState to have no ViewModel instance
      ViewModelProviderState<TestViewModel> state =
          tester.state(find.byWidget(provider));
      expect(state.viewModel, isNull);
    });

    testWidgets('ViewModel is initialized', (WidgetTester tester) async {
      // After a ViewModelProvider is created with a -valid- ViewModelBuilder
      TestViewModel expectedViewModel = TestViewModel();
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
          viewModelBuilder: () => expectedViewModel, child: Placeholder());

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);

      // Expect the ViewModel in the state to be initialized
      ViewModelProviderState<TestViewModel> state =
          tester.state(find.byWidget(provider));
      expect(state.viewModel.initCalled, true);
    });

    testWidgets('ViewModel is disposed', (WidgetTester tester) async {
      // After a ViewModelProvider is created with a -valid- ViewModelBuilder
      TestViewModel expectedViewModel = TestViewModel();
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
          viewModelBuilder: () => expectedViewModel, child: Placeholder());

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);
      ViewModelProviderState<TestViewModel> state =
          tester.state(find.byWidget(provider));
      // and then again removed from the tree
      await tester.pumpWidget(Placeholder());

      // Expect the ViewModel in the state to be disposed
      expect(state.viewModel.disposeCalled, true);
    });
  });

  group('Extension', () {
    testWidgets('findViewModel returns ViewModel if found via BuildContext',
        (WidgetTester tester) async {
      // After a ViewModelProvider is created with a -valid- ViewModelBuilder
      TestViewModel expectedViewModel = TestViewModel();
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
        viewModelBuilder: () => expectedViewModel,
        child: Builder(
          builder: (BuildContext context) {
            // Expect findViewModel to return the ViewModel
            TestViewModel actualViewModel =
                context.findViewModel<TestViewModel>();
            expect(actualViewModel, expectedViewModel);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      );

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);
    });

    testWidgets('findViewModel returns null if not found via BuildContext',
        (WidgetTester tester) async {
      // After a ViewModelProvider is created with an -invalid- ViewModelBuilder
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
        viewModelBuilder: null,
        child: Builder(
          builder: (BuildContext context) {
            // Expect findViewModel to return null
            TestViewModel actualViewModel =
                context.findViewModel<TestViewModel>();
            expect(actualViewModel, isNull);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      );

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);
    });
  });
}
