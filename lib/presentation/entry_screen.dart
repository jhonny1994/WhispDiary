import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whisp_diary/domain/entry.dart';
import 'package:whisp_diary/presentation/new_entry_screen.dart';
import 'package:whisp_diary/shared/extensions.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen(this.entry, {super.key});

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (context) => NewEntryScreen(
                  entry: entry,
                ),
              ),
            ),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  entry.created.extendedDateFormat(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (entry.picture != null)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: MediaQuery.of(context).size.width,
                        child: Image.memory(
                          base64Decode(
                            entry.picture!,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                Text(
                  entry.content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
