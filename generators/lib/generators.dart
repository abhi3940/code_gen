library generators;

import 'package:build/build.dart';
import 'package:generators/src/json_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateJsonFactory(BuilderOptions options) =>
    SharedPartBuilder([JsonGenrator()], 'json_generator');
// Import the necessary packages
