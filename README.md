# flutter_mvvm
MVVM implementation for Flutter

## Installation
This project is currently not published. So you have to install it as git dependency in your `pubspec.yaml`:

```
dependencies:
  flutter_mvvm:
    git:
      url: git@github.com:GCX-HCI/grandcentrix-flutter_mvvm.git
      ref: v0.1.2
```

## Usage
Implement the `ViewModel` class.

```
class MyViewModel extends ViewModel {
    @override
    void init() {
      // TODO: implement init
    }

    @override
    void dispose() {
      // TODO: implement dispose
    }
}
```

Use the `ViewModelProvider` as a wrapper for your widgets which make use of a `ViewModel`.
Create your `ViewModel` in the `viewModelBuilder`.

```
ViewModelProvider<LoginViewModel>(
    viewModelBuilder: () => MyViewModel(),
    child: MyScreen(),
    );
```

Use the `ViewModel` by finding it in the `BuildContext` of your widget. 
There is an extension for the `BuildContext` which you can use.

```
class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  MyViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    
    _viewModel = context.findViewModel<MyViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MyText>(
             stream: _viewModel.myText,
             builder: (BuildContext context, AsyncSnapshot<MyText> snapshot) => 
                Text(snapshot?.data?.text);
  }
}
```
