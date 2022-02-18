import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class UserLocalDataModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String mobileNumber;
  @HiveField(4)
  final int numbesrOfGroups;
  @HiveField(5)
  final String profilePicture;
  @HiveField(6)
  final int pendingInvitation;

  UserLocalDataModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.numbesrOfGroups,
    required this.profilePicture,
    required this.pendingInvitation,
  });

  UserLocalDataModel copyWith({
    int? id,
    String? userName,
    String? email,
    String? mobileNumber,
    int? numbesrOfGroups,
    String? profilePicture,
    int? pendingInvitation,
  }) =>
      UserLocalDataModel(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        numbesrOfGroups: numbesrOfGroups ?? this.numbesrOfGroups,
        profilePicture: profilePicture ?? this.profilePicture,
        pendingInvitation: pendingInvitation ?? this.pendingInvitation,
      );
}
