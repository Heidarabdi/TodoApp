
class TaskModel {
  String? taskId;
  final String taskTitle;
  final String taskDesc;
  final String taskCat;
  final String taskCreated;
  final String taskDeadline;
  final bool isCompleted;

  TaskModel({
    this.taskId,
    required this.taskTitle,
    required this.taskDesc,
    required this.taskCat,
    required this.taskCreated,
    required this.taskDeadline,
    required this.isCompleted,
  });




  factory TaskModel.fromJson(Map<String, dynamic> json) { // this function is used to convert json to object this is usefull when we want to get data from firebase and we want to convert it to object
    return TaskModel(
      taskId: json['taskId'],
      taskTitle: json['taskTitle'],
      taskDesc: json['taskDesc'],
      taskCat: json['taskCat'],
      taskCreated: json['taskCreated'],
      taskDeadline: json['taskDeadline'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() { // this function is used to convert the object to json this is usefull when we want to send data to firebase and we want to convert it to json
    return {
      'taskId': taskId,
      'taskTitle': taskTitle,
      'taskDesc': taskDesc,
      'taskCat': taskCat,
      'taskCreated': taskCreated,
      'taskDeadline': taskDeadline,
      'isCompleted': isCompleted,
    };
  }

}
