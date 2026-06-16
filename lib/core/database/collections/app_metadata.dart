import 'package:isar_community/isar.dart';

part 'app_metadata.g.dart';

@collection
class AppMetadata {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String key;

  late String value;
}
