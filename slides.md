---
author: Yann Orlarey, Stéphane Letz, Romain Michon
title: Widget Modulation in Faust
subtitle: A Novel Extension for Audio Circuit Design
institute: Emeraude (INRIA/INSA/GRAME)
topic: "Faust"
theme: "metropolis"
colortheme: "crane"
fonttheme: "professionalfonts"
fontsize: 10pt
urlcolor: red
linkstyle: bold
date: 15 mars 2035
lang: en-US
section-titles: false
toc: false

---
# Motivation

## Question:
Faust is a highly modular programming language. It is easy to reuse and combine existing modules. But how can we
control the parameters of a module if it already has its own user interface?

## Answer:
This was previously impossible (except by external control via
MIDI, OSC or HTTP) without manually editing the component
code. 

# Overview

- New extension to Faust programming language
- Inspired by modular synthesizers
- Enables "voltage control" style modulation
- Allows parameter modulation without code modification
- Enhances code reuse and customization

---

# Historical Context

- Mid-20th century: Voltage control in analog synthesis
- Key innovators:
  - Hugh Le Caine (VCO concept)
  - Robert Moog (1V/oct standard)
  - Don Buchla
- Enabled recursive control: signals controlling other signals
- Foundation for modern modular synthesis

---

# Traditional Approach in Faust

Basic oscillator example:
```faust
myosc = vslider("freq[style:knob][scale:log]", 
        440, 20, 20000, 0.1) 
      : os.osc;
```

Adding modulation required code modification:
```faust
myosc = +(vslider("freq[style:knob][scale:log]", 
        440, 20, 20000, 0.1)) 
      : os.osc;
```

---

# Widget Modulation: Basic Syntax

```faust
["WidgetName" -> Circuit]
```

Example with Freeverb:
```faust
["Wet" -> dm.freeverb_demo]
```

Creates additional input for modulation signal
Default operation: multiplication

---

# Modulation Types

Three possible configurations:

1. Binary Circuit (2→1)
   - Creates additional input
   - Example: `"Wet":+`

2. Unary Circuit (1→1)
   - No additional input
   - Example: `"Wet":*(lfo(10, 0.5))`

3. Constant Circuit (0→1)
   - Replaces widget
   - Example: `"Wet":0.75`

---

# Multiple Targets

Can modulate multiple widgets:
```faust
["Wet", "Damp", "RoomSize" -> dm.freeverb_demo]
```

Equivalent to:
```faust
["Wet" -> ["Damp" -> ["RoomSize" -> dm.freeverb_demo]]]
```

---

# Widget Path Specification

- Format: `group-type:group-label/widget-label`
- Group types: `h:` (horizontal), `v:` (vertical), `t:` (tab)
- Example: `"v:chan 1/gain"`
- Helps disambiguate widgets with same name

---

# Advanced Modulation Circuits

Common modulation functions:

```faust
// For positive modulation (0 to +1)
addp(v1,v2,w,m) = max(lo, min(hi, w + v))
  with {
    lo = lowest(w);
    hi = highest(w);
    v = v1+m*(v2-v1);
  };

// For audio signals (-1 to +1)
add(v1,v2,w,m) = addp(v1,v2,w,(m+1)/2);
```

---

# Practical Example: FM Synthesis

Basic FM implementation:
```faust
process = osc(1) : ["freq":+ -> osc(2)];
```

Enhanced version with amplitude control:
```faust
process = osc(0)+1 : 
  ["gain" -> osc(1)*500] : 
  ["freq":+ -> osc(2)];
```

---

# Multiple Modulations

Same widget can have multiple modulations:
```faust
["freq":md.add(-600,600), 
 "freq":md.mul(0.1,10) -> osc(1)]
```

- First modulation: frequency addition
- Second modulation: frequency multiplication

---

# Complex Example

Combined modulations with feedback:
```faust
process = osc(0) : 
  ["gain":md.add(0,0.5) -> 
    (_ ,osc(1): 
      ["freq":md.add(-600,600), 
       "freq":md.mul(0.1,10) -> 
         osc(2)])~@(200) ]<: _,@(5000);
```

---

# Best Practices

- Use clear widget naming conventions
- Consider range limitations when designing modulations
- Leverage group hierarchies for precise targeting
- Document modulation expectations in library code
- Test edge cases with extreme modulation values

---

# Benefits & Impact

- Enhances code reusability
- Enables post-development customization
- Facilitates library development
- Matches modular synthesis workflow
- No performance overhead
- Maintains Faust's functional approach

---

# Future Directions

- Development of modulation circuit libraries
- Enhanced UI feedback for modulated parameters
- Integration with other Faust features
- Community-driven modulation patterns
- Potential standardization of common modulations

