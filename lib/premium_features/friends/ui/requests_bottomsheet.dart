import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/friends_controller.dart';

class RequestsBottomsheet extends StatefulWidget {
  const RequestsBottomsheet({super.key});

  @override
  State<RequestsBottomsheet> createState() => _RequestsBottomsheetState();
}

class _RequestsBottomsheetState extends State<RequestsBottomsheet> {
  final FriendsController friendsController = Get.put(FriendsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
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
            child: const Text(
              'Friend requests',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),

          Expanded(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: friendsController.friendList('requests')),
          ),

          // Friends Card//
          // Container(
          //     height: 66,
          //     margin: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Card(
          //         margin: const EdgeInsets.symmetric(vertical: 5),
          //         color: inputBackground,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //         child: const ListTile(
          //           minLeadingWidth: 10,
          //           leading: Text(
          //             '1',
          //             style: TextStyle(color: Colors.black),
          //           ),
          //           title: Row(
          //             children: [
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
          //           trailing: Icon(
          //             Icons.delete_outline,
          //             color: Colors.red,
          //           ),
          //         ))),
        ],
      ),
    );
  }
}
