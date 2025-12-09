import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/widgets/my_button.dart';
import 'package:security_app/core/widgets/my_card.dart';
import 'package:security_app/features/incidents/data/models/incident_request_model.dart';
import 'package:security_app/features/incidents/logic/cubit/incidents_cubit.dart';
import 'package:security_app/features/incidents/widgets/incident_details_dialog.dart';
import 'package:security_app/features/incidents/widgets/report_incident_dialog.dart';

class IncidentsScreen extends StatelessWidget {
  const IncidentsScreen({super.key});

  Color _statusColor(String status) {
    final value = status.toUpperCase();
    if (value.contains('OPEN')) return Colors.orange;
    if (value.contains('IN_PROGRESS')) return Colors.blue;
    if (value.contains('RESOLVED') || value.contains('CLOSED')) {
      return Colors.green;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.grayBackGround,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Column(
          children: [
            MyButton(
              text: 'Report New Incident',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: ReportIncidentDialog(
                      // TODO: ideally load these from API
                      types: const [
                        DropdownOption(id: 1, label: 'Gate issue'),
                        DropdownOption(id: 2, label: 'Suspicious activity'),
                        DropdownOption(id: 3, label: 'Technical problem'),
                      ],
                      projects: const [
                        DropdownOption(id: 1, label: 'Mall Entrance Updated'),
                        DropdownOption(id: 2, label: 'Mall Entrance'),
                      ],
                      onSubmit: (IncidentRequestModel data) {
                        context.read<IncidentsCubit>().createIncidents(data);
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: BlocBuilder<IncidentsCubit, IncidentsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Something went wrong:\n${state.errorMessage}',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<IncidentsCubit>().fetchIncidents(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state.incidents.isEmpty) {
                    return const Center(child: Text('No incidents found.'));
                  }

                  return ListView.builder(
                    itemCount: state.incidents.length,
                    itemBuilder: (context, index) {
                      final incident = state.incidents[index];
                      final occurredAt = incident.occurredAt;
                      final dateStr = occurredAt != null
                          ? DateFormat('d MMM, y').format(occurredAt)
                          : 'Date not available';
                      final timeStr = occurredAt != null
                          ? DateFormat('h:mm a').format(occurredAt)
                          : 'Time not available';
                      final projectLine =
                          (incident.projectName?.trim().isNotEmpty ?? false)
                          ? incident.projectName!.trim()
                          : 'Unknown project';
                      final locationSuffix =
                          (incident.projectLocation?.trim().isNotEmpty ?? false)
                          ? ' - ${incident.projectLocation!.trim()}'
                          : '';
                      final location = '$projectLine$locationSuffix';
                      final statusText = incident.status ?? 'Unknown';
                      final typeText = incident.typeName ?? 'N/A';
                      final description =
                          incident.description?.trim().isNotEmpty == true
                          ? incident.description!.trim()
                          : 'No description available';

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.0.h),
                        child: MyCard(
                          onTap: () {
                            showIncidentDetailsDialog(
                              context,
                              title: incident.title ?? 'Incident',
                              type: typeText,
                              status: statusText,
                              project: location,
                              date: '$dateStr - $timeStr',
                              description: description,
                            );
                          },
                          date: dateStr,
                          time: timeStr,
                          location: location,
                          status: statusText,
                          statusColor: _statusColor(statusText),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
