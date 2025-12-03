# Sound Processing in Matlab
### ENGR 30503 – Signals and Systems  
### Texas Christian University – Fall 2025  

This repository implements digital sound synthesis and signal processing in **MATLAB**. It covers musical note generation, DTMF dialing, ADSR instrument envelopes, melody playback, and frequency analysis using the Fourier Transform.

Make sure to extract all the files from the zip before running them or they won't be able to use the codependent files
This also means all of the files must remain in the same directory to work properly

# Order to run files:
1. Telephone.m
2. MusicalScales.m
3. PlayingNotes.m
4. PlayingSong_Part_E.mlapp -- If it doesn't work use the PlayingSongBackup.m file
5. frequency_estimation.m -- Run as function
6. mpeg_detector.m -- optional, did for fun

---

## 📚 Project Overview

This project explores how sound can be digitally created and manipulated as 1D signals in MATLAB. Core topics include:

- Generating sinusoidal tones
- Combining and modifying sound signals
- Building musical scales
- Applying **ADSR** (Attack–Decay–Sustain–Release) envelopes
- Simulating **telephone DTMF dialing**
- Playing songs like *Twinkle, Twinkle, Little Star*
- Frequency analysis with the **FFT**

---

## ✅ Features

| Module | Description |
|--------|-------------|
| Musical Note Synthesis | Generate tones using equal-tempered scale |
| ADSR Envelope | Apply instrument amplitude shaping |
| DTMF Dialing | Simulate 10-digit phone numbers |
| Melody Playback | Note sequences and simple songs |
| Twinkle Twinkle Song | Full runtime playback script |
| Signal Transformation | Time reversal & sample removal |
| Fourier Analysis | Detect and classify frequency components |

---

## 🔧 Requirements

- MATLAB R2021a or later
- Audio playback support
- Signal Processing Toolbox (optional)

---

## 🛠️ Installation

```bash
git clone https://github.com/yourusername/sound-processing-project.git
cd sound-processing-project

