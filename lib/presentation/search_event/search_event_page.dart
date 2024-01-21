import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import 'search_event_cubit.dart';
import 'search_event_state.dart';

class SearchEventPage extends StatefulWidget {
  final SearchEventCubit cubit;

  const SearchEventPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SearchEventPage> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEventPage> {
  SearchEventCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5001,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        leading: Container(),
        actions: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
            child: CustomTextFormField(
              textInputAction: TextInputAction.search,
              hintText: 'Search event....',
              prefix: Icon(Icons.search),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: theme.colorScheme.primary, size: 100),
            Text(
              'Search Upcoming Events',
              style: CustomTextStyles.headlineLargeCairoPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
