import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/tavern_profile/sub_components/tavern_business_info.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_rating_bar.dart';
import '../../widgets/market_place_widget.dart';
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
                                  SizedBox(height: 10.v),
                                  Row(
                                    children: [
                                      Text(state.userModel.userName!,
                                          style:
                                              CustomTextStyles.titleMedium16),
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
                                  state.userModel.accountType == "Tavern"
                                      ? TavernBusinessInfo(
                                          businessNumber:
                                              state.userModel.businessNumber ??
                                                  '',
                                          businessAddress:
                                              state.userModel.businessAddress ??
                                                  '',
                                          businessHours:
                                              state.userModel.businessHours ??
                                                  '',
                                        )
                                      : MarketPlaceWidget(
                                          link: state.userModel.marketPlaceLink,
                                          showEndIcon: false)
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
                            if (state.userModel.accountType == 'Tavern')
                              CustomRatingBar(
                                itemSize: 20.v,
                                initialRating: 0,
                                color: theme.colorScheme.primary,
                              ),
                            if (state.userModel.accountType == 'Tavern')
                              SizedBox(width: 6.h),
                            if (state.userModel.accountType == 'Tavern')
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
                              width: cubit.initialParams.isTavernOwner
                                  ? 88.h
                                  : 60.h,
                              text: cubit.initialParams.isTavernOwner
                                  ? "Edit profile"
                                  : "Chat",
                              buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                              buttonTextStyle:
                                  CustomTextStyles.labelLargeOnErrorContainer_1,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (state.userModel.accountType == 'Tavern')
                    MapWidget(
                      latLng: LatLng(
                        double.parse(state.userModel.lat!),
                        double.parse(
                          state.userModel.long!,
                        ),
                      ),
                    ),
                  if (state.userModel.accountType == "Tavern")
                    MarketPlaceWidget(
                        link: state.userModel.marketPlaceLink,
                        showEndIcon: true)
                ],
              ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key? key,
    required this.latLng,
  }) : super(key: key);
  final LatLng latLng;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                position: latLng,
              ),
            ],
          ),
          initialCameraPosition: CameraPosition(target: latLng, zoom: 14),
        ),
      ),
    );
  }
}
