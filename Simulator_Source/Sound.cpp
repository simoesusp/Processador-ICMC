#include "Sound.h"

Beeper::Beeper()
{
    SDL_AudioSpec desiredSpec;

    desiredSpec.freq = FREQUENCY;
    desiredSpec.format = AUDIO_S16SYS;
    desiredSpec.channels = 1;
    desiredSpec.samples = 2048;
    desiredSpec.callback = audio_callback;
    desiredSpec.userdata = this;

    SDL_AudioSpec obtainedSpec;

    // you might want to look for errors here
    SDL_OpenAudio(&desiredSpec, &obtainedSpec);

    // start play audio
    SDL_PauseAudio(0);
}

Beeper::~Beeper(){
    SDL_CloseAudio();
}



void Beeper::generateSamples(Sint16 *stream, int length)
{
    int i = 0;
    while (i < length) {

        if (beeps.empty()) {
            while (i < length) {
                stream[i] = 0;
                i++;
            }
            return;
        }
        BeepObject& bo = beeps.front();

        int samplesToDo = std::min(i + bo.samplesLeft, length);
        bo.samplesLeft -= samplesToDo - i;

        while (i < samplesToDo) {
            stream[i] = chooseWave(bo.wave_type, FREQUENCY, AMPLITUDE, v);
            i++;
            v += bo.freq;
        }

        if (bo.samplesLeft == 0) {
            beeps.pop();
        }
    }
}

double sineWave(double freq, double amplitude, double v){
    return amplitude * std::sin(v * 2 * M_PI / freq);
}

double squareWave(double freq, double amplitude, double v){
    double w = v * 2 * M_PI / freq;
    double value = std::sin(w) >= 0.0 ? 1.0 : -1.0;

    return (value * amplitude);
}

double triangleWave(double freq, double amplitude, double v){
    double w = v * 2 * M_PI / freq;
    double value = (2.0 / M_PI) * std::asin(std::sin(w));

    return (value * amplitude);
}

double sawtoothWave(double freq, double amplitude, double v){
    double wave = 2 * ( (v/freq) - std::floor(0.5 + (v/freq)) );

    return (wave * amplitude);
}


double Beeper::chooseWave(string wave, double freq, double amplitude, double v){
    if (wave == "sine"){
        return sineWave(freq, amplitude, v);
    } else if (wave == "square"){
        return squareWave(freq, amplitude, v);
    } else if (wave == "triangle"){
        return triangleWave(freq, amplitude, v);
    } else if (wave == "sawtooth"){
        return sawtoothWave(freq, amplitude, v);
    } else {
        return sineWave(freq, amplitude, v);
    }
}

void Beeper::beep(string wave, double freq, int duration){
    BeepObject bo;
    bo.freq = freq;
    bo.wave_type = wave;
    bo.samplesLeft = duration * FREQUENCY / 1000;

    SDL_LockAudio();
    beeps.push(bo);
    SDL_UnlockAudio();
}

void Beeper::wait(int time){
    int size;
    do {
        SDL_Delay(time);
        SDL_LockAudio();
        size = beeps.size();
        SDL_UnlockAudio();
    } while (size > 0);

}

void audio_callback(void *_beeper, Uint8 *_stream, int _length)
{
    Sint16 *stream = (Sint16*) _stream;
    int length = _length / 2;
    Beeper* beeper = (Beeper*) _beeper;

    beeper->generateSamples(stream, length);
}

// rx: frequency, ry: duration (ms), rz:wave_type
void play_note (int rx, int ry, int rz) {
    SDL_Init(SDL_INIT_AUDIO);
    Beeper beeper;

    std::string type;

    switch (rz) {
    case 0:
        type = "sine";
        break;
    case 1:
        type = "square";
        break;
    case 2:
        type = "triangle";
        break;
    case 3:
        type = "sawtooth";
        break;    
    default:
        type = "sine";
        break;
    }
    beeper.beep(type, rx, ry);
    beeper.wait(30);
}