import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations.dart';

class MockitoGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedFields = _annotatedFields(library);
    if (annotatedFields.length > 0) {
      return '''

      ${_createMockClasses(annotatedFields)}

      void _initMocks() {
        ${_fieldsToString(annotatedFields)}
      }
     
      ''';
    }
    return null;
  }

  String _fieldsToString(Iterable<TopLevelVariableElement> fields) {
    return fields.map((field) => '''
      ${field.name} = ${field.type.name}Mock();
    ''').join('');
  }

  String _createMockClasses(Iterable<TopLevelVariableElement> fields) {
    final fieldsClassess = fields.map((field) => field.type.name).toSet();
    return fieldsClassess.map((classToMock) => '''
      class ${classToMock}Mock extends Mock implements ${classToMock} {}
    ''').join('');
  }

  Iterable<TopLevelVariableElement> _annotatedFields(LibraryReader library) {
    return library
        .annotatedWith(TypeChecker.fromRuntime(BuildMock))
        .map((e) => e.element)
        .whereType<TopLevelVariableElement>();
  }
}
