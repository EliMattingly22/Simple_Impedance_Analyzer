include("ImpedanceAnalyzer_Functions.jl")

function MagPhaseBoxDotImpedanceStats_AgainstKnown(ZMagVec::Vector,ZPhaseVec::Vector,KnownImpedance::Complex,newPlot,labelVal,CVal)
    plt = [];
    ZMagNormalized = ZMagVec ./ abs(KnownImpedance)
  

    KnownRealVec = repeat([real(KnownImpedance)], Int(length(ZMagVec)))
    KnownImagVec = repeat([(imag(KnownImpedance))], Int(length(ZMagVec)))
    KnownMagVec = repeat([abs(KnownImpedance)], Int(length(ZMagVec)))
    KnownPhaseVec = repeat([(angle(KnownImpedance)*180/pi)], Int(length(ZMagVec)))
    if newPlot
        plt = display(violin([log10.(KnownMagVec) ],[ZMagNormalized ], layout=1,label = [labelVal*" Mag" labelVal*" Phase"],color=CVal,legend=[true false],xlabel=["Log₁₀(|Z|)" "∠Z [deg]"],ylabel=["Relative Impedance"]))
        # display(StatsPlots.scatter(ZMagVec,KnownMagVec))
    else
        plt = display(violin!([log10.(KnownMagVec) ],[ZMagNormalized ], layout=1,label = [labelVal*" Mag" labelVal*" Phase"],color=CVal,legend=[false false],ylabel=["Relative Impedance"]))
        # display(StatsPlots.scatter!(ZMagVec,KnownMagVec))
    end
    
    return plt

end

function PlotManyElements(PathArray,KnownImpedanceVec,NameVec,ColorVec)
 P2 = [];
    for i in 1:length(KnownImpedanceVec)

        StatsData = UnpackStatsRead(PathArray[i])
        ZPhaseVec = StatsData.ZPhaseArray
        ZMagVec = StatsData.ZMagArray
    
        KnownImpedance = KnownImpedanceVec[i]
        if i==1
            MagPhaseBoxDotImpedanceStats_AgainstKnown(ZMagVec,ZPhaseVec,Complex(KnownImpedance),true,NameVec[i],ColorVec[i])
        else
            P2 = MagPhaseBoxDotImpedanceStats_AgainstKnown(ZMagVec,ZPhaseVec,Complex(KnownImpedance),false,NameVec[i],ColorVec[i])
        end
    
    end
    ylabel!("Relative Impedance")
    return P2

end

function PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = :auto,labelText = "Label",NewPlot=true)
    if NewPlot
        scatter(;layout=(2,1))
    end
    ZStdMagVec =zeros(length(PathArray))
    ZMeanMagVec =zeros(length(PathArray))
    for i in 1:length(KnownImpedanceVec)

        StatsData = UnpackStatsRead(PathArray[i])
        ZMeanMagVec[i] = StatsData.ImpedanceData["Mean_ZMag"]
        ZStdMagVec[i] = StatsData.ImpedanceData["Std_ZMag"]
    end

    Error = 100 .* ((abs.(KnownImpedanceVec) .- ZMeanMagVec) ./ abs.(KnownImpedanceVec))
    ZStdMagVecNormalized = abs.(ZStdMagVec) #./ abs.(KnownImpedanceVec)
    P = scatter!([abs.(KnownImpedanceVec) abs.(KnownImpedanceVec)],[abs.(Error) ZStdMagVecNormalized], layout = (2,1),xscale = :log10,xlabel=["" "|Z| [Ω]"],yscale = [:log10 :log10],ylabel = ["Percent Error" "Std. Dev(|Z|) [Ω]"],legend = [false :bottomright],mc=[LineColor LineColor],label=labelText) 
    xticks!(10. .^(-3:8))
    yticks!(P.subplots[2],10. .^(-8:8))
    # yticks!(10. .^(-8:8))
    
end
NameVec = ["10 mΩ" ,"100 mΩ" , "1 Ω" , "10 Ω", "100 Ω", "1 kΩ" , "10 kΩ" ,"100 kΩ" ,"1 MΩ"]
# ColorVec = [[0, 0, 0, 1] ,"blue", "red" , "green" , "purple" ,"yellow" , "cyan", "magenta", "black"]

ColorVec = colormap("blues",9)
# 
# 
# 

############################

Tmp = CSV.File("1kHz\\Agilent4263B_Meas-1kHz.txt")
KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[1:3]

PathArray = "1kHz\\10OhmShunt\\" .* readdir("1kHz\\10OhmShunt")
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(1,0,0),labelText = "Shunt =10 Ω",NewPlot=true)

Tmp = CSV.File("1kHz\\Agilent4263B_Meas-1kHz.txt")
KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[1:9]

PathArray = "1kHz\\100OhmShunt\\" .* readdir("1kHz\\100OhmShunt")
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(0,1,0),labelText = "Shunt =100 Ω",NewPlot=false)


KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[end-3:end]

PathArray = "1kHz\\10kOhmShunt\\" .* readdir("1kHz\\10kOhmShunt")
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(0,0,1),labelText = "Shunt =10 kΩ",NewPlot=false)



############################

Tmp = CSV.File("10kHz\\Agilent4263B_Meas - 10kHz.txt")
KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[1:3]

PathArray = ("10kHz\\10OhmShunt\\" .* readdir("10kHz\\10OhmShunt"))
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(1,0,0),labelText = "Shunt =10 Ω",NewPlot=true)

KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[1:9]

PathArray = reverse("10kHz\\100OhmShunt\\" .* readdir("10kHz\\100OhmShunt"))
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(0,1,0),labelText = "Shunt =100 Ω",NewPlot=false)


KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[end-3:end]

PathArray = "10kHz\\10kOhmShunt\\" .* readdir("10kHz\\10kOhmShunt")
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(0,0,1),labelText = "Shunt =10 kΩ",NewPlot=false)



############################

Tmp = CSV.File("100kHz\\Agilent4263B_Meas - 100kHz.txt")
KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[1:3]

PathArray = ("100kHz\\10OhmShunt\\" .* readdir("100kHz\\10OhmShunt"))
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(1,0,0),labelText = "Shunt =10 Ω",NewPlot=true)

KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[1:9]

PathArray = ("100kHz\\100OhmShunt\\" .* readdir("100kHz\\100OhmShunt"))
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(0,1,0),labelText = "Shunt =100 Ω",NewPlot=false)


KnownImpedanceVec = PolarDeg2Complex.(Tmp.Mag,Tmp.Phase)[end-3:end]

PathArray = "100kHz\\10kOhmShunt\\" .* readdir("100kHz\\10kOhmShunt")
PlotMeanErrorStd(PathArray,KnownImpedanceVec;LineColor = RGB(0,0,1),labelText = "Shunt =10 kΩ",NewPlot=false)


