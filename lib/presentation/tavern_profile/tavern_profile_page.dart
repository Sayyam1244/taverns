import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_rating_bar.dart';
import 'tavern_profile_cubit.dart';
import 'tavern_profile_state.dart';

class TavernProfilePage extends StatefulWidget {
  final TavernProfileCubit cubit;

  const TavernProfilePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TavernProfilePage> createState() => _TavernProfileState();
}

class _TavernProfileState extends State<TavernProfilePage> {
  TavernProfileCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5001,
      appBar: AppBar(
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: Text('Tavern Profile', style: CustomTextStyles.titleMedium16),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: AppDecoration.fillOnErrorContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 43.adaptSize,
                      width: 43.adaptSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // image: state.user.profilePicture != null ? DecorationImage(image: NetworkImage(state.user.profilePicture!)) : null,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.h),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Tavern name',
                                  style: CustomTextStyles.titleMedium16),
                              Spacer(),
                              Icon(
                                Icons.favorite,
                                color: theme.colorScheme.primary,
                              )
                            ],
                          ),
                          SizedBox(height: 10.v),
                          profileInfoItem(
                              name: 'Business Number',
                              value: '234720934237',
                              icon: Icons.description_outlined),
                          Divider(
                            color: appTheme.gray90060.withOpacity(0.1),
                            thickness: 1,
                          ),
                          profileInfoItem(
                              name: 'Business Address',
                              value: 'Route florida ajsl dkfj',
                              icon: Icons.location_on_outlined),
                          Divider(
                            color: appTheme.gray90060.withOpacity(0.1),
                            thickness: 1,
                          ),
                          profileInfoItem(
                              name: 'Business Hours',
                              value: '8:AM to 4:PM',
                              icon: Icons.timelapse_outlined),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.v),
                Divider(
                  color: appTheme.gray90060.withOpacity(0.1),
                  thickness: 1,
                ),
                SizedBox(height: 14.v),
                Row(
                  children: [
                    CustomRatingBar(
                      itemSize: 20.v,
                      initialRating: 4,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(width: 6.h),
                    Text(
                      "(22235)",
                      style: CustomTextStyles.titleSmallPrimary,
                    ),
                    Spacer(),
                    CustomElevatedButton(
                      onPressed: () {},
                      height: 35.v,
                      width: 60.h,
                      text: "Chat",
                      buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                      buttonTextStyle:
                          CustomTextStyles.labelLargeOnErrorContainer_1,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: AppDecoration.fillOnErrorContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Marketplace :   ',
                  style: CustomTextStyles.titleMediumPrimary,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: Text(
                    'https://www.amazon.in/asdkfasdkj',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleSmall12Blue,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.link,
                  color: appTheme.blueGray800,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class profileInfoItem extends StatelessWidget {
  const profileInfoItem({
    Key? key,
    required this.name,
    required this.value,
    required this.icon,
  }) : super(key: key);
  final String name;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: appTheme.blueGray800,
            size: 14,
          ),
          SizedBox(width: 6.h),
          Text(name, style: CustomTextStyles.titleSmall12),
          Spacer(),
          Container(
              width: MediaQuery.sizeOf(context).width * .3,
              child: Text(value, style: CustomTextStyles.titleSmall12400)),
        ],
      ),
    );
  }
}
