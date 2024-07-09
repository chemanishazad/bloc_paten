import 'package:bloc_paten/bloc/authbloc/auth_bloc.dart';
import 'package:bloc_paten/core/components/components.dart';
import 'package:bloc_paten/core/theme/bloc/theme_bloc.dart';
import 'package:bloc_paten/core/theme/bloc/theme_event.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatelessWidget {
  void _handleSingleFilePicked(FilePickerResult? result) {
    if (result != null) {
      print('Single file picked: ${result.files.single.name}');
    } else {
      print('User canceled the picker');
    }
  }

  void _handleMultipleFilesPicked(List<PlatformFile>? files) {
    if (files != null) {
      for (var file in files) {
        print('Multiple file picked: ${file.name}');
      }
    } else {
      print('User canceled the picker');
    }
  }

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.user.name,
                      style: Theme.of(context).textTheme.displayLarge),
                  Text(state.user.email,
                      style: Theme.of(context).textTheme.bodyMedium),
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
                  SingleFileUpload(onFilePicked: _handleSingleFilePicked),
                  const SizedBox(height: 16),
                  MultipleFileUpload(onFilesPicked: _handleMultipleFilesPicked),
                  const SizedBox(height: 16),
                  const UrlLauncherComponent(url: 'https://www.example.com'),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                      context.go('/login');
                    },
                  ),
                ],
              );
            } else if (state is AuthLoading) {
              return const CircularProgressIndicator();
            } else if (state is AuthInitial) {
              return const Text('Please log in.');
            } else {
              return const Text('Something went wrong.');
            }
          },
        ),
      ),
    );
  }
}
