import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String mobileNumber;
  @HiveField(3)
  final String numbesrOfGroups;

  DataModel({
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.numbesrOfGroups,
  });
}
