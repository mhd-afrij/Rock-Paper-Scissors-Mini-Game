# flutter_rcs_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 🪨📄✂️ Rock Paper Scissors (Flutter)

A simple **Rock–Paper–Scissors** mobile game built with **Flutter**.  
It includes a modern UI, score tracking, animated result display, and a reset option.

---

## ✨ Features
- ✅ Rock / Paper / Scissors gameplay
- ✅ Random computer choice using `dart:math`
- ✅ Winner logic (Win / Lose / Draw)
- ✅ Scoreboard (Player vs Computer)
- ✅ Animated UI effects (Scale + Transform animations)
- ✅ Button highlight for selected choice
- ✅ Reset game button (clears score + UI)

---

## 🧠 How Winner Logic Works
The game compares the **user choice** and **computer choice**:
- If both are the same → **Draw**
- Otherwise, checks the 3 user win rules:
  - Rock beats Scissors
  - Paper beats Rock
  - Scissors beats Paper  
If none match → **Computer Wins**

---

## 🛠️ Tech Stack
- **Flutter**
- **Dart**
- Widgets: `StatefulWidget`, `ElevatedButton`, `Row`, `Column`, `Container`
- Animations: `AnimationController`, `ScaleTransition`, `AnimatedBuilder`

---

## 📸 Screenshots
> Add your screenshots in a folder like `assets/screenshots/` and link them here.

Example:
```md
![Home](assets/screenshots/home.png)
![Result](assets/screenshots/result.png)


