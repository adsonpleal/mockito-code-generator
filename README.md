# Mockito Code Generator

A Dart package that generates code for the [mockito library](https://github.com/dart-lang/mockito).


## Pub

https://pub.dev/packages/mockito_code_generator

## BuildMock Annotation

Variables annotated with **BuildMock** will trigger code generation.

## How it works

By adding the annotation to a variable that you want to mock:

```dart
part 'my_test.g.dart';

@BuildMock()
Cat _cat;

@BuildMock()
Dog _dog;

@BuildMock()
Dog _secondDog;

void main() {
  setUp(() {
    // Init mocks.
    _initMocks();
  });

  test("Let's verify some behavior!", () {
    _cat.sound();
    _dog.sound();
    _secondDog.sound();
    verify(_cat.sound());
    verify(_dog.sound());
    verify(_secondDog.sound());
  });
```

And running
```bash
pub run build_runner build --delete-conflicting-outputs
```

The generator will create the `my_test.g.dart` file for you:

```dart
part of 'my_test.dart';

class CatMock extends Mock implements Cat {}
class DogMock extends Mock implements Dog {}

void _initMocks() {
  _cat = CatMock();
  _dog = DogMock();
  _secondDog = DogMock();
}
```

It gets all annotated fields and create their corresponding `Mock` classes.
It also creates a  `_initMocks` method that initializes the annotated fields;

By using the generator you don't need to manually create the `Mock` classes.

## Examples

- [Cat test](https://github.com/adsonpleal/mockito-code-generator/tree/master/example) - an example of how to use BuildMock annotation

### Maintainers

- [Adson Leal](https://github.com/adsonpleal)
