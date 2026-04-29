/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// 1. Import url_launcher to enable website navigation
import 'package:url_launcher/url_launcher.dart';
// --- 注入：引入 main.dart 以使用全局 Key ---
import '../main.dart';
import 'package:uthm/theme/app_colors.dart';

// =======================================================
//           CLASS 1: PROFILE PAGE (Main Tab)
// =======================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // 2. Helper function to open the website
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      // mode: LaunchMode.externalApplication opens it in Chrome/Safari instead of inside the app
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      // --- AppBar ---
      appBar: AppBar(
        backgroundColor: colors.brandPrimary,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      // --- Body Content ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // 1. Profile Header (Photo & Name)
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: colors.secondaryText,
                      backgroundImage: const AssetImage('assets/me.jpg'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "LEE ROU",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colors.brandPrimary, // 使用库颜色
                    ),
                  ),
                  Text(
                    "Matric No: AI248888",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: colors.secondaryText, // 使用库颜色
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. Student Details Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel(context, "Student Details"),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: _buildCardDecoration(context),
                    child: Column(
                      children: [
                        // --- 3. Faculty Row with Click Action ---
                        _buildInfoRow(
                          context,
                          Icons.domain,
                          "Faculty",
                          "FSKTM",
                          onTap: () => _launchURL(
                              "https://fsktm.uthm.edu.my/"), // Opens the website
                        ),

                        Divider(height: 30, color: colors.borderColor),
                        _buildInfoRow(context,Icons.school, "Course",
                            "Bachelor of Computer Science (Multimedia Computing)"),
                        Divider(height: 30, color: colors.borderColor),
                        _buildInfoRow(context,Icons.email_outlined, "Email",
                            "ai248888@student.uthm.edu.my"),
                        Divider(height: 30, color: colors.borderColor),
                        _buildInfoRow(
                            context,Icons.phone_iphone, "Phone", "+60 12-345 6789"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Contact Us (Expandable List)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                // 注意：_buildCardDecoration 也要传入 context 才能拿颜色
                decoration: _buildCardDecoration(context),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: Icon(
                      Icons.support_agent,
                      color: context.colors.brandPrimary, // 换成品牌主色
                      size: 28,
                    ),
                    title: Text(
                      "Contact Us",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.colors.primaryText, // 换成主文字颜色
                      ),
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    children: [Divider(height: 1, color: context.colors.borderColor), // 分割线颜色
                      const SizedBox(height: 20),
                      _buildContactCard(
                        context, // 别忘了传 context 进去
                        deptName: "Universiti Tun Hussein Onn Malaysia (UTHM)",
                        address: "86400 Parit Raja Batu Pahat Johor\nMalaysia",
                        phone: "+607-453 7000",
                        fax: "+607-453 6337",
                        email: "pro@uthm.edu.my",
                        web: "http://www.uthm.edu.my",
                      ),
                      const SizedBox(height: 16),
                      _buildSectionSubLabel(context, "Postgraduate (Master & PhD)"),
                      _buildContactCard(
                        context,
                        deptName: "Centre for Graduate Studies",
                        address: "86400 Parit Raja Batu Pahat Johor",
                        phone: "+607-453 7757 / 7509",
                        fax: "+607-453 6111",
                        email: "ps@uthm.edu.my",
                        web: "http://cgs.uthm.edu.my",
                      ),
                      const SizedBox(height: 16),
                      _buildSectionSubLabel(context,"Undergraduate (Diploma & Degree)"),
                      _buildContactCard(
                        context,
                        deptName: "Academic Management Office",
                        address: "86400 Parit Raja Batu Pahat Johor",
                        phone: "+607-453 7696",
                        fax: "+607-453 6085",
                        email: "pa@uthm.edu.my",
                        web: "http://ppa.uthm.edu.my",
                      ),
                      const SizedBox(height: 16),
                      _buildSectionSubLabel(context,"International Student"),
                      _buildContactCard(
                        context,
                        deptName: "International Office",
                        address: "86400 Parit Raja Batu Pahat Johor",
                        phone: "+607-453 8514 / 8515",
                        fax: "+607-453 8516",
                        email: "io@uthm.edu.my",
                        web: "http://io.uthm.edu.my",
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 4. Action Buttons Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // --- A. 学术日历按钮 (调用助手方法) ---
                  _buildActionButton(
                    context,
                    "Academic Calendar",
                    Icons.calendar_month,
                    isPrimary: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AcademicCalendarPage()),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // --- B. 虚拟 ID 按钮 (调用助手方法) ---
                  _buildActionButton(
                    context,
                    "My Virtual ID",
                    Icons.badge,
                    isPrimary: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VirtualIdPage()),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // --- C. 注销按钮 (调用助手方法) ---
                  // 这里的弹窗逻辑已经封装在底下的 _buildLogoutButton 里面了，不用重复写
                  _buildLogoutButton(context),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ], // 结束 Column 的 children
        ), // 结束 Column
      ), // 结束 SingleChildScrollView
    ); // 结束 Scaffold
  }

  // --- Helper Methods (以下内容全部保留) ---
  BoxDecoration _buildCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colors.surface, // 现在你可以用 context 拿颜色了！
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        )
      ],
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: context.colors.brandPrimary)),
    );
  }

  Widget _buildSectionSubLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: context.colors.brandPrimary)),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value,
      {VoidCallback? onTap}) {
    final colors = context.colors; // 拿到颜色库

    Widget row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // 使用库里的品牌色，并设置透明度
              color: colors.brandPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 20, color: colors.brandPrimary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: colors.secondaryText)), // 使用次要文字颜色
              const SizedBox(height: 2),
              Text(value,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    // 如果能点，就用蓝色；不能点，就用主文字颜色
                    color: onTap != null ? colors.brandPrimary : colors.primaryText,
                    decoration: onTap != null ? TextDecoration.underline : null,
                    decorationColor: colors.brandPrimary,
                  )),
            ],
          ),
        ),
        if (onTap != null)
          Icon(Icons.open_in_new, size: 16, color: colors.brandPrimary),
      ],
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: row,
      );
    }
    return row;
  }

  Widget _buildContactCard(BuildContext context, {required String deptName, required String address, required String phone, required String fax, required String email, required String web}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: context.colors.cardAlt, borderRadius: BorderRadius.circular(12), border: Border.all(color: context.colors.borderColor)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(deptName, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: context.colors.primaryText)),
        const SizedBox(height: 8),
        _buildContactRow(context, Icons.location_on, address),
        _buildContactRow(context, Icons.phone, phone),
        _buildContactRow(context, Icons.email, email),
      ]),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(children: [
        Icon(icon, size: 14, color: context.colors.brandPrimary),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 12, color: context.colors.primaryText))),
      ]),
    );
  }

  // 这里的按钮我也帮你用主题色重构了
  Widget _buildActionButton(BuildContext context, String label, IconData icon, {required bool isPrimary, required VoidCallback onTap}) {
    final colors = context.colors;
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: isPrimary ? Colors.white : colors.brandPrimary),
        label: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: isPrimary ? Colors.white : colors.brandPrimary, fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? colors.brandPrimary : colors.surface,
          side: isPrimary ? null : BorderSide(color: colors.brandPrimary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout, color: Colors.white),
        label: Text("Log Out", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.error,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm"),
        content: const Text("Do you want to quit this app?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              mainGlobalKey.currentState?.logout();
            },
            child: Text("Yes", style: TextStyle(color: context.colors.error)),
          ),
        ],
      ),
    );
  }
}

class AcademicCalendarPage extends StatelessWidget {
  const AcademicCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 同样拿到颜色包
    final colors = context.colors;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: colors.brandPrimary, // 替换 kPrimaryBlue
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Academic Calendar",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.asset(
            'assets/image.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.broken_image, color: Colors.white, size: 50),
                  const SizedBox(height: 16),
                  Text(
                    "Image not found.\nPlease ensure 'assets/image.png' exists.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

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
}*/