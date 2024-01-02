// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:generators/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

class JsonGenrator extends GeneratorForAnnotation <JSONGenAnnotation>{
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    
      final visitor = ModelVisiotor();
      element.visitChildren(visitor);

      final String className = '${visitor.className}Gen';
      final fields = visitor.fields;

      //created class with its fields
      final buffer = StringBuffer();
      buffer.writeln('class $className {');
      for (int i = 0; i < fields.length; i++) {
        buffer.writeln(
            'final ${fields.values.elementAt(i)} ${fields.keys.elementAt(i)},');
      }

      //created constructor
      buffer.writeln('const $className({');
      for (int i = 0; i < fields.length; i++) {
        buffer.writeln('required this.${fields.keys.elementAt(i)},');
      }
      buffer.writeln('});');

      //created toMap method
      buffer.writeln('Map<String, dynamic> toMap() {');
      buffer.writeln('return {');
      for (int i = 0; i < fields.length; i++) {
        buffer.writeln(
            "'${fields.keys.elementAt(i)}': ${fields.keys.elementAt(i)},");
      }
      buffer.writeln('};');
      buffer.writeln('}');

      //created fromMap method
      buffer.writeln('factory $className.fromMap(Map<String, dynamic> map) {');
      buffer.writeln('return $className(');
      for (int i = 0; i < fields.length; i++) {
        buffer.writeln('${fields.keys.elementAt(i)}: map["${fields.keys.elementAt(i)}"],');
      }
      buffer.writeln(');');
      buffer.writeln('}');

      //created copyWith method
      buffer.writeln('$className copyWith({');
      for (int i = 0; i < fields.length; i++) {
        buffer.writeln('${fields.values.elementAt(i)}? ${fields.keys.elementAt(i)},');
      }
      buffer.writeln('})');
      buffer.writeln('{');
      buffer.writeln('return $className(');
      for (int i = 0; i < fields.length; i++) {
        buffer.writeln('${fields.keys.elementAt(i)}: ${fields.keys.elementAt(i)} ?? this.${fields.keys.elementAt(i)},');
      }
      buffer.writeln(');');
      buffer.writeln('}');

      buffer.writeln('}');
      return buffer.toString();
    }
}
