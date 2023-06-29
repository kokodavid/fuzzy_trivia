import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/friends/ui/add_friend_bottomsheet.dart';
import 'package:fuzzy_trivia/premium_features/friends/ui/requests_bottomsheet.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/friends_controller.dart';

class FriendsBottomSheet extends StatefulWidget {
  const FriendsBottomSheet({super.key});

  @override
  State<FriendsBottomSheet> createState() => _FriendsBottomSheetState();
}

class _FriendsBottomSheetState extends State<FriendsBottomSheet> {
  final FriendsController friendsController = Get.put(FriendsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 4,
            width: 44,
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(4)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Friends',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const RequestsBottomsheet(),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Requests',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),

          //No results widget//

          // Friends Card//

          Expanded(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: friendsController.friendList('friends')),
          ),
        ],
      ),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: const Column(
            children: [
              Image(
                  height: 200,
                  width: 200,
                  image: AssetImage('assets/images/noresult.png')),
              Text(
                "You have no friends in your list",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          width: 230,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Button(
            title: "Add Friends",
            color: secondaryGreen,
            txtColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const AddFriend(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class FriendsCard extends StatelessWidget {
  String? profilePicure;
  String? username;
  String? type;
  String? friendId;

  FriendsCard(
      {super.key, this.profilePicure, this.username, this.type, this.friendId});

  final FriendsController friendsController = Get.put(FriendsController());

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: inputBackground, borderRadius: BorderRadius.circular(8)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        '1',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(profilePicure!),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(username!,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17)),
                  ],
                ),
                Row(
                  children: [
                    type != 'friends'
                        ? GestureDetector(
                            onTap: () {
                              friendsController.acceptFriendRequest(friendId!);
                            },
                            child: Container(
                              height: 38,
                              width: 82,
                              decoration: BoxDecoration(
                                  color: secondaryGreen,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(child: Text('Accept')),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 33,
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
