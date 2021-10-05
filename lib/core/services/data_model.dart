import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String mobileNumber;
  @HiveField(4)
  final String numbesrOfGroups;
  @HiveField(5)
  final String profilePicture;

  DataModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.numbesrOfGroups,
    required this.profilePicture,
  });
}
