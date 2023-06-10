import 'package:attendance/components/text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers/manager_color.dart';

class NotificationsScreen extends StatefulWidget {
  // static const id = '/notificationsScreen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: DefaultTabController(
                length: 3,
                child: TabBar(
                  indicator: BoxDecoration(
                    color: ManagerColor.kPrimaryColor,
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  labelColor: Colors.white,
                  indicatorColor: ManagerColor.kPrimaryColor,
                  unselectedLabelColor: ManagerColor.black,
                  tabs: const [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'General',
                    ),
                    Tab(
                      text: 'Permissions',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButtonWidget(text: 'Mark all as read'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  selectedTileColor: ManagerColor.kLightColor,
                  tileColor: Colors.white,
                  isThreeLine: true,
                  leading: const Icon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: ManagerColor.kPrimaryColor,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Location Requesr Approved',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '2h ago',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  subtitle: const Text(
                    'Your location request was approved by your manager administration',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
