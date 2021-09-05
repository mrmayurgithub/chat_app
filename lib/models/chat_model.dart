class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String msg;
  String status;
  bool select = false;
  int id;
  ChatModel({
    this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.msg,
    this.status,
    this.select = false,
    this.id,
  });
}
