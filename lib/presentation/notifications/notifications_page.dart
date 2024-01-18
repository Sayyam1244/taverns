import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_cubit.dart';
import 'notifications_state.dart';

class NotificationsPage extends StatefulWidget {
final NotificationsCubit cubit;

const NotificationsPage({
Key? key,
required this.cubit,
}) : super(key: key);

@override
State<NotificationsPage> createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsPage> {

NotificationsCubit get cubit => widget.cubit;

@override
void initState() {
super.initState();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(),
body: const SizedBox(),
);
}
}