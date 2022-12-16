#ifndef SOUND_MODULE_H
#define SOUND_MODULE_H

#include <string>
#include <SDL2/SDL.h>
#include <SDL2/SDL_audio.h>
#include <queue>
#include <cmath>
using namespace std;

const int AMPLITUDE = 28000;
const int FREQUENCY = 44100;

struct BeepObject
{
    double freq;
    int samplesLeft;
    string wave_type;
};

class Beeper
{
private:
    double v;
    queue<BeepObject> beeps;
public:
    Beeper();
    ~Beeper();
    void beep(string wave, double freq, int duration);
    void generateSamples(Sint16 *stream, int length);
    void wait(int time);
    double chooseWave(string wave, double freq, double amplitude, double v);
};

void audio_callback(void*, Uint8*, int);
double sineWave(double freq, double amplitude, double v);
double squareWave(double freq, double amplitude, double v);
double triangleWave(double freq, double amplitude, double v);
double sawtoothWave(double freq, double amplitude, double v);
void play_note (int rx, int ry, int rz);

#define NOTE_C1 65.40638
#define NOTE_C1s 69.29566
#define NOTE_D1 73.41619
#define NOTE_D1s 77.78175
#define NOTE_E1 82.40689
#define NOTE_F1 87.30706
#define NOTE_F1s 92.49861
#define NOTE_G1 97.99886
#define NOTE_G1s 103.8262
#define NOTE_A1 110.0000
#define NOTE_A1s 116.5409
#define NOTE_B1 123.4708

#define NOTE_C2 130.8128
#define NOTE_C2s 138.5913
#define NOTE_D2 146.8324
#define NOTE_D2s 155.5635
#define NOTE_E2 164.8138
#define NOTE_F2 174.6141
#define NOTE_F2s 184.9972
#define NOTE_G2 195.9977
#define NOTE_G2s 207.6523
#define NOTE_A2 220.0000
#define NOTE_A2s 233.0819
#define NOTE_B2 246.9417

#define NOTE_C3 261.6256
#define NOTE_C3s 277.1826
#define NOTE_D3 293.6648
#define NOTE_D3s 311.1270
#define NOTE_E3 329.6276
#define NOTE_F3 349.2282
#define NOTE_F3s 369.9944
#define NOTE_G3 391.9954
#define NOTE_G3s 415.3047
#define NOTE_A3 440.0000
#define NOTE_A3s 466.1638
#define NOTE_B3 493.8833

#define NOTE_C4 523.2511
#define NOTE_C4s 554.3653
#define NOTE_D4 587.3295
#define NOTE_D4s 622.2540
#define NOTE_E4 659.2551
#define NOTE_F4 698.4565
#define NOTE_F4s 739.9888
#define NOTE_G4 783.9909
#define NOTE_G4s 830.6094
#define NOTE_A4 880.0000
#define NOTE_A4s 932.3275
#define NOTE_B4 987.7666

#define NOTE_C5 1046.502
#define NOTE_C5s 1108.731
#define NOTE_D5 1174.659
#define NOTE_D5s 1244.508
#define NOTE_E5 1318.510
#define NOTE_F5 1396.913
#define NOTE_F5s 1479.978
#define NOTE_G5 1567.982
#define NOTE_G5s 1661.219
#define NOTE_A5 1760.000
#define NOTE_A5s 1864.655
#define NOTE_B5 1975.533

#define NOTE_C6 2093.005
#define NOTE_C6s 2217.461
#define NOTE_D6 2349.318
#define NOTE_D6s 2489.016
#define NOTE_E6 2637.020
#define NOTE_F6 2793.826
#define NOTE_F6s 2959.955
#define NOTE_G6 3135.963
#define NOTE_G6s 3322.438
#define NOTE_A6 3520.000
#define NOTE_A6s 3729.310
#define NOTE_B6 3951.066

#define NOTE_C7 4186.009
#define NOTE_C7s 4434.922
#define NOTE_D7 4698.636
#define NOTE_D7s 4978.032
#define NOTE_E7 5274.041
#define NOTE_F7 5587.652
#define NOTE_F7s 5919.911
#define NOTE_G7 6271.927
#define NOTE_G7s 6644.875
#define NOTE_A7 7040.000
#define NOTE_A7s 7458.620
#define NOTE_B7 7902.133

#define NOTE_C8 8372.018

#endif