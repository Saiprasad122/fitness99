import 'package:fitness_99/core/services/data_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserModelService extends GetxController {
  String _name = '',
      _mobileNumber = '',
      _email = '',
      _numberOfGroups = '',
      _profilePicture = '';
  String get name => _name;
  int _id = 0;
  int get id => _id;
  String? get mobileNumber => _mobileNumber;
  String? get email => _email;
  String? get numberOfGroups => _numberOfGroups;
  DataModel? dataModel;

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }

//create a local database and then adding all the user data in the local DB
  void loggedIn(
      {required int id,
      required String name,
      String? mobileNumber,
      required String email,
      required String numberOfGroups,
      String? profilePicture}) async {
    _id = id;
    _name = name;
    _email = email;
    _mobileNumber = mobileNumber ?? 'Please update your phone number';
    _numberOfGroups = numberOfGroups;
    _profilePicture = profilePicture ?? "images/avatar.png";
    DataModel? dataModel = DataModel(
      id: id,
      email: _email,
      mobileNumber: _mobileNumber,
      userName: _name,
      numbesrOfGroups: _numberOfGroups,
      profilePicture: _profilePicture,
    );
    var box = Hive.box<DataModel>('user_data');
    await box.put('data', dataModel);
    dataModel = box.get('data');
  }

// to get the userID from the local DB
  int getid() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');
    return dataModel?.id ?? 0;
  }

// to get the userName from the local DB
  String getUserName() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');

    print('The user data is ${dataModel!.userName}');
    return dataModel?.userName ?? 'N/A';
  }

// to get the email from the local DB
  String getEmail() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');

    return dataModel?.email ?? 'N/A';
  }

// to get the mobileNumber from the local DB
  String getMobileNumber() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');

    return dataModel?.mobileNumber ?? 'N/A';
  }

// to get the noOfGroups from the local DB
  String getNoOfGroups() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');
    return dataModel?.numbesrOfGroups ?? 'N/A';
  }

// to get the profilePicture from the local DB
  String getProfilePicture() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');
    return dataModel?.profilePicture ?? "images/avatar.png";
  }
}
