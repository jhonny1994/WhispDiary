import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whisp_diary/domain/entry.dart';
import 'package:whisp_diary/presentation/home_screen.dart';
import 'package:whisp_diary/shared/extensions.dart';
import 'package:whisp_diary/shared/providers.dart';

class NewEntryScreen extends ConsumerStatefulWidget {
  const NewEntryScreen({this.entry, super.key});

  final Entry? entry;

  @override
  ConsumerState<NewEntryScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<NewEntryScreen> {
  final content = TextEditingController();
  DateTime created = DateTime.now();
  XFile? image;
  ImagePicker picker = ImagePicker();
  final title = TextEditingController();

  @override
  void initState() {
    if (widget.entry != null) {
      setState(() {
        title.text = widget.entry!.title;
        content.text = widget.entry!.content;
        created = widget.entry!.created;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            widget.entry != null ? const Text('Update') : const Text('Write'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TextField(
                  controller: content,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Story',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Image'),
                  ),
                  FilledButton(
                    onPressed: () async {
                      if (title.text.isNotEmpty && content.text.isNotEmpty) {
                        if (widget.entry != null) {
                          final dm =
                              await ref.read(diaryManagerProvider.future);
                          final entry = widget.entry!
                            ..title = title.text
                            ..content = content.text;
                          if (image != null) {
                            entry.picture =
                                base64Encode(await image!.readAsBytes());
                          }
                          await dm.updateEntry(entry);
                        } else {
                          final dm =
                              await ref.read(diaryManagerProvider.future);
                          await dm.addEntry(
                            title: title.text.trim(),
                            content: content.text.trim(),
                            created: created,
                            image: image,
                          );
                        }
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('added')),
                          );

                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<Widget>(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                  TextButton.icon(
                    onPressed: () => showModalBottomSheet<CalendarDatePicker>(
                      context: context,
                      builder: (context) => CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        onDateChanged: (value) {
                          setState(() {
                            created = value;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(created.simpleDateFormat()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
