import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';

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
                CircleAvatar(
                  radius: 28,
                  backgroundColor: ColorName.white,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: state.profile?.profilePhoto != null
                        ? NetworkImage(state.profile!.profilePhoto!)
                        : null,
                    radius: 25,
                    child: state.profile?.profilePhoto != null
                        ? null
                        : const Icon(
                            Icons.person_outline,
                            size: 25,
                          ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
