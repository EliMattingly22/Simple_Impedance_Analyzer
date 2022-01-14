
using TDMSReader, Gtk, Plots, StatsPlots

struct SingleRead
    TestParams
    ImpedanceData
    GainData
    CurrentTimeDomain
    VoltageTimeDomain
end

struct FreqSweepRead
    FreqVec
    ZMagVec
    ZPhaseVec
    GainData
    TestParams
end

struct StatsRead
    ImpedanceData
    ZPhaseArray
    ZMagArray
    GainData
    TestParams
end

function UnpackSingleRead()
    UnpackSingleRead(open_dialog("Pick a file"))
end

function UnpackSingleRead(FilePath)
    AllData = readtdms(FilePath)
    ImpedanceData = AllData.groups["Impedance"].props
    ImpedanceData["Ls"]

    GainData = AllData.groups["Calib_and_Gain"].props
    CurrentTimeDomain = AllData.groups["SampleTimeDomain"].channels["Current"].data
    VoltageTimeDomain = AllData.groups["SampleTimeDomain"].channels["Voltage"].data

    TestParams =  AllData.groups["Test_Parameters"].props

    return SingleRead(TestParams,ImpedanceData,GainData,CurrentTimeDomain,VoltageTimeDomain)

end


function UnpackSweepRead()
    UnpackSweepRead(open_dialog("Pick a file"))
end
function UnpackSweepRead(FilePath)
    AllData = readtdms(FilePath)
    FreqVec = AllData.groups["Freq_Sweep_Data"].channels["Freq_Vec"].data
    ZMagVec = AllData.groups["Freq_Sweep_Data"].channels["ZMag_Vec"].data
    ZPhaseVec = AllData.groups["Freq_Sweep_Data"].channels["ZPhase_Vec"].data

    GainData = AllData.groups["Calib_and_Gain"].props

    TestParams =  AllData.groups["Test_Parameters"].props

    return FreqSweepRead(FreqVec,ZMagVec,ZPhaseVec,GainData,TestParams)

end



function UnpackStatsRead()
    UnpackStatsRead(open_dialog("Pick a file"))
end


function UnpackStatsRead(FilePath)
    AllData = readtdms(FilePath)
    ImpedanceData = AllData.groups["Impedance"].props
    ZPhaseArray = AllData.groups["Data Arrays"].channels["ZPhase_Array"].data
    ZMagArray = AllData.groups["Data Arrays"].channels["ZMag_Array"].data
    GainData = AllData.groups["Calib_and_Gain"].props

    TestParams =  AllData.groups["Test_Parameters"].props

    return StatsRead(ImpedanceData,ZPhaseArray,ZMagArray,GainData,TestParams)

end

function PlotFreqSweep(DataIn::FreqSweepRead;XScaling= :identity, YScaling = :log10)
    
    XVec = [DataIn.FreqVec , DataIn.FreqVec]
    YVec = [DataIn.ZMagVec , DataIn.ZPhaseVec]
    plot(XVec,YVec,layout = (2,1),xscale = XScaling,label = ["|Z|" "∠Z"],legend = :best,lc=[:blue :green],size = (800,400),xlabel = "Frequency[Hz]",ylabel = ["|Z| [Ω]" "∠Z [deg.]"])
    # , yscale = [YScaling , :identity],
end



function PolarDeg2Cart(R,Θ)
    RealPart = real.(R.*exp.(im*π/180 .*Θ))
    ImagPart = imag.(R.*exp.(im*π/180 .*Θ))
    return RealPart, ImagPart
end
function PolarDeg2Complex(R,Θ)
   
    return (R.*exp.(im*π/180 .*Θ))
end  