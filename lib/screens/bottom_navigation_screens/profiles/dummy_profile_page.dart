import 'package:flutter/material.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/widgets/custom_button.dart';

class DummyProfile extends StatefulWidget {
  final String username;
  final String followers;
  final String following;
  final String bio;
  final String website;
  final String profileimage;
  final String fullName;

  DummyProfile(
      {this.bio = '',
      this.fullName = '',
      required this.followers,
      required this.following,
      required this.profileimage,
      required this.username,
      this.website = ''});

  @override
  State<DummyProfile> createState() => _DummyProfileState();
}

class _DummyProfileState extends State<DummyProfile> {
  bool requested = false;
  Widget myAvatar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50.0,
          child: ClipRRect(
            child: Image.network(widget.profileimage),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.fullName,
          style: TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'images/left.png',
            scale: 12,
          ),
        ),
        centerTitle: true,
        backgroundColor: kScaffoldBackgroundColor,
        title: Column(
          children: [
            Text(
              widget.username.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: myAvatar(context)),
                    Row(
                      children: [
                        Column(
                          children: [Text('13'), Text('Posts')],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                                '${k_m_b_generator(int.parse(widget.followers))}'),
                            Text('Followers')
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text('${widget.following}'),
                            Text('Following')
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                widget.bio != '' ? Text(widget.bio) : SizedBox(),
                SizedBox(
                  height: 2,
                ),
                widget.website != '' ? Text(widget.website) : SizedBox(),
                SizedBox(
                  height: 10,
                ),
                !requested
                    ? CustomButton(
                        child: Text('Follow'),
                        onPressed: () {
                          setState(() {
                            requested = !requested;
                          });
                        },
                        btnSize: 30,
                      )
                    : CustomButton(
                        backgroundColor: Colors.grey,
                        child: Text('Requested'),
                        onPressed: () {
                          setState(() {
                            requested = !requested;
                          });
                        },
                        btnSize: 30,
                      ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 32,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'This account is private',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Follow this account to see their photos and videos',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
