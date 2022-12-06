import 'package:flutter/material.dart';

import 'modals/story_modal.dart';
import 'modals/user_modal.dart';

final List<User> users = [
  User(
      name: 'You',
      profileImageUrl: Image.asset('images/user/saroj.jpg'),
      stories: []),
  User(
      name: 'milan.p',
      profileImageUrl: Image.asset('images/user/milan.jpg'),
      stories: []),
  User(
      name: 'safaley',
      profileImageUrl: Image.asset('images/user/safal.jpg'),
      stories: []),
  User(
    name: 'nir.adh',
    profileImageUrl: Image.asset('images/user/niranjan.jpg'),
    stories: [],
  ),
  User(
      name: 'nsaroj',
      profileImageUrl: Image.asset('images/user/saroj.jpg'),
      stories: []),
  User(
      name: 'p.astp',
      profileImageUrl: Image.asset('images/user/milan.jpg'),
      stories: [])
];
final List<List<Story>> storiess = [
  [
    Story(
      url:
          'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      media: MediaType.image,
      duration: const Duration(seconds: 10),
      user: users[0],
    ),
    Story(
      url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
      media: MediaType.image,
      user: users[0],
      duration: const Duration(seconds: 7),
    ),
  ],
  [
    Story(
      url:
          'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
      media: MediaType.video,
      duration: const Duration(seconds: 0),
      user: users[1],
    ),
  ],
  [
    Story(
        url:
            'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
        media: MediaType.image,
        duration: const Duration(seconds: 5),
        user: users[2]),
  ],
  [
    Story(
      url:
          'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      media: MediaType.image,
      duration: const Duration(seconds: 10),
      user: users[3],
    ),
  ],
  [
    Story(
      url:
          'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
      media: MediaType.video,
      duration: const Duration(seconds: 0),
      user: users[4],
    ),
  ],
  [
    Story(
      url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
      media: MediaType.image,
      duration: const Duration(seconds: 8),
      user: users[5],
    ),
  ]
];
