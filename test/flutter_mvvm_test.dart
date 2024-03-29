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

    testWidgets('ViewModel is initialized', (WidgetTester tester) async {
      // After a ViewModelProvider is created with a -valid- ViewModelBuilder
      TestViewModel expectedViewModel = TestViewModel();
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
          viewModelBuilder: () => expectedViewModel, child: Placeholder());

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);

      // Expect the ViewModel to be initialized
      expect(expectedViewModel.initCalled, true);
    });

    testWidgets('ViewModel is disposed', (WidgetTester tester) async {
      // After a ViewModelProvider is created with a -valid- ViewModelBuilder
      TestViewModel expectedViewModel = TestViewModel();
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
          viewModelBuilder: () => expectedViewModel, child: Placeholder());

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);
      // and then again removed from the tree
      await tester.pumpWidget(Placeholder());

      // Expect the ViewModel in the state to be disposed
      expect(expectedViewModel.disposeCalled, true);
    });
  });

  group('Extension', () {
    testWidgets('findViewModel returns ViewModel if found via BuildContext',
        (WidgetTester tester) async {
      // After a ViewModelProvider is created with a -valid- ViewModelBuilder
      TestViewModel expectedViewModel = TestViewModel();
      TestViewModel? actualViewModel;
      ViewModelProvider<TestViewModel> provider = ViewModelProvider(
        viewModelBuilder: () => expectedViewModel,
        child: Builder(
          builder: (BuildContext context) {
            actualViewModel = context.findViewModel<TestViewModel>();
            return Placeholder();
          },
        ),
      );

      // and the ViewModelProvider is added to the tree
      await tester.pumpWidget(provider);
      // Expect the ViewModel to be available
      expect(actualViewModel, expectedViewModel);
    });
  });
}
