import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/domain/models/models.dart';

//Repository for the CV page
class CVPageRepository extends Equatable {
  final List<UserInformation> infos = [
    const UserInformation(
        icon: Icon(Icons.place), description: '12439 Berlin Germany'),
    const UserInformation(
        icon: Icon(Icons.email), description: 'yutaro.koyama@code.berlin'),
    const UserInformation(
        icon: Icon(Icons.laptop_mac_rounded),
        description: 'https://github.com/KOYAMANI'),
    const UserInformation(
        icon: Icon(Icons.link),
        description: 'https://www.linkedin.com/in\n/yutaro-koyama-142853200'),
  ];

  final AssetImage profileImage = const AssetImage('assets/profile.jpg');

  @override
  List<Object?> get props => [infos, profileImage];
}
