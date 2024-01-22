import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as either;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/pulls_nearby_businesses/sub_components/tavern_item.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import 'pull_nearby_businesses_cubit.dart';
import 'pull_nearby_businesses_state.dart';

class PullNearbyBusinessesPage extends StatefulWidget {
  final PullNearbyBusinessesCubit cubit;

  const PullNearbyBusinessesPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<PullNearbyBusinessesPage> createState() => _PullNearbyBusinessesState();
}

class _PullNearbyBusinessesState extends State<PullNearbyBusinessesPage> {
  PullNearbyBusinessesCubit get cubit => widget.cubit;
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  @override
  void initState() {
    cubit.getTaverns(context);
    cubit.navigator.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5001,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: AppbarSubtitleOne(text: "Pulls Nearby Businesse"),
      ),
      body: BlocBuilder<PullNearbyBusinessesCubit, PullNearbyBusinessesState>(
        bloc: cubit,
        builder: (context, state) => state.isloading
            ? CustomLoadingWidget()
            : Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      markers: Set.from([
                        ...state.taverns
                            .mapWithIndex(
                              (e, index) => Marker(
                                  onTap: () {
                                    cubit.changeSelectedIndex(index);
                                  },
                                  markerId: MarkerId(e.docId!),
                                  position: LatLng(double.parse(e.lat!),
                                      double.parse(e.long!))),
                            )
                            .toList(),
                      ]),
                      initialCameraPosition:
                          CameraPosition(target: state.latLng, zoom: 14),
                      onMapCreated: (controller) {
                        mapController.complete(controller);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              'List of Nearby Businesses',
                              style: CustomTextStyles
                                  .titleMediumCircularStdBluegray90001,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: state.taverns.mapWithIndex(
                              (t, index) {
                                return TavernsItem(
                                  isSelected: state.selectedIndex == index,
                                  ontap: () async {
                                    final GoogleMapController controller =
                                        await mapController.future;
                                    await controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                zoom: 14,
                                                target: LatLng(
                                                    double.parse(state
                                                        .taverns[
                                                            state.selectedIndex]
                                                        .lat!),
                                                    double.parse(state
                                                        .taverns[
                                                            state.selectedIndex]
                                                        .long!)))));
                                    cubit.changeSelectedIndex(index);
                                  },
                                  subTitle:
                                      "${(state.distances[index] / 1000).toStringAsFixed(2)} KM",
                                  title: t.businessName!,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomElevatedButton(
          text: 'Confirm',
          onPressed: () {
            cubit.confirmLocation();
          },
        ),
      ),
    );
  }
}
