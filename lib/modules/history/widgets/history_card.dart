import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final dynamic statusData;
  final int index;

  HistoryCard({Key? key, required this.statusData, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String indexShow = index.toString();
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              indexShow,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              statusData['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              statusData['content'],
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'From : ' + statusData['user_id'].toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
