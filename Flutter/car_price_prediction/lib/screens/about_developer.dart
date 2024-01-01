import 'package:flutter/material.dart';

class AboutDeveloperScreen extends StatelessWidget {
  static const routeName = '/about-developer';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AboutDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pop(context);
        }, //=> Navigator.of(context)
        //.pushReplacementNamed(ProductsScreen.routeName),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 255, 243, 23),
            ),
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.add_to_home_screen)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 38, 38, 38),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/Bilal.png',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bilal Tariq',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(140, 140, 140, 1),
                  ),
                ),
                const Text(
                  'CEO - BrainDev Inc.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color.fromRGBO(140, 140, 140, 1),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Text(
                    '"Welcome to the world of cutting-edge technology and innovation! As a passionate tech enthusiast with a keen interest in Data Science, Mobile App development, and MERN stack, I thrive on exploring the limitless possibilities at the intersection of code and creativity. From unraveling the mysteries of data to crafting seamless mobile experiences and diving deep into MERN development, I am dedicated to staying ahead of the curve in the ever-evolving tech landscape."',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(140, 140, 140, 1),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/github.png',
                            width: 30,
                          ),
                          const Text(
                            'bilaltariq360',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/linked-in.png',
                            width: 28,
                          ),
                          const Text(
                            'ibilaltariq',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/threads.png',
                            width: 25,
                          ),
                          const Text(
                            'ibilaltariq',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/Haseeb.png',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Haseeb Ashraf',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(140, 140, 140, 1),
                  ),
                ),
                const Text(
                  'CEO - ByteSoft Inc.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color.fromRGBO(140, 140, 140, 1),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Text(
                    '"Hello, I am a tech enthusiast with a keen interest in the fascinating realms of technology. Currently specializing in Data Analysis, I am driven by the curiosity to unravel insights from data and translate them into actionable strategies. My academic background and practical experiences have equipped me with the skills to navigate the dynamic field of data analytics. Eager to contribute my analytical prowess to drive informed decision-making, I am passionate about harnessing the power of data to shape a smarter and more connected world."',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(140, 140, 140, 1),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/github.png',
                            width: 30,
                          ),
                          const Text(
                            'muhammad-haseeb',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/linked-in.png',
                            width: 28,
                          ),
                          const Text(
                            'muhammad-haseeb',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/threads.png',
                            width: 25,
                          ),
                          const Text(
                            'muhammad-haseeb',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/Umar.png',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Umar Bilal',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(140, 140, 140, 1),
                  ),
                ),
                const Text(
                  'CEO - CGA Inc.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color.fromRGBO(140, 140, 140, 1),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Text(
                    '"Greetings everyone! I am thrilled to introduce myself as an aspiring undergraduate in the field of Computer Science. With a genuine passion for all things tech, I have eagerly immersed myself in the world of coding and problem-solving. This journey has not only provided me with a strong foundation in programming but has also nurtured my ability to approach challenges with creativity and a strategic mindset."',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(140, 140, 140, 1),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/github.png',
                            width: 30,
                          ),
                          const Text(
                            'umarbilalkhan',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/linked-in.png',
                            width: 28,
                          ),
                          const Text(
                            'umarbilal',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/threads.png',
                            width: 25,
                          ),
                          const Text(
                            'umar.b.niazi',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              color: Color.fromRGBO(76, 76, 76, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
