import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portofoli/widgets/contact_form.dart';
import 'package:my_portofoli/widgets/social_media_icons.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ali Raslan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // fontFamily: 'Poppins',
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
  final Color navyColor = const Color(0xFF001F3F);
  final Color skyBlueColor = const Color(0xFF87CEEB);
  final Color lightBlueColor = const Color(0xFFE6F7FF);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    timeDilation = 1.5; // Slow down animations for demo
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(),
          _buildHeroSection(),
          _buildSkillsSection(),
          _buildProjectsSection(),
          _buildContactSection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: navyColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            const FaIcon(FontAwesomeIcons.fileLines, color: Colors.white),
            SizedBox(
              height: 5,
            ),
            Text(
              "CV",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        onPressed: () async {
          await launchUrl(Uri.parse(
              'https://drive.google.com/file/d/1XB2UP3P81UIyk68rsrpNzoaoEhr1nmIH/view?usp=drive_link'));
        },
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100.0,
      backgroundColor: navyColor,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.025,
              ),
              const Text('Ali Raslan', style: TextStyle(color: Colors.white)),
              const Spacer(),
              if (MediaQuery.of(context).size.width > 600)
                Row(
                  children: [
                    _NavButton(
                        text: 'Home',
                        onTap: () => _scrollController.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut)),
                    _NavButton(
                        text: 'Skills',
                        onTap: () => _scrollController.animateTo(
                            MediaQuery.of(context).size.height,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut)),
                    _NavButton(
                        text: 'Projects',
                        onTap: () => _scrollController.animateTo(
                            MediaQuery.of(context).size.height * 1.8,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut)),
                    _NavButton(
                        text: 'Contact',
                        onTap: () => _scrollController.animateTo(
                            MediaQuery.of(context).size.height * 2.8,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut)),
                  ],
                ),
              if (MediaQuery.of(context).size.width <= 600)
                PopupMenuButton<String>(
                  surfaceTintColor: skyBlueColor,
                  color: navyColor,
                  icon: const Icon(Icons.menu, color: Colors.white),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'Home',
                        child: Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        )),
                    const PopupMenuItem(
                        value: 'Skills',
                        child: Text('Skills',
                            style: TextStyle(color: Colors.white))),
                    const PopupMenuItem(
                        value: 'Projects',
                        child: Text('Projects',
                            style: TextStyle(color: Colors.white))),
                    const PopupMenuItem(
                        value: 'Contact',
                        child: Text('Contact',
                            style: TextStyle(color: Colors.white))),
                  ],
                  onSelected: (value) {
                    double offset = 0;
                    switch (value) {
                      case 'Home':
                        offset = 0;
                        break;
                      case 'Skills':
                        offset = MediaQuery.of(context).size.height;
                        break;
                      case 'Projects':
                        offset = MediaQuery.of(context).size.height * 3.2;
                        break;
                      case 'Contact':
                        offset = MediaQuery.of(context).size.height * 5.8;
                        break;
                    }
                    _scrollController.animateTo(
                      offset,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
            ],
          ),
        ),
        centerTitle: true,
        background: Container(color: navyColor),
      ),
    );
  }

  SliverToBoxAdapter _buildHeroSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [navyColor, skyBlueColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              right: 50,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Icon(Icons.code,
                    size: 100, color: Colors.white.withOpacity(0.1)),
              ),
            ),
            Positioned(
              top: 50,
              left: 100,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Icon(Icons.four_g_plus_mobiledata_outlined,
                    size: 100, color: Colors.white.withOpacity(0.1)),
              ),
            ),
            Positioned(
              top: 250,
              left: MediaQuery.of(context).size.width * 0.9,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Icon(Icons.wifi,
                    size: 100, color: Colors.white.withOpacity(0.1)),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 50,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: -_controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Icon(Icons.important_devices,
                    size: 80, color: Colors.white.withOpacity(0.1)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                          "assets/images/Ali.jpeg") // Add your profile image
                      ),
                  const SizedBox(height: 30),
                  Text(
                    'ALi Sayed Raslan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Software Engineer (Flutter Developer)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text(
                      'Software Engineer as Mobile App Developer( Flutter Developer) \n Make a responsive mobile Apps , web applications and Desktop applictations with Flutter. Passionate about Develope perfect UI/UX , Build App with Best Performance , High level of Security and clean code architecture.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: navyColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      _scrollController.animateTo(
                        MediaQuery.of(context).size.height * 3.5,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      'Hire Me',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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

  SliverToBoxAdapter _buildSkillsSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        color: lightBlueColor,
        child: Column(
          children: [
            const Text(
              'My Skills',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 100,
              height: 4,
              color: skyBlueColor,
            ),
            const SizedBox(height: 50),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildSkillItems(),
                  );
                } else {
                  return Column(
                    children: _buildSkillItems(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSkillItems() {
    final skills = [
      {
        'icon': Icons.mobile_friendly,
        'name': 'Mobile Development',
        'level': 95
      },
      {'icon': Icons.api, 'name': 'API Integration', 'level': 90},
      {'icon': Icons.cloud, 'name': 'Firebase', 'level': 90},
      {'icon': Icons.web, 'name': 'Web Development', 'level': 85},
      {'icon': Icons.design_services, 'name': 'Graphic Design', 'level': 80},
    ];

    return skills.map((skill) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: SkillCard(
          icon: skill['icon'] as IconData,
          skillName: skill['name'] as String,
          percentage: skill['level'] as int,
          color: navyColor,
          secondaryColor: skyBlueColor,
        ),
      );
    }).toList();
  }

  SliverToBoxAdapter _buildProjectsSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        color: Colors.white,
        child: Column(
          children: [
            const Text(
              'My Projects',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 100,
              height: 4,
              color: skyBlueColor,
            ),
            const SizedBox(height: 50),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                ProjectCard(
                  title: 'Agro',
                  description:
                      'A complete Ai solution for Detect wheat disease and provide appropiate treatment , display information about wheat and agricultural  , profiling',
                  techStack: 'Flutter, Firebase, AI , Multi languge',
                  imageUrl: 'assets/images/Moc.jpg',
                  color: navyColor,
                  accentColor: skyBlueColor,
                  SourceCodeLink: "https://github.com/Aly-exe/Agro",
                ),
                ProjectCard(
                  title: 'Kora Byte',
                  description: 'A Worldwide Sports news and matches times App',
                  techStack:
                      'Api’s, Web scraping, Firebase Cloud Messaging, Firebase Crashlytics, Bloc',
                  imageUrl:
                      'assets/images/korabytePoster.png', // Add your image
                  color: navyColor,
                  accentColor: skyBlueColor,
                  SourceCodeLink: "https://github.com/Aly-exe/Kora_Byte",
                ),
                ProjectCard(
                  title: 'Quiz Me App',
                  description:
                      'A dynamic Quiz App that delivers a set of 10 multiple-choice questions from various science categories',
                  techStack:
                      'Dart , Flutter, Stateless Widget, Stateful Widget',
                  imageUrl: 'assets/images/QuizApp.png', // Add your image
                  color: navyColor,
                  accentColor: skyBlueColor,
                  SourceCodeLink: "https://github.com/Aly-exe/Quiz_App",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContactSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        color: navyColor,
        child: Column(
          children: [
            const Text(
              'Get In Touch',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 100,
              height: 4,
              color: skyBlueColor,
            ),
            const SizedBox(height: 50),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Have a project in mind or want to discuss potential opportunities? Feel free to reach out!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 30),
                    ContactForm(
                      primaryColor: navyColor,
                      accentColor: skyBlueColor,
                    ),
                    const SizedBox(height: 30),
                    SocialMediaIcons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _NavButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final IconData icon;
  final String skillName;
  final int percentage;
  final Color color;
  final Color secondaryColor;

  const SkillCard({
    super.key,
    required this.icon,
    required this.skillName,
    required this.percentage,
    required this.color,
    required this.secondaryColor,
  });

  @override
  _SkillCardState createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: widget.percentage / 100).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(widget.icon, size: 50, color: widget.color),
                const SizedBox(height: 20),
                Text(
                  widget.skillName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: widget.secondaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 160 * _animation.value,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.percentage}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String techStack;
  final String imageUrl;
  final Color color;
  final Color accentColor;
  final String SourceCodeLink;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.techStack,
    required this.imageUrl,
    required this.color,
    required this.accentColor,
    required this.SourceCodeLink,
  });

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 350,
        height: _isHovered ? 550 : 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(_isHovered ? 0.3 : 0.1),
              blurRadius: _isHovered ? 20 : 10,
              spreadRadius: _isHovered ? 5 : 2,
              offset: Offset(0, _isHovered ? 10 : 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                height: 200,
                color: widget.accentColor.withOpacity(0.2),
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: 350,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tech Stack:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.color,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.techStack,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedOpacity(
                    opacity: _isHovered ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: widget.color,
                        //     foregroundColor: Colors.white,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //   ),
                        //   onPressed: () {},
                        //   child: const Text('View Project'),
                        // ),
                        // const SizedBox(width: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: widget.color,
                            side: BorderSide(color: widget.color),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            await launchUrl(Uri.parse(widget.SourceCodeLink));
                          },
                          child: const Text('Source Code'),
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
