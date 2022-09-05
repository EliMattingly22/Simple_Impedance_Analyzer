include("ImpedanceAnalyzer_Functions.jl")


Sweep1 = UnpackSweepRead("FreqSweep\\2022_09_02_11_40_09_Sweep_100-100000Hz_Proximity_Inductor.tdms")
Sweep1Low = UnpackSweepRead("FreqSweep\\2022_09_04_13_56_24_Sweep_  5-100Hz_Proximity_Inductor_LowFreq.tdms")


f = Sweep1.FreqVec
Z = Sweep1.ZMagVec.*exp.(1im*Sweep1.ZPhaseVec*pi/180)

plot(f,real.(Z);yscale=:log10,xscale=:log10,label="Real(Z)",linewidth=3,lc=:red)
plot!(f,imag.(Z);yscale=:log10,xscale=:log10,label="Imag(Z)",linewidth=3,ls=:dash,lc=:black)
f = Sweep1Low.FreqVec
Z = Sweep1Low.ZMagVec.*exp.(1im*Sweep1Low.ZPhaseVec*pi/180)

plot!(f,abs.(real.(Z));yscale=:log10,xscale=:log10,label=:none,linewidth=3,lc=:red)
plot!(f[15:end],abs.(imag.(Z))[15:end];yscale=:log10,xscale=:log10,label=:none,linewidth=3,ls=:dash,lc=:black)
xticks!(10. .^(-3:8))
ylabel!("Impedance [Ω]")
xlabel!("Frequency [Hz]")
savefig("Sweep_ProximitySkinLoad.png")

Sweep2 = UnpackSweepRead("FreqSweep\\2022_09_02_12_23_25_Sweep_100-100000Hz_SeriesLC_AirCore_Litz.tdms")
f = Sweep2.FreqVec
Z = Sweep2.ZMagVec.*exp.(1im*Sweep2.ZPhaseVec*pi/180)

plot(f,abs.(real.(Z));yscale=:log10,xscale=:log10,label="Real(Z)",linewidth=3,lc=:red)
plot!(f,abs.(imag.(Z));yscale=:log10,xscale=:log10,label="Imag(Z)",linewidth=3,ls=:dash,lc=:black)
ylabel!("Impedance [Ω]")
xlabel!("Frequency [Hz]")
xticks!(10. .^(-3:8))






Sweep3 = UnpackSweepRead("FreqSweep\\2022_09_02_13_14_58_Sweep_100-100000Hz_Inductor_AirCore_Litz.tdms")
f = Sweep3.FreqVec
Z = Sweep3.ZMagVec.*exp.(1im*Sweep3.ZPhaseVec*pi/180)

plot(f,abs.(real.(Z));yscale=:log10,xscale=:log10,label="Real(Z)",linewidth=3,lc=:red)
plot!(f,abs.(imag.(Z));yscale=:log10,xscale=:log10,label="Imag(Z)",linewidth=3,ls=:dash,lc=:black)
ylabel!("Impedance [Ω]")
xlabel!("Frequency [Hz]")
xticks!(10. .^(-3:8))