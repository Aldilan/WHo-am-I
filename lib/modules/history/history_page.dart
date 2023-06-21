import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:who_am_i/modules/history/controller/history_controller.dart';
import 'package:who_am_i/modules/history/widgets/history_card.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});
  HistoryController c = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status',
              style: TextStyle(
                  color: Colors.purple[800],
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: c.statusData.length,
                  itemBuilder: ((context, index) {
                    return HistoryCard(
                      statusData: c.statusData[index],
                      index: index + 1,
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
