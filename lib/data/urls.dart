class Urls {
  static const String _baseUrl ="http://35.73.30.144:2005/api/v1";

  static const String registration = "$_baseUrl/Registration";
  static const String logIn = "$_baseUrl/Login";
  static const String createNewTask = "$_baseUrl/createTask";
  static const String gteNewTaskUrl = "$_baseUrl/listTaskByStatus/New";
  static const String gteProgressTaskUrl = "$_baseUrl/listTaskByStatus/Progress";
  static const String taskStatusCountUrl = "$_baseUrl/taskStatusCount";
}