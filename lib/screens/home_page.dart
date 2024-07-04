import 'package:bloc_paten/components/Text/text.dart';
import 'package:bloc_paten/core/theme/bloc/theme_bloc.dart';
import 'package:bloc_paten/core/theme/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyText.title.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
          DropdownButton<Locale>(
            value: context.locale,
            icon: const Icon(Icons.language),
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                context.setLocale(newLocale);
              }
            },
            items: const [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('es'),
                child: Text('Español'),
              ),
              DropdownMenuItem(
                value: Locale('fr'),
                child: Text('Français'),
              ),
              DropdownMenuItem(
                value: Locale('de'),
                child: Text('Deutsch'),
              ),
              DropdownMenuItem(
                value: Locale('ta'),
                child: Text('தமிழ்'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello_world'.tr(),
                style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('elevated_button'.tr()),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              child: Text('outlined_button'.tr()),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: Text('text_button'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
