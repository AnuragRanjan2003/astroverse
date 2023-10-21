import 'package:astroverse/models/comment.dart';
import 'package:astroverse/models/post.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final Comment item;

  const CommentItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "@${item.userName}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: const BoxDecoration(
                    color: Color(0x64dad9d9),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  toTimeDelay(item.date),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Text(
            item.body,
            maxLines: 4,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          MaterialButton(
            onPressed: () {},
            child: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: [
                Icon(
                  Icons.comment,
                  size: 17,
                  color: Colors.blue,
                ),
                Text(
                  "replies",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String toTimeDelay(DateTime date) {
    final now = DateTime.now();
    final delay = now.difference(date);
    final days = delay.inDays;
    String str = "";
    if (days == 0) {
      str = "today";
    } else if (days == 1) {
      str = "yesterday";
    } else {
      str = "$days days ago";
    }
    return str;
  }
}