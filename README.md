# PICO-8 Trumpet Fingering & Partial Trainer

An interactive, game-like educational application for the **PICO-8 fantasy console**, specifically designed and optimized for retro handheld devices (such as the **ANBERNIC RG35XXSP**, Miyoo Mini, and similar devices) as well as desktop emulators and web players.

This tool helps trumpet players practice both **valve fingerings** and **air pressure partials** (representing embouchure and pitch targeting) across a chromatic range of 26 notes (from F#3 to G5) using an adaptive learning algorithm.

---

## 🎺 Key Features

* **Complete Practice Range:** Practicing notes from low **F#3** up to high **G5**, covering the standard beginner-to-intermediate range of the trumpet.
* **Treble Clef Visualization:** Real-time rendering of notes on a musical staff with dynamic ledger lines for notes above/below the staff, plus sharp (`#`) and flat (`b`) accidentals.
* **Valve & Air Representation:**
  * **Valves:** Simulates the three physical trumpet valves.
  * **Air Pressure / Partials:** Simulates embouchure and air speed requirements by dividing notes into 5 air levels (harmonic partial groups).
* **Spaced Repetition System (SRS):** Every note has an adjustable weight ($w$). When you guess a note correctly, its weight decreases (making it less frequent); when you get it wrong, its weight increases (making it repeat more often).
* **Reference & Quiz Modes:** 
  * **Quiz Mode:** Tests your recall of both valve fingerings and air pressure levels.
  * **Reference Mode:** Allows you to browse through all notes chronologically to review their correct fingerings and air levels.

---

## 🎮 Handheld & Emulator Controls

Since the application is designed to be played on handheld retro consoles (like the ANBERNIC RG35XXSP) and desktop computers, the controls are mapped to PICO-8 standard inputs:

| PICO-8 Input | Desktop Key | Handheld Button | Menu / Reference Action | Quiz Mode Action |
|---|---|---|---|---|
| **Left** | `Left Arrow` | **D-Pad Left** | Navigate Reference (Prev) | Toggle **Valve 1** (1st valve) |
| **Right** | `Right Arrow` | **D-Pad Right** | Navigate Reference (Next) | Toggle **Valve 3** (3rd valve) |
| **Up** | `Up Arrow` | **D-Pad Up** | Move Selection Up | Raise **Air Pressure** (if holding X/Button 2) |
| **Down** | `Down Arrow` | **D-Pad Down** | Move Selection Down | Toggle **Valve 2** (if X is *not* held) / Lower **Air Pressure** (if holding X) |
| **Button 1 (O)** | `Z` / `C` | **A** | Confirm / Select | **Submit Answer** |
| **Button 2 (X)** | `X` / `V` | **B** | Return to Menu | **Hold** to shift D-pad to air pressure control |

> [!NOTE]
> **Adjusting Air Pressure in Quiz Mode:** To change the air level indicator on the right side of the screen, **hold the B button (X key)** and press **D-Pad Up** or **D-Pad Down**. Letting go of the B button returns the D-pad to normal valve control.

---

## 🎼 The Note & Air Pressure Database

In trumpet playing, multiple notes share the exact same valve combinations (e.g., open `0-0-0` is used for C4, G4, C5, and E5). To play them, a trumpeter must change their lip tension and air velocity. 

This application represents this mechanic via **Air levels (1–5)**:

* **Level 1 (1st Partial Group):** F#3 to C4 (e.g., Low C is open `0-0-0` on Air 1)
* **Level 2 (2nd Partial Group):** C#4 to G4 (e.g., G4 is open `0-0-0` on Air 2)
* **Level 3 (3rd Partial Group):** G#4 to C5 (e.g., C5 is open `0-0-0` on Air 3)
* **Level 4 (4th Partial Group):** C#5 to E5 (e.g., E5 is open `0-0-0` on Air 4)
* **Level 5 (5th Partial Group):** F5 to G5 (e.g., G5 is open `0-0-0` on Air 5)

---

## 🧠 Spaced Repetition (SRS) Engine

The program uses an adaptive learning algorithm based on weight adjustment:

1. All notes start with a base difficulty weight of `1.0`.
2. The trainer selects notes using weighted random distribution:
   $$\text{Probability}(N) = \frac{w_N}{\sum w_i}$$
3. **Correct Answer:** Decreases the note weight by 50% (down to a minimum of `0.2`), making it appear less often.
4. **Incorrect Answer:** Increases the note weight by `2.0` (up to a maximum of `10.0`), prompting the system to repeat it until you master it.
5. The weight ($w$) of the currently active note is displayed in the top-left corner during practice.

---

## 🛠️ Installation on Retro Handhelds (e.g., RG35XXSP)

To install this cart on your ANBERNIC RG35XXSP or other devices running CFW (like Knulli, MuOS, or MinUI):

1. **Locate your ROMs folder:** Connect your SD card to your computer and navigate to the `roms/pico8/` directory.
2. **Copy the file:** Copy the `main.p8` cart (or rename it to `pico-trumpet-practice.p8`) into the directory.
3. **Execute:** 
   * Launch your device, refresh your game list, and select **PICO-8** / **pico-trumpet-practice**.
   * Alternatively, if using the official PICO-8 binary under the hood, place it in your carts folder and load it in the console command line using:
     ```text
     load pico-trumpet-practice.p8
     run
     ```
