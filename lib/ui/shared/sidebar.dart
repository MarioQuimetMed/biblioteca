
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/*
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
*/

import 'package:biblioteca/providers/auth_provider.dart';
import 'package:biblioteca/providers/sidemenu_provider.dart';
import 'package:biblioteca/router/router.dart';
import 'package:biblioteca/services/navigation_service.dart';
import 'package:biblioteca/ui/shared/widgets/menu_item.dart';
import 'package:biblioteca/ui/shared/widgets/logo.dart';
import 'package:biblioteca/ui/shared/widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

 
  void navigateTo( String routeName ) {
    NavigationService.replaceTo( routeName );
    SideMenuProvider.closeMenu();
  }
  
  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    return Container(
      width: 215,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          
          const Logo(),
          const SizedBox( height: 50 ),

          const TextSeparator( text: 'main' ),

          MenuItem(
            text: 'Panel de Control',
            icon: Icons.auto_awesome_mosaic_rounded,
            onPressed: () {

              navigateTo( Flurorouter.dashboardRoute );
            },
            isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          ),


          MenuItem( 
            text: 'Usuarios', 
            icon: Icons.people_alt_outlined, 
            onPressed: () => navigateTo( Flurorouter.usersRoute, ),
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
          ),
          
          
          MenuItem( 
            text: 'Tipos de Acceso', 
            icon: Icons.crop_free_rounded, 
            onPressed: () => navigateTo( Flurorouter.iconsRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
          ),

          MenuItem( 
            text: 'Reportes', 
            icon: Icons.event_note_outlined, 
            onPressed: () => navigateTo( Flurorouter.blankRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
          ),


          const SizedBox( height: 50 ),
          const TextSeparator( text: 'Exit' ),
          MenuItem( 
            text: 'Cerrar Sesion', 
            
            icon: Icons.exit_to_app_outlined, 
            onPressed: (){
              Provider.of<AuthProvider>(context, listen: false)
                .logout();
            }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color( 0xff092044 ),
        Color( 0xff092042 ),
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10
      )
    ]
  );
}