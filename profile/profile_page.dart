import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// --- 全局配置与主题引入 ---
import '../main.dart';
import 'package:uthm/theme/app_colors.dart';

// --- 独立页面引入 ---
import 'academic_calendar_page.dart';
import 'virtual_id_page.dart';

// =======================================================
//           CLASS 1: PROFILE PAGE (Main Tab)
// =======================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // 2. Helper function to open the website
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            // 1. 底层：跟随页面一起滑动的蓝色渐变背景
            Container(
              height: 320,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colors.brandPrimary, colors.background],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),

            // 2. 表层：主体内容
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 右上角设置按钮
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 26),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 10),

                    // --- 1. 名片卡片 (点击跳转 Virtual ID) ---
                    const _GlassIdentityCard(),
                    const SizedBox(height: 24),

                    // --- 2. 14格切割式周进度 (一条进度条切成14格) ---
                    const _WeekGridProgress(),
                    const SizedBox(height: 16),

                    // --- 3. 四合一数据栏 (CGPA, GPA, Credits, Session 同一行) ---
                    const _StatsRowBar(),
                    const SizedBox(height: 24),

                    // --- 4. Student Details Card ---
                    _buildSectionLabel(context, "Student Details"),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: _buildCardDecoration(context),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            context,
                            Icons.domain,
                            "Faculty",
                            "FSKTM",
                            onTap: () => _launchURL("https://fsktm.uthm.edu.my/"),
                          ),
                          Divider(height: 30, color: colors.borderColor),
                          _buildInfoRow(context, Icons.school, "Course", "Bachelor of Computer Science\n(Multimedia Computing)"),
                          Divider(height: 30, color: colors.borderColor),
                          _buildInfoRow(context, Icons.email_outlined, "Email", "ai248888@student.uthm.edu.my"),
                          Divider(height: 30, color: colors.borderColor),
                          _buildInfoRow(context, Icons.phone_iphone, "Phone", "+60 12-345 6789"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- 5. Emergency Contact ---
                    Container(
                      decoration: _buildCardDecoration(context),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          leading: Icon(Icons.emergency_outlined, color: colors.error, size: 28),
                          title: Text(
                            "Emergency Contact",
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: colors.primaryText),
                          ),
                          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          children: [
                            Divider(height: 1, color: colors.borderColor),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Guardian: Lee Kah\nPhone: +60 17-999 8888",
                                style: GoogleFonts.poppins(color: colors.secondaryText, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- 6. Contact Us (Expandable List - 完整保留你原本的代码) ---
                    Container(
                      decoration: _buildCardDecoration(context),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          leading: Icon(
                            Icons.support_agent,
                            color: colors.brandPrimary,
                            size: 28,
                          ),
                          title: Text(
                            "Contact Us",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colors.primaryText,
                            ),
                          ),
                          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          children: [
                            Divider(height: 1, color: colors.borderColor),
                            const SizedBox(height: 20),
                            _buildContactCard(
                              context,
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
                            _buildSectionSubLabel(context, "Undergraduate (Diploma & Degree)"),
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
                            _buildSectionSubLabel(context, "International Student"),
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
                    const SizedBox(height: 30),

                    // --- 7. Action Buttons Area ---
                    Column(
                      children: [
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
                        _buildLogoutButton(context),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =======================================================
  // --- Helper Methods ---
  // =======================================================

  BoxDecoration _buildCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4))],
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: context.colors.primaryText)),
    );
  }

  Widget _buildSectionSubLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: context.colors.brandPrimary)),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, {VoidCallback? onTap}) {
    final colors = context.colors;
    Widget row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: colors.brandPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 20, color: colors.brandPrimary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.poppins(fontSize: 12, color: colors.secondaryText)),
              const SizedBox(height: 2),
              Text(value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: onTap != null ? colors.brandPrimary : colors.primaryText,
                    decoration: onTap != null ? TextDecoration.underline : null,
                    decorationColor: colors.brandPrimary,
                  )),
            ],
          ),
        ),
        if (onTap != null) Icon(Icons.open_in_new, size: 16, color: colors.brandPrimary),
      ],
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, behavior: HitTestBehavior.opaque, child: row);
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

// =======================================================
//   下方是独立的新 UI 组件
// =======================================================

// --- 玻璃拟物化身份卡片 ---
class _GlassIdentityCard extends StatelessWidget {
  const _GlassIdentityCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VirtualIdPage()),
        );
      },
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: colors.surface.withOpacity(0.75),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colors.borderColor.withOpacity(0.5)),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: colors.background,
                    backgroundImage: const AssetImage('assets/me.jpg'),
                  ),
                  const SizedBox(height: 12),
                  Text("LEE ROU", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: colors.primaryText)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colors.brandPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.qr_code_2, size: 16, color: colors.brandPrimary),
                        const SizedBox(width: 6),
                        Text("My Virtual ID", style: GoogleFonts.poppins(fontSize: 12, color: colors.brandPrimary, fontWeight: FontWeight.w600)),
                      ],
                    ),
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

// --- 14格切割式周进度 (一条进度条被切成14格) ---
class _WeekGridProgress extends StatelessWidget {
  const _WeekGridProgress();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    const int totalWeeks = 14;
    const int currentWeek = 8;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Week Progress", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: colors.primaryText, fontSize: 13)),
          const SizedBox(height: 2),
          Text("Week $currentWeek / $totalWeeks Total", style: GoogleFonts.poppins(color: colors.secondaryText, fontSize: 11)),
          const SizedBox(height: 12),

          // 核心修改：使用 ClipRRect 把整个 Row 包裹成一条完整的胶囊形状，内部用边框线“切割”
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // 外层大圆角（制造出“一条进度条”的感觉）
            child: Row(
              children: List.generate(totalWeeks, (index) {
                bool isCompleted = index < currentWeek;
                return Expanded(
                  child: Container(
                    height: 12, // 整个进度条的高度
                    decoration: BoxDecoration(
                      color: isCompleted ? colors.brandPrimary : colors.borderColor,
                      // 这里就是“切割线”，使用你的卡片背景色来制造断层感
                      border: index == totalWeeks - 1
                          ? null // 最后一格不需要切割线
                          : Border(right: BorderSide(color: colors.surface, width: 2.0)),
                    ),
                  ),
                );
              }),
            ),
          ),

        ],
      ),
    );
  }
}

// --- 四合一数据栏 (CGPA, GPA, Credits, Session 同一行) ---
class _StatsRowBar extends StatelessWidget {
  const _StatsRowBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatItem(context, "CGPA", "3.85"),
        const SizedBox(width: 8),
        _buildStatItem(context, "GPA", "3.90"),
        const SizedBox(width: 8),
        _buildStatItem(context, "Credits", "70/122"),
        const SizedBox(width: 8),
        _buildStatItem(context, "Session", "Sem 4", subLabel: "24/25"),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, {String? subLabel}) {
    final colors = context.colors;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Column(
          children: [
            Text(label, style: GoogleFonts.poppins(fontSize: 10, color: colors.secondaryText, fontWeight: FontWeight.w600), textAlign: TextAlign.center, maxLines: 1),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: colors.primaryText), textAlign: TextAlign.center, maxLines: 1),
            if (subLabel != null) ...[
              const SizedBox(height: 2),
              Text(subLabel, style: GoogleFonts.poppins(fontSize: 9, color: colors.secondaryText, fontWeight: FontWeight.w500)),
            ]
          ],
        ),
      ),
    );
  }
}