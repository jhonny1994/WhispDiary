import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisp_diary/presentation/home_screen.dart';
import 'package:whisp_diary/presentation/widgets/error.dart';
import 'package:whisp_diary/presentation/widgets/loading.dart';
import 'package:whisp_diary/shared/providers.dart';

class AppWidget extends ConsumerStatefulWidget {
  const AppWidget({super.key});

  @override
  ConsumerState<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends ConsumerState<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ),
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      home: ref.watch(isAuthProvider).maybeWhen(
            data: (data) => data
                ? const HomeScreen()
                : ErrorScreen(
                    message: 'Authentication failed.',
                    onPressed: () => ref.refresh(isAuthProvider),
                    label: 'Retry',
                  ),
            orElse: () => const LoadingScreen(),
          ),
    );
  }
}
