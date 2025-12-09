import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:security_app/core/di/service_locator.dart";
import "package:security_app/core/helper/extensions.dart";
import "package:security_app/core/storage/app_prefs.dart";
import "package:security_app/core/theming/colors.dart";
import "package:security_app/core/widgets/my_button.dart";
import "package:security_app/core/widgets/my_card.dart";
import "package:security_app/features/patrols/data/model/patrol.dart";
import "package:security_app/features/patrols/data/model/patrol_request.dart";
import "package:security_app/features/patrols/logic/cubit/patrol_cubit.dart";
import "package:security_app/features/patrols/logic/cubit/patrol_state.dart";
import "package:security_app/features/patrols/ui/widgets/start_new_patrol_dialog.dart";

class PatrolsScreen extends StatefulWidget {
  const PatrolsScreen({super.key});

  @override
  State<PatrolsScreen> createState() => _PatrolsScreenState();
}

class _PatrolsScreenState extends State<PatrolsScreen> {
  String? selectedProject;
  final List<String> projects = ['Project 1', 'Project 2', 'Project 3'];
  late final AppPrefs _prefs;
  int? _guardId;

  String _formatDate(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
  }

  @override
  void initState() {
    super.initState();
    _prefs = getIt<AppPrefs>();
    final userJson = _prefs.getUserJson();
    _guardId = userJson != null ? int.tryParse('${userJson['id']}') : null;
  }

  @override
  Widget build(BuildContext context) {
    final patrolCubit = context.read<PatrolCubit>();
    return Scaffold(
      backgroundColor: ColorsManager.grayBackGround,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Column(
          children: [
            MyButton(
              text: '+       Start New Patrol',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: StartNewPatrolDialog(
                      projects: projects,
                      onCreate: (data) async {
                        if (_guardId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Missing guard id. Please re-login.',
                              ),
                            ),
                          );
                          return;
                        }
                        final DateTime start = data.start;
                        final DateTime end = data.end;

                        final request = PatrolRequest(
                          projectId: data.projectId,
                          guardId: _guardId!,
                          inspectorId: null,
                          date: _formatDate(start),
                          startTime: _formatTime(start),
                          endTime: _formatTime(end),
                          rating: 1,
                          location: data.location,
                          notes: data.notes ?? '',
                        );

                        patrolCubit.createPatrol(request);
                      },
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 16.h),
            BlocBuilder<PatrolCubit, PatrolsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Something went wrong:\n${state.errorMessage}',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<PatrolCubit>().loadMyPatrols(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state.patrols.isEmpty) {
                  return const Center(child: Text('No Patrols found.'));
                }
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: ListView.builder(
                      itemCount: state.patrols.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final Patrol patrol = state.patrols[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: MyCard(
                            date: patrol.createdAt?.toFormattedDate() ?? '',
                            time:
                                "${patrol.startTime?.toFormattedDate()} - ${patrol.endTime?.toFormattedDate()}",
                            location: patrol.project?.location ?? '',
                            status: patrol.project?.status ?? '',
                            statusColor: Colors.blue,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
