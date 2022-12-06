import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_app/constant.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  String? messageText;

  void getCurrentUser() {
    if (_auth.currentUser != null) {
      loggedInUser = _auth.currentUser;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          Navigator.pop(context);
        } else if (details.delta.dx < -sensitivity) {}
      },
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text('Group Chat'),
          centerTitle: false,
          backgroundColor: kScaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                          controller: messageTextController,
                          decoration: kMessageTextFieldDecoration.copyWith(
                            suffixIcon: IconButton(
                              onPressed: () {
                                _firestore.collection('messages').add({
                                  'sender': loggedInUser?.email,
                                  'text': messageTextController.text,
                                  'created_at': DateTime.now()
                                });

                                messageTextController.clear();
                              },
                              icon: Icon(
                                Icons.arrow_upward_outlined,
                                color: Colors.blue,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('created_at', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ));
        } else {
          final messages = snapshot.data?.docs.reversed;

          for (var message in messages!) {
            final messageText = message['text'];
            final messageSender = message['sender'];

            final currentUser = loggedInUser?.email;
            var user;
            currentUser == messageSender ? user = true : user = false;
            final messageBubble = MessageBubble(
              message: messageText,
              sender: messageSender,
              isMe: user,
            );

            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.message,
    required this.sender,
    required this.isMe,
  });
  final bool isMe;
  final String sender;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender.split('@')[0],
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.blue.shade800 : Colors.grey.shade700,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Text(
                '$message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
