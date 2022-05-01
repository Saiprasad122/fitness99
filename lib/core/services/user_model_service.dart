import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'data_model.dart';

class UserModelService extends GetxController {
  String _name = '', _mobileNumber = '', _email = '', _profilePicture = '';
  int _numberOfGroups = 0, _pendingInvitaion = 0;
  String get name => _name;
  int _id = 0;
  int get id => _id;
  String? get mobileNumber => _mobileNumber;
  String? get email => _email;
  int? get numberOfGroups => _numberOfGroups;
  int get pendingInvitation => _pendingInvitaion;
  UserLocalDataModel? userLocalDataModel;

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }

//create a local database and then adding all the user data in the local DB
  void loggedIn({
    required int id,
    required String name,
    String? mobileNumber,
    required String email,
    required int numberOfGroups,
    String? profilePicture,
    required int pendingInvitaion,
  }) async {
    _id = id;
    _name = name;
    _email = email;
    _mobileNumber = mobileNumber ?? 'Please update your phone number';
    _numberOfGroups = numberOfGroups;
    _profilePicture = profilePicture ?? "images/avatar.png";
    _pendingInvitaion = pendingInvitaion;
    UserLocalDataModel? userLocalDataModel = UserLocalDataModel(
      id: id,
      email: _email,
      mobileNumber: _mobileNumber,
      userName: _name,
      numbesrOfGroups: _numberOfGroups,
      profilePicture: _profilePicture,
      pendingInvitation: _pendingInvitaion,
    );
    var box = Hive.box<UserLocalDataModel>('user_data');
    await box.put('data', userLocalDataModel);
    userLocalDataModel = box.get('data');
  }

// to get the userID from the local DB
  int getid() {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');
    return userLocalDataModel?.id ?? 0;
  }

  void updateGroupCount([int? groupCount]) async {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');
    if (userLocalDataModel != null) {
      await box.put(
        'data',
        userLocalDataModel!.copyWith(numbesrOfGroups: groupCount),
      );
    }
  }

// to get the userName from the local DB
  String getUserName() {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');
    return userLocalDataModel?.userName ?? 'N/A';
  }

// to get the email from the local DB
  String getEmail() {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');

    return userLocalDataModel?.email ?? 'N/A';
  }

// to get the mobileNumber from the local DB
  String getMobileNumber() {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');

    return userLocalDataModel?.mobileNumber ?? 'N/A';
  }

// to get the noOfGroups from the local DB
  int getNoOfGroups() {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');

    return userLocalDataModel?.numbesrOfGroups ?? 0;
  }

// to get the profilePicture from the local DB
  String getProfilePicture() {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');
    return userLocalDataModel!.profilePicture
            .contains('https://dev.99fitnessfriends.com/uploads')
        ? userLocalDataModel?.profilePicture ?? 'N/A'
        : 'https://dev.99fitnessfriends.com/uploads${userLocalDataModel?.profilePicture ?? 'N/A'}';
  }

  // to get the pending invitation list from the local DB
  int getPendingInvitation() {
    var box = Hive.box<UserLocalDataModel>('user_data');
    userLocalDataModel = box.get('data');
    return userLocalDataModel?.pendingInvitation ?? 0;
  }
}
