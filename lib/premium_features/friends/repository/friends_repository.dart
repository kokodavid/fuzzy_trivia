import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsRepository {
  
  Future<bool> checkUsernameExists(String username) async {
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('profiles')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

 
}
