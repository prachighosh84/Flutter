import 'package:flutter/material.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key});

  final List<Map<String, String>> users = const [
    {"name": "Bob Smith", "time":"8:30am", "status": "Hey I have a question", "image": "assets/user1.png"},
    {"name": "Alice Johnson", "time":"Yesterday", "status": "Can you please send", "image": "assets/user2.png"},
    {"name": "Diana Prince","time":"11:30am", "status": "Will call soon", "image": "assets/user1.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),),
          child:
            Padding(
              padding: const EdgeInsets.only(left:10, right: 10,top:10,bottom:10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(user["image"]!),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user["name"]!,
                            style: const TextStyle(fontSize:16,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),

                          Text(
                            user["time"]!,
                            style: const TextStyle(fontSize:12, fontWeight:FontWeight.normal),
                          ),
                        ],

                      ),

                      Text(
                        user["status"]!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Divider()
                ],
              ),
            )
        );

      },
    );
  }
}
