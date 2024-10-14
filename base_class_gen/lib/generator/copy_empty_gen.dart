import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import '../copy_empty_annotations/copy_empty_annotations.dart';
import 'base_class_visitor.dart';

class CopyEmptyGen extends GeneratorForAnnotation<BaseClass> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = BaseVisitor();
    var buffer = StringBuffer();
    element.visitChildren(visitor);
    final className = visitor.className;
    final slashedName = '_\$$className';
    final isNamed = annotation.read('named').boolValue;
    if (isNamed) {
      buffer.writeln('${visitor.className} ${slashedName}Empty(){');
      buffer.writeln('return ${visitor.className}(');
      for (var i = 0; i < visitor.fieldNames.length; i++) {
        final type = visitor.typeNames[i];
        if (type == 'String') {
          buffer.writeln('${visitor.fieldNames[i]}: \'\',');
        } else if (type == 'bool') {
          buffer.writeln('${visitor.fieldNames[i]}: false,');
        } else if (type == 'int') {
          buffer.writeln('${visitor.fieldNames[i]}: 0,');
        } else if (type == 'List') {
          buffer.writeln('${visitor.fieldNames[i]}: [],');
        } else {
          if (visitor.types[i] == 'EnumElementImpl') {
            buffer.writeln(
                '${visitor.fieldNames[i]}: ${visitor.typeNames[i]}.values.first,');
          } else {
            buffer.writeln('${visitor.fieldNames[i]}: $type.empty(),');
          }
        }
      }
      buffer.writeln(');}');
    } else {
      buffer.writeln('${visitor.className} ${slashedName}Empty(){');
      buffer.writeln('return ${visitor.className}(');
      for (var i = 0; i < visitor.fieldNames.length; i++) {
        final type = visitor.typeNames[i];
        if (type == 'String') {
          buffer.writeln('\'\'');
        } else if (type == 'bool') {
          buffer.writeln('false,');
        } else if (type == 'int') {
          buffer.writeln('0,');
        } else if (type == 'List') {
          buffer.writeln('[],');
        } else {
          if (visitor.types[i] == 'EnumElementImpl') {
            buffer.writeln('${visitor.typeNames[i]}.values.first,');
          } else {
            buffer.writeln('$type.empty(),');
          }
        }
      }
      buffer.writeln(');}');
    }

    buffer.writeln(
        'extension ${visitor.className}Value on ${visitor.className} {');
    if (isNamed) {
      buffer.writeln('${visitor.className} copy({');
      for (var item in visitor.nullableFields) {
        buffer.writeln('$item,');
      }
      buffer.writeln('}) {');

      buffer.writeln('return ${visitor.className}(');
      for (var item in visitor.fieldNames) {
        buffer.writeln('$item: $item ?? this.$item,');
      }
      buffer.writeln(');}');
    } else {
      buffer.writeln('${visitor.className} copy({');
      for (var item in visitor.nullableFields) {
        buffer.writeln('$item,');
      }
      buffer.writeln('}) {');

      buffer.writeln('return ${visitor.className}(');
      for (var item in visitor.fieldNames) {
        buffer.writeln('$item ?? this.$item,');
      }
      buffer.writeln(');}');
    }
    buffer.writeln('String stringValue() {');
    var toStringFields = visitor.fieldNames
        .map((e) => '${e.split(' ').last}: \$${e.split(' ').last}');
    buffer.writeln('return \'$className: ${toStringFields.join(', ')}\';');
    buffer.writeln('}');
    buffer.writeln('}');
    return buffer.toString();
  }

}
