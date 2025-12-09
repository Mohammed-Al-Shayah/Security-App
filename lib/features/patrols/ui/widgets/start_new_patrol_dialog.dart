import 'package:flutter/material.dart';
import 'package:security_app/core/widgets/app_form_dialog.dart';

class StartNewPatrolDialog extends StatefulWidget {
  const StartNewPatrolDialog({
    super.key,
    required this.projects,
    required this.onCreate,
  });

  final List<String> projects;
  final void Function(StartPatrolData data) onCreate;

  @override
  State<StartNewPatrolDialog> createState() => _StartNewPatrolDialogState();
}

class _StartNewPatrolDialogState extends State<StartNewPatrolDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedProject;
  final _locationController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();
  TimeOfDay? _scheduledTime;

  @override
  void dispose() {
    _locationController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime ?? now,
    );
    if (picked != null) {
      setState(() {
        _scheduledTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProject == null || _scheduledTime == null) return;

    final now = DateTime.now();
    final start = DateTime(
      now.year,
      now.month,
      now.day,
      _scheduledTime!.hour,
      _scheduledTime!.minute,
    );
    final end = start.add(const Duration(hours: 1));
    final int projectId = widget.projects.indexOf(_selectedProject!) + 1;

    widget.onCreate(
      StartPatrolData(
        projectId: projectId,
        project: _selectedProject!,
        start: start,
        end: end,
        location: _locationController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Start New Patrol',
      subtitle: 'Fill in the patrol details to begin',
      primaryText: 'Create Patrol',
      primaryIcon: const Icon(Icons.play_arrow),
      onPrimaryPressed: _submit,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FieldLabel('Project'),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: appInputDecoration(hint: 'Select project'),
              initialValue: _selectedProject,
              items: widget.projects
                  .map(
                    (p) => DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedProject = v),
            ),
            const SizedBox(height: 12),

            const FieldLabel('Location'),
            const SizedBox(height: 4),
            TextFormField(
              controller: _locationController,
              decoration: appInputDecoration(
                hint: 'e.g., Building A - Floor 1',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter location' : null,
            ),
            const SizedBox(height: 12),

            const FieldLabel('Scheduled Time'),
            const SizedBox(height: 4),
            TextFormField(
              controller: _timeController,
              readOnly: true,
              onTap: _pickTime,
              decoration: appInputDecoration(
                hint: 'Select time',
                suffixIcon: const Icon(Icons.access_time),
              ),
            ),
            const SizedBox(height: 12),

            const FieldLabel('Notes (Optional)'),
            const SizedBox(height: 4),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: appInputDecoration(
                hint: 'Add any special instructions...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StartPatrolData {
  StartPatrolData({
    required this.projectId,
    required this.project,
    required this.start,
    required this.end,
    required this.location,
    this.notes,
  });

  final int projectId;
  final String project;
  final DateTime start;
  final DateTime end;
  final String location;
  final String? notes;
}
