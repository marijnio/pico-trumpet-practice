# PICO-8 Trumpet Fingering & Partial Trainer

An interactive, game-like educational application for the **PICO-8 fantasy console**, specifically designed and optimized for retro handheld devices (such as the **ANBERNIC RG35XXSP**, Miyoo Mini, and similar devices) as well as desktop emulators and web players.

This tool helps trumpet players practice both **valve fingerings** and **air pressure partials** (representing embouchure and pitch targeting) across a chromatic range of 26 notes (from F#3 to G5) using a randomized practice engine.

---

## 🎺 Key Features

* **Complete Practice Range:** Practicing notes from low **F#3** up to high **G5**, covering the standard beginner-to-intermediate range of the trumpet.
* **Treble Clef Visualization:** Real-time rendering of notes on a musical staff with dynamic ledger lines for notes above/below the staff, plus sharp (`#`) and flat (`b`) accidentals.
* **Valve & Air Representation:**
  * **Valves:** Simulates the three physical trumpet valves.
  * **Air Pressure / Partials:** Simulates embouchure and air speed requirements by dividing notes into 5 air levels (harmonic partial groups).
* **Randomized Selection:** Every note in the range has an equal chance of appearing, providing a uniform practice distribution across the entire database.
* **Three Flexible Modes:** 
  * **Quiz Mode:** Tests your recall of both valve fingerings and air pressure levels using interactive controls on the device.
  * **Play-Along Mode (Hands-Free):** Specifically designed for practicing with your **actual trumpet** in hand. It guides you rhythmically using audio metronome clicks and pitches.
  * **Reference Mode:** Allows you to browse through all notes chronologically to review their correct fingerings and air levels.

---

## 🎮 Handheld & Emulator Controls

Since the application is designed to be played on handheld retro consoles (like the ANBERNIC RG35XXSP) and desktop computers, the controls are mapped to PICO-8 standard inputs:

| PICO-8 Input | Desktop Key | Handheld Button | Menu / Reference Action | Quiz Mode Action |
|---|---|---|---|---|
| **Left** | `Left Arrow` | **D-Pad Left** | Adjust settings (on menu) / Navigate Reference (Prev) | Toggle **Valve 1** (1st valve) |
| **Right** | `Right Arrow` | **D-Pad Right** | Adjust settings (on menu) / Navigate Reference (Next) | Toggle **Valve 3** (3rd valve) |
| **Up** | `Up Arrow` | **D-Pad Up** | Move Selection Up | Raise **Air Pressure** (if holding O/Button 1) |
| **Down** | `Down Arrow` | **D-Pad Down** | Move Selection Down | Toggle **Valve 2** (if O is *not* held) / Lower **Air Pressure** (if holding O) |
| **Button 1 (O)** | `Z` / `C` | **A** | Return to Menu | **Hold** to shift D-pad to air pressure control |
| **Button 2 (X)** | `X` / `V` | **B** | Confirm / Select | **Submit Answer** |

> [!NOTE]
> **Adjusting Air Pressure in Quiz Mode:** To change the air level indicator on the right side of the screen, **hold the A button (O key)** and press **D-Pad Up** or **D-Pad Down**. Letting go of the A button returns the D-pad to normal valve control.

---

## 🥁 Hands-Free Play-Along Mode

The **Play-Along Mode** is designed for practice sessions where you are holding and playing a physical trumpet. Because you cannot easily press valve combinations on the PICO-8 device while playing, this mode runs on a continuous **12-beat loop** (which is 12 seconds total per note at 60 BPM, scaling dynamically based on the configured menu tempo):

1. **Prepare Phase (Beats 1-4):**
   * The staff displays the target note.
   * The fingerings and air pressure indicators are hidden (marked with `?` or grayed out).
   * A metronome click plays on each beat to give you a count-in.
2. **Play Phase (Beats 5-8):**
   * Play the note on your physical trumpet!
   * The metronome continues clicking.
   * The console plays a sustained **reference pitch tone** corresponding to the note. Use this tone to guide your pitch target and intonation.
   * Fingerings remain hidden.
3. **Reveal Phase (Beats 9-12):**
   * The reference tone stops.
   * The correct valve fingerings and air pressure level are revealed on screen.
   * Verify your fingerings and partial against the diagram.

### Hands-Free Logging & Flagging:
- **No button presses needed for correct answers:** At the end of the 12 beats, if you do nothing, the system automatically grades the note as **correct** (adding to your score) and moves to the next note.
- **Trivial correction (one-tap flagging):** If you missed the note, cracked the partial, or used the wrong fingering, **press any button** (except `O` which exits) during the cycle. The screen will display `[FLAGGED WRONG]`, play a confirmation tone, and record the answer as wrong at the end of the cycle.
- **Exiting:** Press the **A button / O key** at any time to immediately stop the pitch drone and return to the main menu.

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
