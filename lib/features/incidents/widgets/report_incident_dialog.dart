import 'package:flutter/material.dart';
import 'package:security_app/core/widgets/app_form_dialog.dart';
import 'package:security_app/features/incidents/data/models/incident_request_model.dart';

class ReportIncidentDialog extends StatefulWidget {
  const ReportIncidentDialog({
    super.key,
    required this.types,
    required this.projects,
    required this.onSubmit,
  });

  final List<DropdownOption> types;
  final List<DropdownOption> projects;
  final void Function(IncidentRequestModel data) onSubmit;

  @override
  State<ReportIncidentDialog> createState() => _ReportIncidentDialogState();
}

class _ReportIncidentDialogState extends State<ReportIncidentDialog> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _occurredAtController = TextEditingController();

  int? _selectedTypeId;
  int? _selectedProjectId;
  DateTime? _occurredAt;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _occurredAtController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDate: now,
    );
    if (!mounted || date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (!mounted || time == null) return;

    _occurredAt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      _occurredAtController.text = _occurredAt.toString();
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedTypeId == null ||
        _selectedProjectId == null ||
        _occurredAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select type, project, and date/time')),
      );
      return;
    }

    widget.onSubmit(
      IncidentRequestModel(
        title: _titleController.text.trim(),
        typeId: _selectedTypeId!,
        projectId: _selectedProjectId!,
        description: _descriptionController.text.trim(),
        occurredAt: _occurredAt!,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Report Incident',
      subtitle: 'Fill in the details below to report a new incident',
      primaryText: 'Submit Report',
      primaryIcon: const Icon(Icons.send),
      onPrimaryPressed: _submit,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FieldLabel('Title'),
            const SizedBox(height: 4),
            TextFormField(
              controller: _titleController,
              decoration: appInputDecoration(hint: 'Brief description'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter title' : null,
            ),
            const SizedBox(height: 12),

            const FieldLabel('Type'),
            const SizedBox(height: 4),
            DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: appInputDecoration(hint: 'Select type'),
              initialValue: _selectedTypeId,
              items: widget.types
                  .map(
                    (t) => DropdownMenuItem(value: t.id, child: Text(t.label)),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedTypeId = v),
            ),
            const SizedBox(height: 12),

            const FieldLabel('Project'),
            const SizedBox(height: 4),
            DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: appInputDecoration(hint: 'Select project'),
              initialValue: _selectedProjectId,
              items: widget.projects
                  .map(
                    (p) => DropdownMenuItem(value: p.id, child: Text(p.label)),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedProjectId = v),
            ),
            const SizedBox(height: 12),

            const FieldLabel('Description'),
            const SizedBox(height: 4),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: appInputDecoration(
                hint: 'Provide details about the incident...',
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Please enter description'
                  : null,
            ),
            const SizedBox(height: 12),

            const FieldLabel('Occurred At'),
            const SizedBox(height: 4),
            TextFormField(
              controller: _occurredAtController,
              readOnly: true,
              onTap: _pickDateTime,
              decoration: appInputDecoration(
                hint: 'Select date & time',
                suffixIcon: const Icon(Icons.event),
              ),
            ),
            const SizedBox(height: 12),

            const FieldLabel('Photos (Optional)'),
            const SizedBox(height: 4),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: pick image
              },
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Add Photo'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownOption {
  final int id;
  final String label;
  const DropdownOption({required this.id, required this.label});
}
