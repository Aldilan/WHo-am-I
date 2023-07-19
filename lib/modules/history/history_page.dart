import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:who_am_i/modules/history/controller/history_controller.dart';
import 'package:who_am_i/modules/history/widgets/history_card.dart';
import 'package:who_am_i/modules/user/detail/detail_page.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});
  HistoryController c = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              items: c.dropdownItems,
              onChanged: (value) {
                c.dropdownRespond(value, context);
              },
              customButton: const Icon(
                Icons.menu,
                size: 35,
                color: Colors.black,
              ),
              dropdownStyleData: DropdownStyleData(
                width: 160,
                padding: const EdgeInsets.symmetric(vertical: 6),
                offset: const Offset(0, 8),
              ),
            ),
          ),
          SizedBox(
            width: 25,
          )
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.usersData[0]['name'],
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("@" + c.usersData[0]['username']),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      50), // Set the border radius as desired
                  child: Image.network(
                    ApiURL.currentImageURL + c.usersData[0]['image'] != null
                        ? ApiURL.currentImageURL + c.usersData[0]['image']
                        : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  onPressed: () {
                    Get.to(DetailPage(
                      userData: c.usersData[0],
                      editCond: true,
                    ));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              side: BorderSide(
                                  color: Colors.black, width: 1.0)))),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Status',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: c.statusData.length,
                itemBuilder: (context, index) {
                  return HistoryCard(
                    statusData: c.statusData[index],
                    index: index + 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
