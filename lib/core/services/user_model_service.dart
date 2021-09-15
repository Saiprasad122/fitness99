import 'package:fitness_99/core/services/data_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserModelService extends GetxController {
  String _name = '', _mobileNumber = '', _email = '', _numberOfGroups = '';
  String get name => _name;
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
  void loggedIn({
    required String name,
    required String mobileNumber,
    required String email,
    required String numberOfGroups,
  }) async {
    _name = name;
    _email = email;
    _mobileNumber = mobileNumber;
    _numberOfGroups = numberOfGroups;
    DataModel? dataModel = DataModel(
      email: email,
      mobileNumber: mobileNumber,
      userName: name,
      numbesrOfGroups: numberOfGroups,
    );
    var box = Hive.box<DataModel>('user_data');
    await box.put('data', dataModel);
    dataModel = box.get('data');
  }

// to get the userName from the DB
  String getUserName() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');

    print('The user data is ${dataModel!.userName}');
    return dataModel?.userName ?? 'N/A';
  }

// to get the email from the DB
  String getEmail() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');

    return dataModel?.email ?? 'N/A';
  }

// to get the mobileNumber from the DB
  String getMobileNumber() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');

    return dataModel?.mobileNumber ?? 'N/A';
  }

// to get the noOfGroups from the DB
  String getNoOfGroups() {
    var box = Hive.box<DataModel>('user_data');
    dataModel = box.get('data');
    return dataModel?.numbesrOfGroups ?? 'N/A';
  }
}
