import 'package:flutter/material.dart';
import 'package:uthm/theme/app_colors.dart';

// --- 引入我们刚刚拆分的所有组件 ---
import 'components/profile_widgets.dart';
import 'components/profile_cards.dart';
import 'components/profile_buttons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // ==========================================
          // 图层 1：可滑动的主体内容（包含背景）
          // ==========================================
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              clipBehavior: Clip.none, // 允许超出边界绘制，掩盖下拉白边
              children: [
                // 下拉回弹防白边补丁块
                Positioned(
                  top: -1000,
                  left: 0,
                  right: 0,
                  height: 1000,
                  child: Container(color: colors.brandPrimary),
                ),

                // 跟着页面一起滑动的渐变背景
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [colors.brandPrimary, colors.background],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),

                // 主体 UI 排版，现在变得极其清爽！
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 60), // 给右上角的悬浮设置按钮留出空间

                        GlassIdentityCard(),
                        SizedBox(height: 18),

                        WeekGridProgress(),
                        SizedBox(height: 18),

                        StatsRowBar(),
                        SizedBox(height: 18),

                        StudentDetailsCard(),
                        SizedBox(height: 18),

                        NextOfKinCard(),
                        SizedBox(height: 18),

                        ContactUsCard(),
                        SizedBox(height: 24),

                        AcademicCalendarButton(),
                        SizedBox(height: 16),

                        LogoutButton(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // 图层 2：固定在右上角的设置按钮 (悬浮窗)
          // ==========================================
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 20,
            child: const SettingsButton(),
          ),
        ],
      ),
    );
  }
}