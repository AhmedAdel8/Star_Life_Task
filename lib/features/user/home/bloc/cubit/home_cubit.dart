import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truee_balance_app/features/user/home/data/model/doctors/all_doctors_data_model.dart';
import 'package:truee_balance_app/features/user/home/data/model/services/service_model.dart';
import 'package:truee_balance_app/features/user/home/data/model/sliders/slider_model.dart';
import 'package:truee_balance_app/features/user/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());
  final HomeRepo _homeRepo;

  int currentBannerIndex = 0;

  void changeIndex(int index) {
    currentBannerIndex = index;
    emit(HomeIndexChanged());
  }
// load more services

}
