# Simple Impedance Analyzer
A simple PCB impedance analyzer to measure unknown loads at frquencies up to about 500kHz (depends largely on acquisition instrumentation). The board does not include any of the ADCs/data analysis microcontrollers, so I use a NI DAQ 6211 with LabVIEW for the processing. 

# Basic Operation

It is worth reading the [Keysight impedance measurement handbook](https://www.keysight.com/us/en/assets/7018-06840/application-notes/5950-3000.pdf) or TI's reference design for an LCR meter front-end for an overview of measurement techniques. This circuit uses the "auto-balancing bridge" technique. If you are curious/want to play around with the circuit you can see the LTSPICE schematic.

The current through the DUT is (ideally) the same as the current in the shunt resistor, so the impedance is V(DUT) / (V(Shunt)/R(Shunt)). 

# Errors

The precision of the circuit is dominated by the shunt resistors and gain accuracy of the INAs. Error in any of these will linearly cause an error in the calcualted impedance. If they are stable over time, they can be calibrated with a high tolerance (e.g. 0.01%) reference resistor.

The paracitics can be accounted for by taking an open/short measurement. See sect. 4.3.2 in the impedance measurement handbook


