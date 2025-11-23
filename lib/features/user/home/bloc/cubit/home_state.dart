part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeIndexChanged extends HomeState {}

class SliderLoading extends HomeState {}

class SliderSuccess extends HomeState {}

class SliderFailure extends HomeState {}


