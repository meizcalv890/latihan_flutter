import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/football_model.dart';

class PlayerFormDialog extends StatefulWidget {
  final FootballModel? initialPlayer;
  final ValueChanged<FootballModel> onSave;

  const PlayerFormDialog({super.key, this.initialPlayer, required this.onSave});

  @override
  State<PlayerFormDialog> createState() => _PlayerFormDialogState();
}

class _PlayerFormDialogState extends State<PlayerFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController teamController;
  late final TextEditingController countryController;
  late final TextEditingController numberController;
  late final TextEditingController descriptionController;

  final List<String> positions = [
    'Forward',
    'Midfielder',
    'Defender',
    'Goalkeeper',
  ];

  late String selectedPosition;

  bool get isEditing => widget.initialPlayer != null;

  bool get isIndonesian => Get.locale?.languageCode == 'id';

  String translate(String id, String en) {
    return isIndonesian ? id : en;
  }

  @override
  void initState() {
    super.initState();

    final player = widget.initialPlayer;

    nameController = TextEditingController(text: player?.name ?? '');
    teamController = TextEditingController(text: player?.team ?? '');
    countryController = TextEditingController(text: player?.country ?? '');
    numberController = TextEditingController(
      text: player?.number.toString() ?? '',
    );
    descriptionController = TextEditingController(
      text: player?.description ?? '',
    );

    selectedPosition = player?.position ?? 'Forward';
  }

  @override
  void dispose() {
    nameController.dispose();
    teamController.dispose();
    countryController.dispose();
    numberController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  InputDecoration decoration(String label, IconData icon) {
    return InputDecoration(labelText: label, prefixIcon: Icon(icon));
  }

  String? requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return translate('Bagian ini wajib diisi.', 'This field is required.');
    }

    return null;
  }

  String positionLabel(String position) {
    switch (position) {
      case 'Forward':
        return translate('Penyerang', 'Forward');
      case 'Midfielder':
        return translate('Gelandang', 'Midfielder');
      case 'Defender':
        return translate('Bek', 'Defender');
      case 'Goalkeeper':
        return translate('Penjaga Gawang', 'Goalkeeper');
      default:
        return position;
    }
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    final number = int.tryParse(numberController.text.trim());

    if (number == null || number < 0 || number > 99) {
      return;
    }

    final player = FootballModel(
      id: widget.initialPlayer?.id,
      name: nameController.text.trim(),
      position: selectedPosition,
      team: teamController.text.trim(),
      country: countryController.text.trim(),
      number: number,
      description: descriptionController.text.trim(),
      isCustom: true,
    );

    widget.onSave(player);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: colors.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      title: Text(
        isEditing
            ? translate('Edit Pemain', 'Edit Player')
            : translate('Tambah Pemain Baru', 'Add New Player'),
        style: textTheme.titleLarge?.copyWith(
          color: colors.onSurface,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: SizedBox(
        width: 440,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: decoration(
                    translate('Nama Pemain', 'Player Name'),
                    Icons.person_outline,
                  ),
                  validator: requiredText,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  initialValue: selectedPosition,
                  decoration: decoration(
                    translate('Posisi', 'Position'),
                    Icons.sports_soccer,
                  ),
                  dropdownColor: colors.surfaceContainerHigh,
                  style: TextStyle(color: colors.onSurface),
                  items: positions.map((position) {
                    return DropdownMenuItem(
                      value: position,
                      child: Text(positionLabel(position)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedPosition = value);
                    }
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: teamController,
                  decoration: decoration(
                    translate('Klub / Tim', 'Club / Team'),
                    Icons.shield_outlined,
                  ),
                  validator: requiredText,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: countryController,
                  decoration: decoration(
                    translate('Negara', 'Country'),
                    Icons.flag_outlined,
                  ),
                  validator: requiredText,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: decoration(
                    translate('Nomor Pemain (0–99)', 'Player Number (0–99)'),
                    Icons.numbers,
                  ),
                  validator: (value) {
                    final number = int.tryParse(value ?? '');

                    if (number == null || number < 0 || number > 99) {
                      return translate(
                        'Masukkan angka dari 0 sampai 99.',
                        'Enter a number from 0 to 99.',
                      );
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: descriptionController,
                  decoration: decoration(
                    translate('Deskripsi', 'Description'),
                    Icons.description_outlined,
                  ),
                  validator: requiredText,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(translate('Batal', 'Cancel')),
        ),
        ElevatedButton(
          onPressed: submit,
          child: Text(
            isEditing
                ? translate('Simpan Perubahan', 'Save Changes')
                : translate('Tambah Pemain', 'Add Player'),
          ),
        ),
      ],
    );
  }
}
