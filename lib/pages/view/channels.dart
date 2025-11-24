import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/widgets/icon_text.dart';

import '../../widgets/image_text.dart';
import '../../widgets/search.dart';

class Channels extends StatefulWidget {
  const Channels({super.key});

  @override
  State<Channels> createState() => _ChannelState();
}

class _ChannelState extends State<Channels> {


  @override
  Widget build(BuildContext context) {
    return Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start, // align text to the left
          children: [
            const SizedBox(height: 16), // optional top padding
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Channels!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                    ),
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchWidget(),
            ),

            const SizedBox(height: 16), // spacing between text and list
            Expanded(
              child: IconText(), // ListView fills remaining space
            ),
          ],
        )

    );
  }
}
