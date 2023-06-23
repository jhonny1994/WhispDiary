import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:whisp_diary/presentation/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then(
    (_) => runApp(
      const ProviderScope(
        child: AppWidget(),
      ),
    ),
  );
}
