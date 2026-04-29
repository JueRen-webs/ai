import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uthm/theme/app_colors.dart';

class VirtualIdPage extends StatelessWidget {
  const VirtualIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. 同样在这里拿到你的颜色包
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.brandPrimary, // 替换 kPrimaryBlue
      appBar: AppBar(
        backgroundColor: colors.brandPrimary, // 替换 kPrimaryBlue
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Virtual ID",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE3F2FD),
                  Color(0xFF90CAF9),
                  Color(0xFF42A5F5)
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.network(
                            "https://seeklogo.com/images/K/kementerian-pengajian-tinggi-malaysia-logo-5095893796-seeklogo.com.png",
                            height: 40,
                            errorBuilder: (c, e, s) => const Icon(
                              Icons.account_balance,
                              size: 40,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/UTHM_Logo.png/1200px-UTHM_Logo.png",
                            height: 50,
                            errorBuilder: (c, e, s) => Icon( // 删掉 const，因为 colors 是动态的
                              Icons.school,
                              size: 50,
                              color: colors.brandPrimary, // 替换 kPrimaryBlue
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(flex: 1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 2),
                          image: const DecorationImage(
                            image: AssetImage('assets/me.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "MySISWA",
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF1A237E),
                                shadows: [
                                  const Shadow(
                                    color: Colors.white,
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "AI240160",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "LEE ROU",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFD4AF37),
                              Color(0xFFF7EF8A),
                              Color(0xFFD4AF37)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(Icons.memory, color: Colors.black54),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(4),
                        color: Colors.white,
                        child: const Icon(
                          Icons.qr_code_2,
                          size: 70,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}