import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection/injection.dart';
import 'features/dictionary/presentation/pages/dictionary_page.dart';
import 'features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: BlocProvider<DictionaryBloc>(
        create: (context) => getIt<DictionaryBloc>(),
        child: const DictionaryPage(),
      ),
    );
  }
}
