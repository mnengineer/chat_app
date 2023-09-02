import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found.'),
          );
        }

        if (chatSnapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        return ListView.builder(
          itemCount: chatSnapshot.data!.docs.length,
          itemBuilder: (ctx, index) => Container(
            padding: const EdgeInsets.all(8),
            child: Text(chatSnapshot.data!.docs[index].data()['text']),
          ),
        );
      },
    );
  }
}
