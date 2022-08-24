include("ImpedanceAnalyzer_Functions.jl")

function MagPhaseBoxDotImpedanceStats_AgainstKnown(ZMagVec::Vector,ZPhaseVec::Vector,KnownImpedance::Complex,newPlot,labelVal,CVal)
    
    ZMagNormalized = ZMagVec ./ abs(KnownImpedance)
  

    KnownRealVec = repeat([real(KnownImpedance)], Int(length(ZMagVec)))
    KnownImagVec = repeat([(imag(KnownImpedance))], Int(length(ZMagVec)))
    KnownMagVec = repeat([abs(KnownImpedance)], Int(length(ZMagVec)))
    KnownPhaseVec = repeat([(angle(KnownImpedance)*180/pi)], Int(length(ZMagVec)))
    if newPlot
        Tmp = display(violin([log10.(KnownMagVec) KnownPhaseVec],[ZMagNormalized ZPhaseVec], layout=2,label = [labelVal*" Mag" labelVal*" Phase"],color=CVal,legend=[true false],xlabel=["Log₁₀(|Z|)" "∠Z [deg]"]))
        # display(StatsPlots.scatter(ZMagVec,KnownMagVec))
    else
        display(violin!([log10.(KnownMagVec) KnownPhaseVec],[ZMagNormalized ZPhaseVec], layout=2,label = [labelVal*" Mag" labelVal*" Phase"],color=CVal,legend=[true false]))
        # display(StatsPlots.scatter!(ZMagVec,KnownMagVec))
    end
    
    

end

function PlotManyElements(PathArray,KnownImpedanceVec,NameVec,ColorVec)

    for i in 1:length(KnownImpedanceVec)

        StatsData = UnpackStatsRead(PathArray[i])
        ZPhaseVec = StatsData.ZPhaseArray
        ZMagVec = StatsData.ZMagArray
    
        KnownImpedance = KnownImpedanceVec[i]
        if i==1
            MagPhaseBoxDotImpedanceStats_AgainstKnown(ZMagVec,ZPhaseVec,Complex(KnownImpedance),true,NameVec[i],ColorVec[i])
        else
            MagPhaseBoxDotImpedanceStats_AgainstKnown(ZMagVec,ZPhaseVec,Complex(KnownImpedance),false,NameVec[i],ColorVec[i])
        end
    
    end

end

function PlotMeanErrorStd(PathArray,KnownImpedanceVec)
    ZStdMagVec =zeros(length(PathArray))
    ZMeanMagVec =zeros(length(PathArray))
    for i in 1:length(KnownImpedanceVec)

        StatsData = UnpackStatsRead(PathArray[i])
        ZMeanMagVec[i] = StatsData.ImpedanceData["Mean_ZMag"]
        ZStdMagVec[i] = StatsData.ImpedanceData["Std_ZMag"]
    end

    Error = 100 .* ((abs.(KnownImpedanceVec) .- ZMeanMagVec) ./ abs.(KnownImpedanceVec))
    ZStdMagVecNormalized = log10.(ZStdMagVec) #./ abs.(KnownImpedanceVec)
    scatter([abs.(KnownImpedanceVec) abs.(KnownImpedanceVec)],[Error ZStdMagVecNormalized], layout = (2,1),xscale = :log10,xlabel=["" "|Z|"],ylabel = ["Percent Error" "Log₁₀(Std. Dev(|Z|))"],legend = false) 
    xticks!(10. .^(-3:8))
    
end


PathArray = [
"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_17_39_02_R100m.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_00_22_R1Ohms.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_17_49_59_R10m.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_10_25_R100kOhms.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_15_25_R10kOhms.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_20_21_R264Ohms.tdms"]

KnownImpedanceVec = [PolarDeg2Complex(0.0996,.75), PolarDeg2Complex(1.0075,.9) ,PolarDeg2Complex(0.00983,2), PolarDeg2Complex(99800,0.01), PolarDeg2Complex(9838,0.01) , PolarDeg2Complex(264.8,0)]

NameVec = ["100mΩ" , "1Ω" , "10mΩ" , "100kΩ" ,"10kΩ" , "264Ω"]
ColorVec = ["blue" , "red" , "green" , "purple" ,"yellow" , "cyan"]








PathArray = [
"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_30_11_C10nF.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_35_17_C3n9F.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_40_13_C22nF.tdms"

"C:\\Users\\elima\\OneDrive\\Documents\\GitHub\\Simple_Impedance_Analyzer\\Julia Data Processing\\Accuracy_Testing_Data\\2022_01_08_10_45_46_C80nF.tdms"]

KnownImpedanceVec = [PolarDeg2Complex(1651,-89.98) ,PolarDeg2Complex(4458,-89.11), PolarDeg2Complex(709.5,-89.98), PolarDeg2Complex(195.95,-89.45)]

NameVec = ["10nF" , "3.9nF" , "22nF" , "80nF"]
ColorVec = ["blue" , "red" , "green" , "purple"]

