import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget? titleContent;
  final Widget? leadingWidget;
  final bool automaticallyLeading;
  final List<Widget>? actionsWidgets;
  final Color? appBarBackgroundColor;
  final double? appBarToolbarHeight;
  final bool? centerTitle;
  final double? appElevation;
  final SystemUiOverlayStyle? systemOverlayStyle;
  CustomAppBar({Key? key, this.titleContent,this.systemOverlayStyle ,this.leadingWidget,this.actionsWidgets,this.appBarBackgroundColor,this.appBarToolbarHeight,this.appElevation,required this.automaticallyLeading,this.centerTitle}): preferredSize =  Size.fromHeight(appBarToolbarHeight!), super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: automaticallyLeading,
      title: titleContent,
      centerTitle: centerTitle??true,
      leading: leadingWidget ,
      actions: actionsWidgets,
      leadingWidth: 65,
      elevation: appElevation??0,
      backgroundColor: appBarBackgroundColor??Colors.white,
      toolbarHeight:appBarToolbarHeight??80,
      systemOverlayStyle: systemOverlayStyle,

    );
  }
}


//   AppBar(
//   backgroundColor: AppColors.mainColorWhite,
//   elevation: 0,
//   leading: const Padding(
//     padding: EdgeInsets.only(right: 20),
//     child: CircleAvatar(
//       backgroundImage: AssetImage("assets/images/img.png",),
//       backgroundColor: Color(0xffFFFFFF),
//       minRadius: 50,
//       maxRadius: 75,
//     ),
//   ),
//   title: const Text("تسجيل الدخول",
//     style: TextStyle(
//       color: Color(0xff878787),
//       fontSize: 17,
//       fontWeight: FontWeight.bold,
//     ),),
//   actions: [
//     IconButton(
//       onPressed: () {
//
//       },
//       icon: Image.asset("assets/images/img_11.png",
//         height: 20,),
//     ),
//   ],
// )
