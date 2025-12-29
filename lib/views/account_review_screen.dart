import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'edit_profile_screen.dart';
import 'notification_screen.dart';
import 'login_screen.dart';

class AccountReviewScreen extends StatelessWidget {
  final bool isGuest;
  const AccountReviewScreen({super.key, this.isGuest = false});

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Icon(Icons.logout, color: const Color(0xFFE7000B), size: 28),
            ),
            const Text("Sign Out?", style: TextStyle(fontSize:16)),
        ],
        ),
        content: const Text("Are you sure you want to sign out?\nYou'll need to log in again to continue using the app.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12)),
        actions: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
              width: 120,
              child: TextButton(
                onPressed: () => Navigator.pop(context), 
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200], foregroundColor: Colors.black38),
                child: const Text("Cancel"),
              ),
            ),
            SizedBox(
              width: 120,
              child:ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                child: const Text("Sign Out"),
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.center,
              child: GeneratedContainer(
                isGuest: isGuest,
                onEdit: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                onNotify: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
                onSignOut: () => _showSignOutDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeneratedContainer extends StatelessWidget {
  final bool isGuest;
  final VoidCallback onEdit;
  final VoidCallback onNotify;
  final VoidCallback onSignOut;

  const GeneratedContainer({
    super.key,
    this.isGuest = false,
    required this.onEdit,
    required this.onNotify,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1194,       
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 50,
                offset: Offset(0, 25),
                spreadRadius: -12,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: 356,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.50, 0.00),
                      end: Alignment(0.50, 1.00),
                      colors: [const Color(0xFF0B5394), const Color(0xFF0D6CB8), const Color(0xFF1E88E5)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 280,
                        top: -63,
                        child: Container(
                          width: 127.98,
                          height: 127.98,
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(42770700),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -26,
                        top: 307.85,
                        child: Container(
                          width: 96,
                          height: 96,
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(42770700),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 324,
                        top: 24,
                        child: Container( 
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 20), onPressed: () => Navigator.pop(context))
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 31,
                        top: 72,
                        child: SizedBox(
                          width: 314.01,
                          height: 235.85,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 105,
                                top: 146,
                                child: SizedBox(
                                  width: 107.49,
                                  height: 23.98,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 2,
                                        top: -1.73,
                                        child: Text(
                                          isGuest ? 'Guest Learner' : 'Nguyen Van A',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 66,
                                top: 172,
                                child: SizedBox(
                                  width: 185.64,
                                  height: 23.98,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: -1.73,
                                        child: Text(
                                          isGuest ? 'Not signed in' : 'nguyenvana@gmail.com',
                                          style: TextStyle(
                                            color: const Color(0xCCFFFEFE),
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 97,
                                child: SizedBox(
                                  width: 124,
                                  height: 124,
                                  child: Stack(
                                    children: [
                                      Positioned( 
                                        child: Container(
                                          width: 124,
                                          height: 124,
                                          padding: const EdgeInsets.all(3.82),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 3.82, color: Colors.white),
                                              borderRadius: BorderRadius.circular(42770700),
                                            ),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x19000000),
                                                blurRadius: 10,
                                                offset: Offset(0, 8),
                                                spreadRadius: -6,
                                              ),
                                              BoxShadow(
                                                color: Color(0x19000000),
                                                blurRadius: 25,
                                                offset: Offset(0, 20),
                                                spreadRadius: -5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 37,
                top: 400,
                child: SizedBox(
                  width: 314.01,
                  height: 120.48,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 96.68,
                          height: 120.48,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.27,
                                color: const Color(0xFFFFD6A7),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                                spreadRadius: -4,
                              ),
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 15,
                                offset: Offset(0, 10),
                                spreadRadius: -3,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 28.34,
                                top: 15.26,
                                child: Container(
                                  width: 39.99,
                                  height: 39.99,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, 0.00),
                                      end: Alignment(1.00, 1.00),
                                      colors: [const Color(0xFFFF8803), const Color(0xFFFF6800)],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Icon(Icons.bolt, color: Colors.white, size: 24),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15.26,
                                top: 63.24,
                                child: SizedBox(
                                  width: 66.16,
                                  height: 23.98,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 28.54,
                                        top: -1.73,
                                        child: Text(
                                          '7',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFFFF6B35),
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15.26,
                                top: 89.21,
                                child: SizedBox(
                                  width: 66.16,
                                  height: 16.01,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 66.16,
                                        child: Text(
                                          'Day Streak',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF495565),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.33,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 108.67,
                        top: 0,
                        child: Container(
                          width: 96.68,
                          height: 120.48,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.27,
                                color: const Color(0xFFBEDBFF),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                                spreadRadius: -4,
                              ),
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 15,
                                offset: Offset(0, 10),
                                spreadRadius: -3,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 28.34,
                                top: 15.26,
                                child: Container(
                                  width: 39.99,
                                  height: 39.99,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, 0.00),
                                      end: Alignment(1.00, 1.00),
                                      colors: [const Color(0xFF50A2FF), const Color(0xFF2B7FFF)],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: SvgPicture.asset(
                                                'assets/icons/word.svg',
                                                width: 24,
                                                height: 24,
                                              )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15.26,
                                top: 63.24,
                                child: SizedBox(
                                  width: 66.16,
                                  height: 23.98,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 19.12,
                                        top: -1.73,
                                        child: Text(
                                          '156',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF0B5394),
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15.26,
                                top: 89.21,
                                child: SizedBox(
                                  width: 66.16,
                                  height: 16.01,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 66.16,
                                        child: Text(
                                          'Words',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF495565),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.33,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 217.33,
                        top: 0,
                        child: Container(
                          width: 96.68,
                          height: 120.48,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.27,
                                color: const Color(0xFFB8F7CF),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                                spreadRadius: -4,
                              ),
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 15,
                                offset: Offset(0, 10),
                                spreadRadius: -3,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 28.34,
                                top: 15.26,
                                child: Container(
                                  width: 39.99,
                                  height: 39.99,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, 0.00),
                                      end: Alignment(1.00, 1.00),
                                      colors: [const Color(0xFF05DF72), const Color(0xFF00C850)],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: 
                                        SvgPicture.asset(
                                                'assets/icons/reward.svg',
                                                width: 24,
                                                height: 24,
                                              )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15.26,
                                top: 63.24,
                                child: SizedBox(
                                  width: 66.16,
                                  height: 23.98,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 23.26,
                                        top: -1.73,
                                        child: Text(
                                          '23',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF10B981),
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15.26,
                                top: 89.21,
                                child: SizedBox(
                                  width: 66.16,
                                  height: 16.01,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 66.16,
                                        child: Text(
                                          'Checks',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF495565),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.33,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Achievements Section
              Positioned(
                left: 13,
                top: 572,
                child: Container(
                  width: 362.01,
                  height: 122.51,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 11.99,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 23.98,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 154.37,
                          children: [
                            SizedBox(
                              width: 106.85,
                              height: 23.98,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: -1.73,
                                    child: Text(
                                      'Achievements',
                                      style: TextStyle(
                                        color: const Color(0xFF101727),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 52.78,
                              height: 20,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'View All',
                                    style: TextStyle(
                                      color: const Color(0xFF0B5394),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 86.54,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 69.51,
                                height: 86.54,
                                padding: const EdgeInsets.symmetric(vertical: 11.99),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, 0.00),
                                    end: Alignment(1.00, 1.00),
                                    colors: [const Color(0xFFFEF9C1), const Color(0xFFFEEF85)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.27,
                                      color: const Color(0xFFFFDF20),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 3.98,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: SvgPicture.asset(
                                                'assets/icons/reward.svg',
                                                width: 26,
                                                height: 26,
                                                color: const Color(0xFFA65F00),
                                              )
                                    ),
                                    SizedBox(
                                      width: 42.98,
                                      height: 32.03,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 5.60,
                                            top: 0,
                                            child: SizedBox(
                                              width: 32,
                                              child: Text(
                                                'First Week',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: const Color(0xFFA65F00),
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.33,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 81.50,
                              top: 0,
                              child: Container(
                                width: 69.51,
                                height: 86.54,
                                padding: const EdgeInsets.symmetric(vertical: 11.99),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, 0.00),
                                    end: Alignment(1.00, 1.00),
                                    colors: [const Color(0xFFFFECD4), const Color(0xFFFFD6A7)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.27,
                                      color: const Color(0xFFFFB869),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 3.98,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Icon(Icons.bolt,color: const Color(0xFFC93400), size: 24)
                                    ),
                                    SizedBox(
                                      width: 42.98,
                                      height: 32.03,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 3.31,
                                            top: 0,
                                            child: SizedBox(
                                              width: 37,
                                              child: Text(
                                                '7 Day Streak',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: const Color(0xFFC93400),
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.33,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 163,
                              top: 0,
                              child: Container(
                                width: 69.51,
                                height: 86.54,
                                padding: const EdgeInsets.symmetric(vertical: 11.99),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, 0.00),
                                    end: Alignment(1.00, 1.00),
                                    colors: [const Color(0xFFDAEAFE), const Color(0xFFBDDAFF)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.27,
                                      color: const Color(0xFF8DC5FF),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 3.98,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: SvgPicture.asset(
                                                'assets/icons/word.svg',
                                                width: 26,
                                                height: 26,
                                                color: const Color(0xFF1347E5),
                                              )
                                    ),
                                    SizedBox(
                                      width: 42.98,
                                      height: 32.03,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 3.29,
                                            top: 0,
                                            child: SizedBox(
                                              width: 37,
                                              child: Text(
                                                '150 Words',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: const Color(0xFF1347E5),
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.33,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 244.50,
                              top: 0,
                              child: Opacity(
                                opacity: 0.50,
                                child: Container(
                                  width: 69.51,
                                  height: 86.54,
                                  padding: const EdgeInsets.only(top: 11.99, bottom: 28),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1.27,
                                        color: const Color(0xFFD0D5DB),
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 3.98,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: SvgPicture.asset(
                                                'assets/icons/king.svg',
                                                width: 24,
                                                height: 24,
                                                color: const Color(0xFF697282),
                                              )
                                      ),
                                      SizedBox(
                                        width: 41.49,
                                        height: 16.01,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Locked',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFF697282),
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                height: 1.33,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Account Section
              Positioned(
                left: 13,
                top: 734,
                child: Container(
                  width: 362,
                  height: 221,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 11.99,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 23.98,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: -1.73,
                              child: Text(
                                'Account',
                                style: TextStyle(
                                  color: const Color(0xFF101727),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 155,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF9FAFB),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.27,
                              color: const Color(0xFFE5E7EB),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 1.27,
                              top: 1.27,
                              child: GestureDetector(
                                onTap: onEdit,
                                child: Container(
                                  width: 348,
                                  height: 75.96,
                                  padding: const EdgeInsets.symmetric(horizontal: 15.99),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 15.99,
                                    children: [
                                      Container(
                                        width: 39.99,
                                        height: 39.99,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFDBEAFE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Icon(Icons.person_outline, color: const Color(0xFF1347E5), size: 20)
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 43.98,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            spacing: 0,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: 23.98,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      child: Text(
                                                        'Edit Profile',
                                                        style: TextStyle(
                                                          color: const Color(0xFF101727),
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 20,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 187.50,
                                                      child: Text(
                                                        'Update your information',
                                                        style: TextStyle(
                                                          color: const Color(0xFF697282),
                                                          fontSize: 14,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.43,
                                                        ),
                                                      ),  
                                                    ),
                                                  ],                                                                                                  
                                                ),                 
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(alignment: Alignment.centerRight, child: Icon(Icons.chevron_right, size: 20, color: Colors.black26)),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Stack(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 1.27,
                              top: 77.24,
                              child: Container(
                                width: 311.46,
                                height: 1,
                                decoration: BoxDecoration(color: const Color(0xFFE5E7EB)),
                              ),
                            ),
                            Positioned(
                              left: 1.27,
                              top: 78.23,
                              child: GestureDetector(
                                onTap: onNotify,
                                child: Container(
                                  width: 348,
                                  height: 75.96,
                                  padding: const EdgeInsets.symmetric(horizontal: 15.99),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 15.99,
                                    children: [
                                      Container(
                                        width: 39.99,
                                        height: 39.99,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF2E7FE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Icon(Icons.notifications_none, color: const Color(0xFF7C3AED), size: 20)
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 43.98,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            spacing: 0,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: 23.98,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: -1.73,
                                                      child: Text(
                                                        'Notifications',
                                                        style: TextStyle(
                                                          color: const Color(0xFF101727),
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 20,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 187.50,
                                                      child: Text(
                                                        'Manage your alerts',
                                                        style: TextStyle(
                                                          color: const Color(0xFF697282),
                                                          fontSize: 14,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.43,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(alignment: Alignment.centerRight, child: Icon(Icons.chevron_right, size: 20, color: Colors.black26)),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Stack(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 1.27,
                              top: 154.19,
                              child: Container(
                                width: 311.46,
                                height: 1,
                                decoration: BoxDecoration(color: const Color(0xFFE5E7EB)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Membership & Sign Out Section
              Positioned(
                left: 37,
                top: 955,
                child: Container(
                  width: 314.01,
                  height: 82.53,
                  padding: const EdgeInsets.only(left: 15.99),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [const Color(0xFFEEF2FF), const Color(0xFFEEF5FE)],
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.27,
                        color: const Color(0xFFC6D1FF),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 11.99,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.only(right: 0.02),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC6D2FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Icon(Icons.calendar_today_outlined, color: const Color(0xFF374151), size: 24),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 95.80,
                        height: 43.98,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 0,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 20,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Member Since',
                                    style: TextStyle(
                                      color: const Color(0xFF495565),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 23.98,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: -1.73,
                                    child: Text(
                                      'Dec 2025',
                                      style: TextStyle(
                                        color: const Color(0xFF101727),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 94,
                top: 1086,
                child: GestureDetector(
                  onTap: onSignOut,
                  child: Container(
                    width: 200,
                    height: 59,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, 0.50),
                        end: Alignment(1.00, 0.50),
                        colors: [const Color(0xFFFEF2F2), const Color(0xFFFCF1F7)],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.27,
                          color: const Color(0xFFFFC9C9),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                          spreadRadius: -1,
                        ),
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 7.99,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(),
                        ),
                        SizedBox(
                          width: 110,
                          height: 23.98,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -1.73,
                                child: 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Icon(Icons.logout, color: const Color(0xFFE7000B), size: 20),
                                  Text(' Sign Out',
                                    style: TextStyle(
                                      color: const Color(0xFFE7000B),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
