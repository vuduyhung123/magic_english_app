import 'package:flutter/material.dart';
import 'package:magic_english_app/views/grammar_checker.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  final TextEditingController _textController = TextEditingController();
  int _charCount = 0;

  void _updateCharCount(String value) {
    setState(() {
      _charCount = value.length;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              height: 121,
              padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1.27),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Grammar Checker',
                    style: TextStyle(
                      color: Color(0xFF101727),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'AI-powered writing assistant',
                    style: TextStyle(
                      color: Color(0xFF495565),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Text input area
            Container(
              width: 338.22,
              height: 297.89,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.27, color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: const [
                  BoxShadow(color: Color(0x19000000), blurRadius: 2, offset: Offset(0, 1), spreadRadius: -1),
                  BoxShadow(color: Color(0x19000000), blurRadius: 3, offset: Offset(0, 1), spreadRadius: 0),
                ],
              ),
              padding: const EdgeInsets.all(17.27),
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      expands: true,
                      onChanged: _updateCharCount,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Paste your text here...',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$_charCount characters',
                      style: const TextStyle(
                        color: Color(0xFF697282),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Analyze button
            Container(
              width: 338.22,
              height: 55.97,
              decoration: ShapeDecoration(
                color: _charCount > 0 ? const Color(0xAF4B5CF6) : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: const [
                  BoxShadow(color: Color(0x19000000), blurRadius: 2, offset: Offset(0, 1), spreadRadius: -1),
                  BoxShadow(color: Color(0x19000000), blurRadius: 3, offset: Offset(0, 1), spreadRadius: 0),
                ],
              ),
              child: GestureDetector(
                onTap: _charCount > 0
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GrammarChecker()),
                        );
                      }
                    : null,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: _charCount > 0 ? const Color(0xAF4B5CF6) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.auto_awesome_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 24,
                        child: Center(
                          child: Text(
                            'Analyze with AI',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Analysis results
            Container(
              width: 338,
              height: 170.45,
              padding: const EdgeInsets.only(
                top: 20.27,
                left: 25.27,
                right: 25.27,
              ),
              decoration: ShapeDecoration(
                gradient: const LinearGradient(       
                  colors: [Color(0xFFEEF5FE), Color(0xFFEEF2FF)],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.27, color: Color(0xFFBEDBFF)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 23.98,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 1.99,
                          child: Container(
                            width: 20,
                            height: 20,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Icon(
                              Icons.auto_awesome_outlined,
                              color: const Color(0xFF0B5394),
                              size: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 27.98,
                          child: Text(
                            'AI Analysis Includes:',
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
                  Container(
                    width: double.infinity,
                    height: 83.93,
                    child: Stack(
                      children: [
                        Positioned(
                          top:15,
                          child: Container(
                            width: 137.84,
                            height: 47.96,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    width: 15.99,
                                    height: 15.99,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 23.98,
                                  child: Container(
                                    width: 113.86,
                                    height: 47.96,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: -1.73,
                                          child: SizedBox(
                                            width: 70,
                                            child: Text(
                                              'Grammar errors',
                                              style: TextStyle(
                                                color: const Color(0xFF354152),
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                height: 1.50,
                                              ),
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
                          left: 149.83,
                          top: 15,
                          child: Container(
                            width: 137.84,
                            height: 24,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 3.98,
                                  child: Container(
                                    width: 15.99,
                                    height: 15.99,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Icon(
                                      Icons.tips_and_updates_outlined,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 23.98,
                                  top: 0,
                                  child: Container(
                                    width: 69.93,
                                    height: 23.98,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: -1.73,
                                          child: Text(
                                            'Style tips',
                                            style: TextStyle(
                                              color: const Color(0xFF354152),
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
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 65,
                          child: Container(
                            width: 137.84,
                            height: 23.98,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    width: 15.99,
                                    height: 15.99,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Icon(  
                                      Icons.check_circle_outline,
                                      color: Colors.blue,
                                      size: 16,),
                                  ),
                                ),
                                Positioned(
                                  left: 23.98,
                                  top: 0,
                                  child: Container(
                                    width: 99.48,
                                    height: 23.98,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: -1.73,
                                          child: Text(
                                            'Clarity check',
                                            style: TextStyle(
                                              color: const Color(0xFF354152),
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
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 149.83,
                          top: 65,
                          child: Container(
                            width: 137.84,
                            height: 23.98,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 3.98,
                                  child: Container(
                                    width: 15.99,
                                    height: 15.99,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Icon(
                                      Icons.trending_up,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 23.98,
                                  top: 0,
                                  child: Container(
                                    width: 91.96,
                                    height: 23.98,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: -1.73,
                                          child: Text(
                                            'Score rating',
                                            style: TextStyle(
                                              color: const Color(0xFF354152),
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
                              ],
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
    );
  }
}
