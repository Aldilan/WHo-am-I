import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:who_am_i/modules/user/detail/detail_page.dart';

class StatusCard extends StatelessWidget {
  final dynamic statusData;

  StatusCard({Key? key, required this.statusData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statusData[
                    'title'], // Access the user's name from the statusData
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              Text(statusData['content'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              Text('from : ' + statusData['user_id'].toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
