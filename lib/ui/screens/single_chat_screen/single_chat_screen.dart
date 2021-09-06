import 'dart:convert';

import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/ui/components/own_file_card.dart';
import 'package:chatapp/ui/components/own_message_card.dart';
import 'package:chatapp/ui/components/reply_card.dart';
import 'package:chatapp/ui/components/reply_file_card.dart';
import 'package:chatapp/ui/screens/camera_screen/camera_screen.dart';
import 'package:chatapp/ui/screens/camera_screen/camera_view.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class SingleChatScreen extends StatefulWidget {
  SingleChatScreen({Key key, this.chatModel, this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  _SingleChatScreenState createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  IO.Socket socket;
  ImagePicker _picker = ImagePicker();
  XFile imageFile;
  int popTime = 0;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (this.mounted)
          setState(() {
            show = false;
          });
      }
    });
    connect();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.1.36:5000/", <String, dynamic>{
      // socket = IO
      //     .io("https://aqueous-lowlands-07135.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourchat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print("........................." + msg.toString());
        setMessage("destination", msg["message"], msg["path"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path,
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16),
        path: path);
    print("SET MESSAGE::::::::::::::" + message);
    if (this.mounted)
      setState(() {
        messages.add(messageModel);
      });
  }

  void onImageImage(String path, String message) async {
    print("Hey there! Everything's working $message");

    for (var i = 0; i < popTime; i++) Get.back();
    setState(() {
      popTime = 0;
    });
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.1.36:5000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print("________________________________--" + data['path']);
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": widget.sourchat.id,
      "targetId": widget.chatModel.id,
      "path": data['path'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media, links, and docs"),
                        value: "Media, links, and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                      PopupMenuItem(
                        child: Text("Wallpaper"),
                        value: "Wallpaper",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          if (messages[index].path != null &&
                              messages[index].path.length > 1) {
                            return OwnFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        } else {
                          if (messages[index].path != null &&
                              messages[index].path.length > 1) {
                            return ReplyFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return ReplyCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        if (this.mounted)
                                          setState(() {
                                            sendButton = true;
                                          });
                                      } else {
                                        if (this.mounted)
                                          setState(() {
                                            sendButton = false;
                                          });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () {
                                          if (!show) {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                          }
                                          if (this.mounted)
                                            setState(() {
                                              show = !show;
                                            });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: () {
                                              setState(() {
                                                popTime = 2;
                                              });
                                              Get.to(
                                                () => CameraScreen(
                                                  onImageSend: onImageImage,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xFF128C7E),
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                          _controller.text,
                                          widget.sourchat.id,
                                          widget.chatModel.id,
                                          "",
                                        );
                                        _controller.clear();
                                        if (this.mounted)
                                          setState(() {
                                            sendButton = false;
                                          });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  if (this.mounted)
                    setState(() {
                      show = false;
                    });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    "Document",
                    () {},
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                    Icons.camera_alt,
                    Colors.pink,
                    "Camera",
                    () async {
                      setState(() {
                        popTime = 3;
                      });
                      Get.to(
                        () => CameraScreen(
                          onImageSend: onImageImage,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                    Icons.insert_photo,
                    Colors.purple,
                    "Gallery",
                    () async {
                      setState(() {
                        popTime = 2;
                      });
                      imageFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      Get.to(
                        () => CameraViewPage(
                          path: imageFile.path,
                          onImageSend: onImageImage,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.headset,
                    Colors.orange,
                    "Audio",
                    () {},
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                    Icons.location_pin,
                    Colors.teal,
                    "Location",
                    () {},
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                    Icons.person,
                    Colors.blue,
                    "Contact",
                    () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icons, Color color, String text, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          if (this.mounted)
            setState(() {
              _controller.text = _controller.text + emoji.emoji;
            });
        });
  }
}
