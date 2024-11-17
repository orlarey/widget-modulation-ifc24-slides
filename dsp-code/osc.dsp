import("stdfaust.lib");

vco(n) = vgroup("VCO%2n", os.osc(vslider("freq[style:knob][scale:log]", 440, 20, 20000,0.1)) * vslider("gain[style:knob]", 0.1, 0, 1,0.01));

lfo(n) = vgroup("LFO%2n", (os.osc(vslider("freq[style:knob][scale:log]", 440, 20, 20000,0.1))+1)/2 * vslider("gain[style:knob]", 0.1, 0, 1,0.01));

fm = ba.hz2midikey, *(5*12) : + : min(127) : max(0) : ba.midikey2hz;

process = vco(2) : ["freq":fm->vco(1)];


import("stdfaust.lib");

//--------------------------------------------------------------------------------

vco(n) = vgroup("VCO%2n", os.osc(vslider("freq[style:knob][scale:log]", 440, 20, 20000,0.1)) * vslider("gain[style:knob]", 0.1, 0, 1,0.01));

lfo(n) = vgroup("LFO%2n", (os.osc(vslider("freq[style:knob][scale:log]", 1, 0.1, 400,0.1))+1)/2 * vslider("gain[style:knob]", 0.1, 0, 1,0.01));

linfm = ba.hz2midikey, *(5*12) : + : min(127) : max(0) : ba.midikey2hz;
expfm = _, (2,*(5) : ^): * : min(20000) : max(0);

process = hgroup("demo", lfo(0):["gain":*->vco(1)] : ["freq":linfm->vco(2)]);
