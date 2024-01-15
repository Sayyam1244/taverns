import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
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
    cubit.getTavernUserInfo(context);
    cubit.navigator.context = context;
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
        title: AppbarSubtitleOne(text: "Tavern Profile"),
      ),
      body: BlocBuilder<TavernProfileCubit, TavernProfileState>(
        bloc: cubit,
        builder: (context, state) => state.isloading
            ? CustomLoadingWidget()
            : Column(
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
                                image: state.userModel.profilePicture != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          state.userModel.profilePicture!,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
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
                                      Text(state.userModel.userName!, style: CustomTextStyles.titleMedium16),
                                      Spacer(),
                                      cubit.initialParams.isTavernOwner
                                          ? Container()
                                          : Icon(
                                              Icons.favorite,
                                              color: theme.colorScheme.primary,
                                            )
                                    ],
                                  ),
                                  SizedBox(height: 10.v),
                                  profileInfoItem(name: 'Business Number', value: state.userModel.businessNumber!, icon: Icons.description_outlined),
                                  Divider(
                                    color: appTheme.gray90060.withOpacity(0.1),
                                    thickness: 1,
                                  ),
                                  profileInfoItem(name: 'Business Address', value: state.userModel.businessAddress!, icon: Icons.location_on_outlined),
                                  Divider(
                                    color: appTheme.gray90060.withOpacity(0.1),
                                    thickness: 1,
                                  ),
                                  profileInfoItem(name: 'Business Hours', value: state.userModel.businessHours!, icon: Icons.timelapse_outlined),
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
                              initialRating: 0,
                              color: theme.colorScheme.primary,
                            ),
                            SizedBox(width: 6.h),
                            Text(
                              "(No review yet)",
                              style: CustomTextStyles.titleSmallPrimary,
                            ),
                            Spacer(),
                            CustomElevatedButton(
                              onPressed: () {
                                if (cubit.initialParams.isTavernOwner) {
                                  cubit.navigateToEditProfileScreen();
                                } else {
                                  //chat here
                                }
                              },
                              height: 35.v,
                              width: cubit.initialParams.isTavernOwner ? 88.h : 60.h,
                              text: cubit.initialParams.isTavernOwner ? "Edit profile" : "Chat",
                              buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                              buttonTextStyle: CustomTextStyles.labelLargeOnErrorContainer_1,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * .3,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: AppDecoration.fillOnErrorContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder16,
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: AppDecoration.fillOnErrorContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        markers: Set.from(
                          [
                            Marker(
                              markerId: MarkerId('v'),
                              position: LatLng(
                                double.parse(state.userModel.lat!),
                                double.parse(
                                  state.userModel.long!,
                                ),
                              ),
                            ),
                          ],
                        ),
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                              double.parse(state.userModel.lat!),
                              double.parse(
                                state.userModel.long!,
                              ),
                            ),
                            zoom: 14),
                      ),
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
                            (state.userModel.marketPlaceLink == '' || state.userModel.marketPlaceLink == null) ? "No market place linked" : 'https://www.amazon.in/asdkfasdkj',
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
          Container(width: MediaQuery.sizeOf(context).width * .3, child: Text(value, style: CustomTextStyles.titleSmall12400)),
        ],
      ),
    );
  }
}
