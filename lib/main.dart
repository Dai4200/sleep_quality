import 'package:flutter/material.dart';

List greatMessages = ['Great you got your 8 hours; Can you keep this up? Recommendations: Maintain sleep routines; Keep practicing good sleep hygiene'];
List mehMessages = ['Could be better; Maybe avoid Red Bull, it gives you wings when you need to rest more Recommendations: Consider relaxing before: Meditation techniques and breathing exercises; Try limiting caffeine/alcohol intake'];
List dangMessages = [ 'Go back to bed you bozo; Catch some Z’s Recommendations: Start establishing a consistent sleep schedule; Reduce screen time before bed; Consult a healthcare professional if condition persistent'];

class Person {
  //Screen 1
  String name;
  String age;
  double score = 0;

  //Screen 2
  String hoursSlept = '< 5';
  double restful = 0.0;
  double wakeUp = 0.0;
  double difficulty = 0.0;

  // Screen 3
  Answer? electronicsAnswer;
  Answer? environmentAnswer;
  Answer? consumeAnswer;
  Answer? exerciseAnswer;

  // Screen 4
  Answer? breathingAnswer;
  Answer? dreamAnswer;
  Answer? disturbanceAnswer;

  Person(this.name, this.age);

  //helper function
  void yesGood(Answer? a, double points) {
    if (a == Answer.yes) {
      score += points;
    }
  }

  void yesBad(Answer? a, double points) {
    if (a == Answer.no) {
      score += points;
    }
  }

  double calc_sleep_score() {
    score = 0;

    //HOURS SLEPT
    if (hoursSlept == '5 - 6') {
      score += 10;
    } else if (hoursSlept == '6 - 7' || hoursSlept == '8 +') {
      score += 15;
    } else if (hoursSlept == '7 - 8') {
      score += 25;
    }

    //RESTFUL
    score += (restful * 1.5);

    //WAKEUP
    score += (20 - (wakeUp * 5));

    //DIFFICULTY
    score += (15 - (difficulty * 1.5));

    //Sleep Environments/habits
    yesBad(electronicsAnswer, 2.5);
    yesGood(environmentAnswer, 2.5);
    yesBad(consumeAnswer, 2.5);
    yesGood(exerciseAnswer, 2.5);

    //Sleep Issues and Symptoms
    yesBad(breathingAnswer, 5);
    yesBad(dreamAnswer, 5);
    yesBad(disturbanceAnswer, 5);

  //'31-50', '51-65', '66+'
    if (age == '31-50'){
      score *= .95;
    }
    else if (age == '51-65'){
      score *= .9;
    }
    else if (age == '66+'){
      score *= .85;
    }

    //this.score
    return score;
  }
}

enum Answer { yes, no }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleep Quest',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 3, 41, 60)),
        scaffoldBackgroundColor: Color.fromARGB(255, 96, 64, 128),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 200, 191, 231),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 200, 191, 231),
            foregroundColor: Colors.black,
          ),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Color.fromARGB(255, 200, 191, 231),
          thumbColor: Color(0xFFFFFF66),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            color: Color(0xFFFFFF66),
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFF66),
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Color(0xFFFFFF66)),
        ),
      ),

      home: const MyHomePage(title: 'Sleep Quest'),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final Person person;

  const SecondScreen({super.key, required this.person});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class ThirdScreen extends StatefulWidget {
  final Person person;

  const ThirdScreen({super.key, required this.person});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class FourthScreen extends StatefulWidget {
  final Person person;

  const FourthScreen({super.key, required this.person});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class FinalScreen extends StatefulWidget {
  final double score;

  const FinalScreen({super.key, required this.score});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  String age = '16-30';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 96, 64, 128),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 191, 231),
        title: Row(children: [Icon(Icons.nightlight), Text("Sleep Quest")]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              "Helping you achieve better sleep",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: const Color.fromARGB(255, 255, 255, 102),
              ),
            ),
            Text(
              "Before we begin, we need to collect basic info",
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 255, 255, 102),
              ),
            ),
            SizedBox(height: 180),
            Padding(
              padding: EdgeInsets.all(10),
              child: _buildTextField(nameController, 'Name'),
            ),

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Age: ", style: TextStyle(fontSize: 16)),
                ),

                DropdownButton<String>(
                  dropdownColor: const Color.fromARGB(255, 200, 191, 231),
                  value: age,
                  items: ['16-30', '31-50', '51-65', '66+'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      age = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 180),
            ElevatedButton(
              onPressed: () {
                Person person = Person(nameController.text, age);
                print("Name: ");
                print(person.name);
                print("Age: ");
                print(person.age);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(person: person),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

//THIS IS THE SECOND SCREEN

class _SecondScreenState extends State<SecondScreen> {
  double restful = 0.0;
  double wakeUp = 0.0;
  double difficulty = 0.0;

  String hoursSlept = "< 5";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Icon(Icons.nightlight), Text("Sleep Quest")]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome ${widget.person.name}",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Here\'s a list of questions to assess your sleep quality',
                ),
                SizedBox(height: 20),

                Text(
                  "Sleep Duration",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "How many hours did you sleep last night (rough hourly estimate): ",
                      ),
                    ),
                    DropdownButton<String>(
                      dropdownColor: const Color.fromARGB(255, 200, 191, 231),
                      value: hoursSlept,
                      items: ['< 5', '5 - 6 ', '6 - 7', '7 - 8', '8 +'].map((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          hoursSlept = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  "Sleep Quality (On a scale rating)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                SizedBox(height: 20),
                Text("How restful was your sleep?"),
                Slider(
                  value: restful,
                  min: 0,
                  max: 10,
                  divisions: 10, // creates steps
                  label: restful.round().toString(),
                  onChanged: (newValue) {
                    setState(() {
                      restful = newValue;
                    });
                  },
                ),

                Text("How many times you wake up during the night?"),
                Slider(
                  value: wakeUp,
                  min: 0,
                  max: 4,
                  divisions: 4, // creates steps
                  label: wakeUp.round().toString(),
                  onChanged: (newValue) {
                    setState(() {
                      wakeUp = newValue;
                    });
                  },
                ),
                Text("How difficult was it for you to fall asleep?"),
                Slider(
                  value: difficulty,
                  min: 0,
                  max: 10,
                  divisions: 10, // creates steps
                  label: difficulty.round().toString(),
                  onChanged: (newValue) {
                    setState(() {
                      difficulty = newValue;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: Text("Previous"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    print(widget.person.name);
                    widget.person.hoursSlept = hoursSlept;
                    widget.person.restful = restful;
                    widget.person.wakeUp = wakeUp;
                    widget.person.difficulty = difficulty;
                    print(widget.person.hoursSlept);
                    print(widget.person.restful);
                    print(widget.person.wakeUp);
                    print(widget.person.difficulty);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ThirdScreen(person: widget.person),
                      ),
                    );
                  },

                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//THIS IS THE THIRD SCREEN
class _ThirdScreenState extends State<ThirdScreen> {
  Answer? electronicsAnswer;
  Answer? environmentAnswer;
  Answer? consumeAnswer;
  Answer? exerciseAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Icon(Icons.nightlight), Text("Sleep Quest")]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Here\'s some more questions'),
                SizedBox(height: 20),
                Text(
                  "Sleep Environment & Habits",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                SizedBox(height: 20),
                buildYesNoQuestion(
                  question: "Did you use any electronics before bed?",
                  groupValue: electronicsAnswer,
                  onChanged: (value) {
                    setState(() {
                      electronicsAnswer = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildYesNoQuestion(
                      question:
                          "Did you maintain a good sleeping environment (ideally dark and quiet bedroom)? ",
                      groupValue: environmentAnswer,
                      onChanged: (value) {
                        setState(() {
                          environmentAnswer = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildYesNoQuestion(
                      question:
                          "Did you consume any caffeine/alcohol close to bedtime?",
                      groupValue: consumeAnswer,
                      onChanged: (value) {
                        setState(() {
                          consumeAnswer = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildYesNoQuestion(
                      question: "Did you exercise before sleeping? ",
                      groupValue: exerciseAnswer,
                      onChanged: (value) {
                        setState(() {
                          exerciseAnswer = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    // later: calculate sleep score
                  },

                  child: Text("Previous"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    print(widget.person.name);
                    widget.person.electronicsAnswer = electronicsAnswer;
                    widget.person.environmentAnswer = environmentAnswer;
                    widget.person.consumeAnswer = consumeAnswer;
                    widget.person.exerciseAnswer = exerciseAnswer;
                    print(widget.person.electronicsAnswer);
                    print(widget.person.environmentAnswer);
                    print(widget.person.consumeAnswer);
                    print(widget.person.exerciseAnswer);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FourthScreen(person: widget.person),
                      ),
                    );
                    // later: calculate sleep score
                  },

                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//THIS IS THE Fourth SCREEN
class _FourthScreenState extends State<FourthScreen> {
  String hoursSlept = "< 5";
  Answer? breathingAnswer;
  Answer? dreamAnswer;
  Answer? disturbanceAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Icon(Icons.nightlight), Text("Sleep Quest")]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Sleep Issues and Symptoms",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildYesNoQuestion(
                      question:
                          "Do you tend to snore or have difficulty breathing? ",
                      groupValue: breathingAnswer,
                      onChanged: (value) {
                        setState(() {
                          breathingAnswer = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildYesNoQuestion(
                      question:
                          "Did you recently experience nightmares or vivid dreams? ",
                      groupValue: dreamAnswer,
                      onChanged: (value) {
                        setState(() {
                          dreamAnswer = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildYesNoQuestion(
                      question:
                          "Any signs of sleep paralysis or disturbances preventing you from sleeping? ",
                      groupValue: disturbanceAnswer,
                      onChanged: (value) {
                        setState(() {
                          disturbanceAnswer = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    // later: calculate sleep score
                  },

                  child: Text("Previous"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    widget.person.breathingAnswer = breathingAnswer;
                    widget.person.dreamAnswer = dreamAnswer;
                    widget.person.disturbanceAnswer = disturbanceAnswer;
                    print(widget.person.breathingAnswer);
                    print(widget.person.dreamAnswer);
                    print(widget.person.disturbanceAnswer);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalScreen(
                          score: widget.person.calc_sleep_score(),
                        ),
                      ),
                    );
                    // later: calculate sleep score
                  },

                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//THIS IS THE Fourth SCREEN
class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Icon(Icons.nightlight), Text("Sleep Quest")]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Sleep Quality Score and Recommendations ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.score.toString(), style: Theme.of(context).textTheme.titleLarge)
                  ]
                  ),
                  SizedBox(height: 20),
                  if (widget.score > 85)...[
                    Text('Great you got your 8 hours'),
                    Text('Can you keep this up?'), 
                    Text('Your Quest: Maintain sleep routines; Keep practicing good sleep hygiene'),
                    Image.network('https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExYzY0NjhtNTV3aXM0bHF5b3J5ZG84aTV6N3B0M2R6Z2VsNzFxOGhjaiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ulBv4BHX2t5TI31i0E/giphy.gif')
                    ]
                  else if (widget.score > 60)...[
                    Text("Could be better..."), Text("Maybe avoid Red Bull, it gives you wings when you need to rest more."), Text("Recommendations: Consider relaxing before; Meditation techniques and breathing exercises; Try limiting caffeine/alcohol intake"),
                    SizedBox(height: 20),
                    Image.network('https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2p3aGI0dXZrb210anp3NW16amxwM3Roa2R4NmIxZnB4NGxyNnNrcyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/mF4k0YXIHDHzy/giphy.gif')]
                  else
                    Image.network('https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExbmRoeTZpNzNvcTMxbW9ibGY4N2Uxc2NwYnQ0eXkzeHM5OTZjaGw2MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Enr4bc3JeOOzHLYY8R/giphy.gif')
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: Text("Previous"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Sleep Quest'),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },

                  child: Text("Try Again?"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String label) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 102)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 102)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 102)),
      ),
      hintText: 'Enter text',
      hintStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 102)),
    ),
    cursorColor: const Color.fromARGB(255, 255, 255, 102),
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: const Color.fromARGB(255, 255, 255, 102), // text color
    ),
  );
}

Widget buildYesNoQuestion({
  required String question,
  required Answer? groupValue,
  required Function(Answer?) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(question),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio<Answer>(
                value: Answer.yes,
                groupValue: groupValue,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color.fromARGB(255, 255, 255, 102);
                  }
                  return Colors.white;
                }),
                onChanged: onChanged,
              ),
              Text("Yes"),
            ],
          ),
          SizedBox(width: 20),
          Row(
            children: [
              Radio<Answer>(
                value: Answer.no,
                groupValue: groupValue,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color.fromARGB(255, 255, 255, 102);
                  }
                  return Colors.white;
                }),
                onChanged: onChanged,
              ),
              Text("No"),
            ],
          ),
        ],
      ),
    ],
  );
}
