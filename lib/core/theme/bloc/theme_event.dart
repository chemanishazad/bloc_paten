import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}

class SystemThemeChangedEvent extends ThemeEvent {
  final Brightness brightness;

  const SystemThemeChangedEvent({required this.brightness});

  @override
  List<Object> get props => [brightness];
}
