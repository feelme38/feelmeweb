
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'copy_empty_gen.dart';

Builder baseClassGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([CopyEmptyGen()], 'd');
