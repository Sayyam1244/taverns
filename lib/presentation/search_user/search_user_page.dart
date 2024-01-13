import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import 'search_user_cubit.dart';
import 'search_user_state.dart';

class SearchUserPage extends StatefulWidget {
  final SearchUserCubit cubit;

  const SearchUserPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SearchUserPage> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUserPage> {
  SearchUserCubit get cubit => widget.cubit;

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
              hintText: 'Search user....',
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
              'Search Tavern owner, GM\nor Player',
              textAlign: TextAlign.center,
              style: CustomTextStyles.headlineLargeCairoPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
