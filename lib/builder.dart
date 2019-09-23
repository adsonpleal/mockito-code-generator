library source_gen_example.builder;

import 'package:build/build.dart';
import 'package:mockito_code_generator/src/mockito_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder mockBuilder(BuilderOptions options) => SharedPartBuilder(
      [MockitoGenerator()],
      'mock',
    );
