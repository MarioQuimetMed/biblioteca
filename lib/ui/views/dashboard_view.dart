import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/*
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
*/
import 'package:biblioteca/ui/labels/custom_labels.dart';
import 'package:biblioteca/ui/cards/white_card.dart';
import 'package:biblioteca/providers/auth_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user!;

    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Dashboard View', style: CustomLabels.h1 ),

          const SizedBox( height: 10 ),

          WhiteCard(
            title: user.nombre,
            child: Text( user.correo )
          )

        ],
      ),
    );
  }
}