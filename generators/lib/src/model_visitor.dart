// ignore: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisiotor extends SimpleElementVisitor<void> {
  String className = '';
  Map<String, dynamic> fields = {};

  void visitConsturctorElement(ConstructorElement element) {
    final returnType  = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element.type.toString().replaceFirst('*', '');
  }
}
