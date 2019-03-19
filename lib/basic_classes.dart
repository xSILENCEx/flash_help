class Msg {
  int id = -1;
  int uId = -1;
  String msgContent = '';
  DateTime sendTime;

  Msg(int mUId, int mId, String msg, DateTime mTime) {
    this.uId = mUId;
    this.id = mId;
    this.msgContent = msg;
    this.sendTime = mTime;
  }
}

//用户数据表字段名
//'user_id INTEGER, '
//'user_name TEXT, '
//'phone_num TEXT',
//'email TEXT',
//'password TEXT, '
//'auto_graph TEXT, '
//'reg_time TEXT, '
//'is_real_name INTEGER, '
//'credit INTEGER, '
//'follow TEXT'
//'fans TEXT'
//'balance REAL, '
//'integral INTEGER, '
//'send_list TEXT'
//'accept TEXT'
//'collection TEXT'
//'finish TEXT'
//'often_task TEXT'
//'nike_name TEXT, '
//'photo TEXT'
//'sex INTEGER, '
//'location TEXT'
//'log_flag INTEGER'

class User {
  int userId;
  String userName;
  String phoneNum;
  String email;
  String passWord;
  String autoGraph;
  String regTime;
  int isRealName;
  int credit;
  List<String> follow;
  List<String> fans;
  double balance;
  int integral;
  List<String> sendList;
  List<String> accept;
  List<String> collection;
  List<String> finish;
  List<String> oftenTask;
  String nikeName;
  String photo;
  int sex;
  String location;

  void setUserId(int userId) {
    this.userId = userId;
  }

  void setUsername(String username) {
    this.userName = username;
  }

  void setPhone(String phone) {
    this.phoneNum = phone;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setAutoGraph(String auto) {
    this.autoGraph = auto;
  }

  void setRegTime(String reg) {
    this.regTime = reg;
  }

  void setRealName(int real) {
    this.isRealName = real;
  }

  void setCredit(int credit) {
    this.credit = credit;
  }

  void setFollow(List<String> follow) {
    this.follow = follow;
  }

  void setFans(List<String> fans) {
    this.fans = fans;
  }

  void setBalance(double balance) {
    this.balance = balance;
  }

  void setIntegral(int integral) {
    this.integral = integral;
  }

  void setSendList(List<String> send) {
    this.sendList = send;
  }

  void setAccept(List<String> accept) {
    this.accept = accept;
  }

  void setCollection(List<String> collection) {
    this.collection = collection;
  }

  void setFinish(List<String> finish) {
    this.finish = finish;
  }

  void setOften(List<String> often) {
    this.oftenTask = often;
  }

  void setNikeName(String nike) {
    this.nikeName = nike;
  }

  void setSex(int sex) {
    this.sex = sex;
  }

  void setPhoto(String photo) {
    this.photo = photo;
  }

  void setLocation(String location) {
    this.location = location;
  }

  User(
    int userId,
    String userName,
    String phoneNum,
    String email,
    String autoGraph,
    String regTime,
    int isRealName,
    int credit,
    List<String> follow,
    List<String> fans,
    double balance,
    int integral,
    List<String> sendList,
    List<String> accept,
    List<String> collection,
    List<String> finish,
    List<String> oftenTask,
    String nikeName,
    String photo,
    int sex,
    String location,
  ) {
    this.setUserId(userId);
    this.setUsername(userName);
    this.setPhone(phoneNum);
    this.setEmail(email);
    this.setAutoGraph(autoGraph);
    this.setRegTime(regTime);
    this.setRealName(isRealName);
    this.setCredit(credit);
    this.setFollow(follow);
    this.setFans(fans);
    this.setBalance(balance);
    this.setIntegral(integral);
    this.setSendList(sendList);
    this.setAccept(accept);
    this.setCollection(collection);
    this.setFinish(finish);
    this.setOften(oftenTask);
    this.setNikeName(nikeName);
    this.setPhoto(photo);
    this.setSex(sex);
    this.setLocation(location);
  }
}

class Task {
  int taskId;
  int uId;
  DateTime taskSendTime;
  String taskTitle;
  String taskDescribe;
  List<String> pictureList;
  String location;
  int taskType;
  var taskReward;
  List<String> taskLabels;
  DateTime taskLimit;
  int taskState;
  List<String> taskLikeCount;
  List<String> taskStarCount;
  List<String> taskCommentCount;
  List<String> taskShareCount;

  Task(
    int taskId,
    int uId,
    DateTime taskSendTime,
    String taskTitle,
    String taskDescribe,
    List<String> pictureList,
    String location,
    int taskClass,
    var taskReward,
    List<String> taskLabels,
    DateTime taskLimit,
    int taskState,
    List<String> taskLikeCount,
    List<String> taskStarCount,
    List<String> taskCommentCount,
    List<String> taskShareCount,
  ) {
    setTaskId(taskId);
    setUId(uId);
    setSendTime(taskSendTime);
    setTaskTitle(taskTitle);
    setTaskDescribe(taskDescribe);
    setPictureList(pictureList);
    setLocation(location);
    setTaskClass(taskClass);
    setTaskReword(taskReward);
    setTaskLabels(taskLabels);
    setLimitTime(taskLimit);
    setTaskState(taskState);
    setTaskLikes(taskLikeCount);
    setTaskStars(taskStarCount);
    setTaskComment(taskCommentCount);
    setTaskShare(taskShareCount);
  }

  setTaskId(int taskId) {
    this.taskId = taskId;
  }

  setUId(int uId) {
    this.uId = uId;
  }

  setSendTime(DateTime sendTime) {
    this.taskSendTime = sendTime;
  }

  setTaskTitle(String taskTitle) {
    this.taskTitle = taskTitle;
  }

  setTaskDescribe(String taskDescribe) {
    this.taskDescribe = taskDescribe;
  }

  setPictureList(List<String> pictureList) {
    this.pictureList = pictureList;
  }

  setLocation(String location) {
    this.location = location;
  }

  setTaskClass(int taskClass) {
    this.taskType = taskClass;
  }

  setTaskReword(var taskReward) {
    this.taskReward = taskReward;
  }

  setTaskLabels(List<String> taskLabels) {
    this.taskLabels = taskLabels;
  }

  setLimitTime(DateTime limitTime) {
    this.taskLimit = limitTime;
  }

  setTaskState(int state) {
    this.taskState = state;
  }

  setTaskLikes(List<String> taskLike) {
    this.taskLikeCount = taskLike;
  }

  setTaskStars(List<String> taskStar) {
    this.taskStarCount = taskStar;
  }

  setTaskComment(List<String> taskComment) {
    this.taskCommentCount = taskComment;
  }

  setTaskShare(List<String> taskShare) {
    this.taskShareCount = taskShare;
  }
}
