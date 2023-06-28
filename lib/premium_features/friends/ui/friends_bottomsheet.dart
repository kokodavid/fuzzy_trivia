import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/friends/ui/add_friend_bottomsheet.dart';

import '../../single_player/match_making/ui/button.dart';

class FriendsBottomSheet extends StatefulWidget {
  const FriendsBottomSheet({super.key});

  @override
  State<FriendsBottomSheet> createState() => _FriendsBottomSheetState();
}

class _FriendsBottomSheetState extends State<FriendsBottomSheet> {
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
          const Text(
            'Friends List',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),

          //No results widget//

          Column(
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          ),

          //Friends Card//
          // Container(
          //     height: 66,
          //     margin: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Card(
          //         margin: const EdgeInsets.symmetric(vertical: 5),
          //         color: inputBackground,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20.0),
          //         ),
          //         child: ListTile(
          //           minLeadingWidth: 10,
          //           leading: const Text(
          //             '1',
          //             style: TextStyle(color: Colors.black),
          //           ),
          //           title: Row(
          //             children: const [
          //               CircleAvatar(
          //                 backgroundImage:
          //                     NetworkImage('https://i.pravatar.cc/150?img=1'),
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text('name', style: TextStyle(color: Colors.black)),
          //             ],
          //           ),
          //           trailing: const Icon(
          //             Icons.delete_outline,
          //             color: Colors.red,
          //           ),
          //         ))),
        ],
      ),
    );
  }
}
