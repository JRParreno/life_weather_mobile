import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/features/home/presentation/widgets/mood_tracker_dialog.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Container(
            color: ColorName.primary,
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Life Weather',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: ColorName.white),
                    ),
                    Vspace.xxs,
                    RichText(
                      text: TextSpan(
                        text: 'Welcome ',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: ColorName.white),
                        children: <TextSpan>[
                          TextSpan(
                              text: '👋 ${state.profile?.firstName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(color: ColorName.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: state.profile?.profilePhoto != null
                            ? NetworkImage(state.profile!.profilePhoto!)
                            : null,
                        radius: 45,
                        child: state.profile?.profilePhoto != null
                            ? null
                            : const Icon(
                                Icons.person_outline,
                                size: 25,
                              ),
                      ),
                      Positioned(
                          bottom: -5,
                          right: -5,
                          child: state.profile?.moodEmoji != null
                              ? GestureDetector(
                                  onTap: () {
                                    handleDialogMoodTracker(
                                      context: context,
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: ColorName.primary,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Colors.amberAccent.shade100,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 2),
                                    child: Center(
                                      child: Text(state.profile!.moodEmoji!),
                                    ),
                                  ),
                                )
                              : const SizedBox()),
                    ],
                  ),
                )
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void handleDialogMoodTracker({
    required BuildContext context,
    String? preSelect,
  }) {
    moodTrackerDialog(
      context: context,
      preSelect: preSelect,
      onSelect: (value) {
        BlocProvider.of<ProfileBloc>(context).add(SetMoodEmoji(value));
      },
    );
  }
}
