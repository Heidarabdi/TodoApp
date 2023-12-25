import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardTask extends StatelessWidget {
  const CardTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),

      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // left side
            Container(
              width: 15,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            // right side
            Expanded(
              flex: 15,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Flexible(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,

                        title: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Learn Flutter and Firebase',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),

                        subtitle: const Text(
                          'Learn Flutter and Firebase to build a Todo App with Flutter and Firebase Firestore and Firebase Auth and Firebase Storage and Firebase Hosting',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,

                          ),
                          maxLines: 3,
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            splashRadius: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            fillColor: MaterialStateProperty.all(Colors.blue),
                            value: true,
                            onChanged: (value) {},
                          ),),
                      ),
                    ),


                    const Gap(10),

                     const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),


                    const Row(
                      children: [
                        Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          '12/12/2023',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          '12:00 PM',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )

                  ],


                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

