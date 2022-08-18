# Simple Impedance Analyzer

## Purpose

The impedance analyzer was designed as a low-cost, flexible platform to perform impedance measurement at arbitrary frequencies up to ~250kHz. The current infrastructure assumes the user has access to a National Instruments DAQ (e.g. NI-USB-6363), though similar digitizers would be similarly effective. 

In this current configuration:
* The LabView has an easy to use GUI
* TDMS file saving
* It can measure impedances from 10mOhms to 10MOhms, and by changing the shunt resistor values that range could be extended 
* Test at frequencies from DC-250kHz (>100kHz still needs validation)
* Perform frequency sweeps on log or linear spacing
* If a battery-powered computer and DAQ is used, the entire measurement apparatus can be both portable and floating.

TODO: Photograph of board

TODO: Accuracy plot

TODO: Screenshot of GUI



# Basic Operation

It is worth reading the [Keysight impedance measurement handbook](https://www.keysight.com/us/en/assets/7018-06840/application-notes/5950-3000.pdf) or TI's reference design for an LCR meter front-end for an overview of measurement techniques. 

This circuit uses the "auto-balancing bridge" technique. If you are curious/want to play around with the circuit you can see the LTSPICE schematic.

The current through the DUT is (ideally) the same as the current in the shunt resistor, so the impedance is V(DUT) / (V(Shunt)/R(Shunt)). 

# Source of Errors

The precision of the circuit is dominated by the shunt resistors and gain accuracy of the INAs. Error in any of these will linearly cause an error in the calculated impedance. If they are stable over time, they can conceivably be calibrated with a high tolerance (e.g. 0.01%) reference resistor, though that has not been included in the software. 

The parasitic elements can be accounted for by taking an open/short measurement. See sect. 4.3.2 in the impedance measurement handbook

# Bill of materials (key items)


