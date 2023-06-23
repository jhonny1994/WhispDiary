import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:whisp_diary/domain/entry.dart';
import 'package:whisp_diary/presentation/entry_screen.dart';
import 'package:whisp_diary/presentation/new_entry_screen.dart';
import 'package:whisp_diary/shared/extensions.dart';
import 'package:whisp_diary/shared/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Entry> _entries = [];
  List<Entry> _filteredEntries = [];
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await ref.watch(entriesProvider(limit: 10).future);
      setState(() {
        _entries = result;
        _filteredEntries = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (context) => const NewEntryScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calendar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TableCalendar<Entry>(
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                firstDay: DateTime(2010),
                lastDay: DateTime.now(),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.twoWeeks,
                headerStyle: const HeaderStyle(formatButtonVisible: false),
                onDaySelected: (selectedDay, focusedDay) async {
                  final result = await ref.watch(entriesProvider().future);
                  setState(() {
                    _focusedDay = focusedDay;
                    _selectedDay = selectedDay;
                    _entries = result;
                    _filteredEntries = result
                        .where(
                          (element) => element.created.day == _selectedDay.day,
                        )
                        .toList();
                  });
                },
                eventLoader: (day) => _entries
                    .where((element) => element.created.day == day.day)
                    .toList(),
                enabledDayPredicate: (day) =>
                    _entries.any((element) => element.created.day == day.day),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent entries',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (_filteredEntries != _entries)
                    TextButton(
                      onPressed: () async {
                        final result =
                            await ref.watch(entriesProvider(limit: 10).future);
                        setState(() {
                          _focusedDay = DateTime.now();
                          _selectedDay = DateTime.now();
                          _entries = result;
                          _filteredEntries = result;
                        });
                      },
                      child: const Text('Clear'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final entry = _filteredEntries.elementAt(index);
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) async {
                        final dm = await ref.read(diaryManagerProvider.future);
                        await dm.deleteEntry(entry.id);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Entry deleted')),
                          );
                        }
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text(
                          entry.created.dayDateFormat(),
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        title: Text(entry.title),
                        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<Widget>(
                            builder: (context) => EntryScreen(entry),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _filteredEntries.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
