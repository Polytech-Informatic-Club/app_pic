// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'package:new_app/models/commentaires.dart';
// import 'package:new_app/models/equipe.dart';
// import 'package:new_app/models/football.dart';
// import 'package:new_app/models/match.dart';
// import 'package:new_app/models/utilisateur.dart';

// class APISevice {
  
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // CollectionReference footballCollection =
//   //     FirebaseFirestore.instance.collection("MATCH");
//   Future<Football?> likerMatch(
//     String matchId,
//     dynamic
//   ) async {
//     try {
//       String email = FirebaseAuth.instance.currentUser!.email!;

//       // Récupérer l'utilisateur avec l'email
//       QuerySnapshot userSnapshot = await _firestore
//           .collection("USER")
//           .where('email', isEqualTo: email)
//           .limit(1)
//           .get();
//       if (userSnapshot.docs.isEmpty) return null;

//       Map<String, dynamic> userData =
//           userSnapshot.docs.first.data() as Map<String, dynamic>;

//       DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);

//       await matchDoc.update(
//         {
//           'likers': FieldValue.arrayUnion([userData])
//         },
//       );

//       DocumentSnapshot querySnapshot = await matchDoc.get();

//       return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
// }
