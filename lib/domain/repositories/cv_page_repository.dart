import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//Repository for the CV page
class CVPageRepository extends Equatable {
  final List<String> information = [
    '12439 Berlin Germany',
    'yutaro.koyama@code.berlin',
    'https://github.com/KOYAMANI',
    'https://www.linkedin.com/in\n/yutaro-koyama-142853200'
  ];

  final List<Icon> icons = [
    const Icon(Icons.place, color: Colors.white),
    const Icon(Icons.email, color: Colors.white),
    const Icon(Icons.laptop_mac_rounded, color: Colors.white),
    const Icon(Icons.link, color: Colors.white),
  ];

  final AssetImage profileImage = const AssetImage('assets/profile.jpg');

  @override
  List<Object?> get props => [information, icons, profileImage];
}
