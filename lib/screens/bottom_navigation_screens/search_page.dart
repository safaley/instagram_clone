import 'package:flutter/material.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/screens/bottom_navigation_screens/profiles/dummy_profile_page.dart';
import 'package:instagram_clone_app/services/instagram_data_scraper.dart';
import 'package:instagram_clone_app/widgets/custom_button.dart';
import 'package:instagram_clone_app/widgets/custom_textfield.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String? username,
      followers = " ",
      following,
      bio,
      website,
      profileimage,
      fullName;
  InstagramScraper instaScraper = InstagramScraper();

  printDetails(String username) async {
    try {
      await instaScraper.getProfileData(username);
      setState(() {
        this.username = instaScraper.username;
        this.followers = instaScraper.followers;
        this.following = instaScraper.following;
        this.website = instaScraper.website;
        this.bio = instaScraper.bio;
        this.profileimage = instaScraper.imgurl;
        this.fullName = instaScraper.fullName;

        print('followers $followers');
        print('username $username');
      });
    } on FormatException {
      print('no good');
    }
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

  Widget avatar() {
    return CircleAvatar(
      radius: 25.0,
      child: ClipRRect(
        child: profileimage != null
            ? Image.network(profileimage!)
            : Image.asset('images/user/insta_blank.jpeg'),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }

  String? blankPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: kScaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: CustomTextField(
                      obscureText: false,
                      controller: _searchController,
                      hintText: 'Enter profile name',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                      child: CustomButton(
                          child: Text('Search'),
                          onPressed: () async {
                            await printDetails(_searchController.text.trim());

                            // await instaScraper.getPosts('routineofnepalbanda');
                          }))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              profileimage != null
                  ? InkWell(
                      onTap: () {
                        if (profileimage != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DummyProfile(
                                      bio: bio != null ? bio! : '',
                                      website: website != null ? website! : '',
                                      followers: followers!,
                                      fullName:
                                          fullName != null ? fullName! : '',
                                      following: following!,
                                      profileimage: profileimage!,
                                      username: username!))));
                        }
                      },
                      child: Container(
                        child: Row(
                          children: [
                            avatar(),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              username!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
