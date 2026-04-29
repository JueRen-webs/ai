import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uthm/theme/app_colors.dart';
import 'virtual_id_page.dart'; // 引入同一层的 Virtual ID 页面

// --- 带有光圈和 Hover 效果的专属设置按钮 ---
class SettingsButton extends StatefulWidget {
  const SettingsButton({super.key});
  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () { /* 点击事件 */ },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovering ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.15),
            border: Border.all(
              color: Colors.white.withOpacity(_isHovering ? 0.8 : 0.4),
              width: 1.5,
            ),
            boxShadow: _isHovering ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))] : [],
          ),
          child: const Icon(Icons.settings_outlined, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

// --- 玻璃拟物化身份卡片 ---
class GlassIdentityCard extends StatelessWidget {
  const GlassIdentityCard({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const VirtualIdPage()));
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 10))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(radius: 30, backgroundColor: colors.background, backgroundImage: const AssetImage('assets/me.jpg')),
                    const SizedBox(height: 8),
                    Text("LEE ROU", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: colors.brandPrimary)),
                    const SizedBox(height: 2),
                    Text("(Matrics Number: AI230199)", style: GoogleFonts.poppins(fontSize: 12, color: colors.brandPrimary.withOpacity(0.8))),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: colors.brandPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.qr_code_2, size: 14, color: colors.brandPrimary),
                          const SizedBox(width: 4),
                          Text("My Virtual ID", style: GoogleFonts.poppins(fontSize: 11, color: colors.brandPrimary, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- 14格独立小圆角正方形周进度 ---
class WeekGridProgress extends StatelessWidget {
  const WeekGridProgress({super.key});
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
          boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Week Progress", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: colors.primaryText, fontSize: 13)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: colors.brandPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Text("Week $currentWeek / $totalWeeks", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: colors.brandPrimary, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (int i = 0; i < totalWeeks; i++) ...[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: i < currentWeek ? colors.brandPrimary : colors.brandPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                if (i < totalWeeks - 1) const SizedBox(width: 5),
              ]
            ],
          ),
        ],
      ),
    );
  }
}

// --- 四合一数据栏 ---
class StatsRowBar extends StatelessWidget {
  const StatsRowBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatItem(context, "Current\nCPA", "3.85"),
        const SizedBox(width: 12),
        _buildStatItem(context, "Current\nGPA", "3.90"),
        const SizedBox(width: 12),
        _buildStatItem(context, "Obtained\nCredit", "70/122"),
        const SizedBox(width: 12),
        _buildStatItem(context, "Current\nSession","Y2S2"),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, {String? subLabel}) {
    final colors = context.colors;
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4))]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: GoogleFonts.poppins(fontSize: 9, height: 1.1, color: colors.secondaryText, fontWeight: FontWeight.w600), textAlign: TextAlign.center, maxLines: 2),
              const SizedBox(height: 2),
              Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: colors.primaryText), textAlign: TextAlign.center, maxLines: 1),
              if (subLabel != null) ...[
                const SizedBox(height: 2),
                Text(subLabel, style: GoogleFonts.poppins(fontSize: 9, color: colors.secondaryText, fontWeight: FontWeight.w500)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}