part of 'chat_theme_changer_bloc.dart';

@immutable
sealed class ChatThemeChangerState {}

final class ChatThemeChangerInitial extends ChatThemeChangerState {}

final class ChatThemeChangerLoading extends ChatThemeChangerState {}

final class ChatThemeChangerLoaded extends ChatThemeChangerState {
  final ThemeData theme;

  ChatThemeChangerLoaded({
    required this.theme,
  });
}
