include("ImpedanceAnalyzer_Functions.jl")


Sweep1 = UnpackSweepRead("FreqSweep\\2022_09_02_11_40_09_Sweep_100-100000Hz_Proximity_Inductor.tdms")

f = Sweep1.FreqVec
Z = Sweep1.ZMagVec.*exp.(1im*Sweep1.ZPhaseVec*pi/180)

plot(f,real.(Z);yscale=:log10,xscale=:log10,label="Real(Z)",linewidth=3,lc=:red)
plot!(f,imag.(Z);yscale=:log10,xscale=:log10,label="Imag(Z)",linewidth=3,ls=:dash,lc=:black)
ylabel!("Impedance [Ω]")
xlabel!("Frequency [Hz]")

Sweep2 = UnpackSweepRead("FreqSweep\\2022_09_02_12_23_25_Sweep_100-100000Hz_SeriesLC_AirCore_Litz.tdms")
f = Sweep2.FreqVec
Z = Sweep2.ZMagVec.*exp.(1im*Sweep2.ZPhaseVec*pi/180)

plot(f,abs.(real.(Z));yscale=:log10,xscale=:log10,label="Real(Z)")
plot!(f,abs.(imag.(Z));yscale=:log10,xscale=:log10,label="Imag(Z)")
ylabel!("Impedance [Ω]")
xlabel!("Frequency [Hz]")
