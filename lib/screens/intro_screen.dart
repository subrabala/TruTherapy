import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xFFBBCFC7),
                      image: DecorationImage(
                          image: AssetImage('assets/bg_mental.jpg'),
                          fit: BoxFit.cover)),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hello Claire!',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600, height: 1.5),
                      ),
                      Text('Good day yeah!',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(182, 0, 0, 0))),
                      Spacer(),
                      Text(
                        'Check out what we have lined up for you',
                        style: TextStyle(fontSize: 12, color: Colors.black45),
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 20)),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF0F273C)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))))),
                  child: const Text(
                    'Chat Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 20)),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF0F273C)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))))),
                  child: const Text(
                    'Schedule Call',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]),
            const Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [],
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SingleChildScrollView(),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF0F273C),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home_outlined, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.folder_outlined, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_outline, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
