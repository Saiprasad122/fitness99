class ApiUrls {
  static const BASE_TEST_URL = "https://dev.99fitnessfriends.com/api";
  static const lOGIN = "/login";
  static const REGISTER = '/register';
  static const UPDATE_USER = "/updateUser/{id}";
  static const PROFILE_UPDATE = "/profile_picture/{id}";
  static const RESET_PASSWORD = "/reset_password/{id}";
  static const CREATE_CAN_DO = "/createCando/{id}";
  static const GET_CAN_DO = "/cando/{id}";
  static const DELETE_CAN_DO = "/deleteCando/{id}";
  static const CREATE_CANNOT_DO = "/createCannotdo/{id}";
  static const GET_CANNOT_DO = "/cannotdo/{id}";
  static const DELETE_CANNOT_DO = "/deleteCannotdo/{id}";
  static const CREATE_GOAL = "/createGoal/{id}";
  static const GET_GOAL = "/goal/{id}";
  static const DELETE_GOAL = "/deleteGoal/{id}";
  static const DISPLAY_MY_GROUP = '/get_my_group/{id}';
  static const DISPLAY_GROUP = '/get_group/{id}';
  static const DISPLAY_ALL_GROUPS = '/get_all_group';
  static const CREATE_NEW_GROUP = '/createGroup/{id}';
  static const JOIN_GROUP = '/join_group/{id}/{group_id}';
  static const MEMBER_LIST = '/group_members/{group_id}';
  static const GET_PROFILE = '/get_profile/{user_id}';
  static const CREATE_NEW_ACTIVITY = '/create_activity';
  static const CREATE_NEW_EVENT = '/create_event';
  static const GET_ACTIVITY = '/activity/{group_id}';
  static const GET_EVENT = '/event/{group_id}';
  static const GET_EVENT_CHECK_IN_LIST = '/eventCheckIN/{event_id}';
  static const GET_CHECK_IN_BY_USER_ID = '/checkin/{event_id}/{user_id}';
  static const GET_CHECK_OUT_BY_USER_ID = '/checkOUT/{event_id}/{user_id}';
  static const ADD_PREFERENCES = '/create_prefrence';
  static const VIEW_PREFERENCES = '/prefrence/{user_id}';
  static const GET_EVENT_DETAILS = '/eventDisplay/{event_id}';
  static const CREATE_POLL = '/createPoll';
  static const ADD_CATEGORIES = '/create_categorie';
  static const GET_CATEGORIES = '/categorie/{user_id}';
}
