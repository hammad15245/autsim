import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizScoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateTotalScoreByEmail({
    required bool isCorrect,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Step 1: Find the user doc by email
    final querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: user.email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print("No user found with email ${user.email}");
      return;
    }

    final userDocRef = querySnapshot.docs.first.reference;

    // Step 2: Reference to totalscore collection inside that user
    final totalScoreDocRef =
        userDocRef.collection('totalScore').doc('scoreData');

    // Step 3: Run transaction to create or update score
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(totalScoreDocRef);

      if (!snapshot.exists) {
        transaction.set(totalScoreDocRef, {'score': 0});
      }

      if (isCorrect) {
        transaction.update(totalScoreDocRef, {
          'score': FieldValue.increment(1),
        });
      } else {
        // Ensure score field exists even if wrong
        if (!snapshot.exists || !snapshot.data()!.containsKey('score')) {
          transaction.update(totalScoreDocRef, {'score': 0});
        }
      }
    });
  }
}
