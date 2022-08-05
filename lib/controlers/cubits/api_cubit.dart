import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_pagination/models/model.dart';
import '../repositry/repo.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiInitial()) {
    getData(1);
  }
  getData(int value) async {
    print('data');
    try {
      if (value == 1) {
        emit(ApiLoading());
      }
      final respon = await ApiRepo.getApi(value);
      if (respon != null) {
        emit(ApiLoaded(model: respon!));
      }
    } catch (e) {
      if (e is SocketException) {
        emit(ApiError(erro: e.message.toString()));
        Fluttertoast.showToast(msg: e.message.toString());
      }
      if (e is HttpException) {
        emit(ApiError(erro: e.message.toString()));
      } else {
        emit(ApiError(erro: e.toString()));
      }
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
