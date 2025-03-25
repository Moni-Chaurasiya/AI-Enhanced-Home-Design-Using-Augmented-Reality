//import 'package:visionaryhome/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../models/review.dart';

// ignore: must_be_immutable
class Reviewes extends StatelessWidget {
  final controller = TextEditingController();
  String? email = FirebaseAuth.instance.currentUser?.email.toString();

  Reviewes({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<List<Review>>(
            stream: readReviews("Reviews"),
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("This is the error: ${snapshot.error}");
                return const Text("Something went wrong");
              } else if (snapshot.hasData) {
                final reviews = snapshot.data!;

                return Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: reviews.map(buildReview).toList(),
                      ),
                    ),
                  ),
                );
              } else {
                return const Text(
                  "No Reviews",
                  style: TextStyle(color: Colors.white),
                );
              }
            },
          ),
          ListTile(
            title: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: "write feedback"),
            ),
            trailing: OutlinedButton(
              onPressed: () {
                // addComment();
                print(email);
                createReview(
                    name: email!, comment: controller.text, title: "Reviews");
                controller.clear();
              },
              child: Text('Send'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReview(Review review) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color(0xffff5983),
                    Colors.deepOrangeAccent,
                    Colors.orangeAccent
                  ]),

                  //Colors.pinkAccent
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20)),
                    SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      review.comment,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'More',
                      trimExpandedText: 'Show less',
                      colorClickableText: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          )
        ],
      ),
    );
  }

  Stream<List<Review>> readReviews(String title) {
    return FirebaseFirestore.instance.collection(title).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Review.fromJason(doc.data())).toList());
  }

  Future createReview(
      {required String name,
      required String comment,
      required String title}) async {
    final docRev = FirebaseFirestore.instance.collection(title).doc();
    final rev = Review(name, comment);
    final jason = rev.toJason();
    docRev.set(jason);
  }
}
