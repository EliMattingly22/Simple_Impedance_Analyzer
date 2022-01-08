
using TDMSReader, Gtk, PyPlot

FilePath = open_dialog("Pick a file")


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

    return TestParams,ImpedanceData,GainData,CurrentTimeDomain,VoltageTimeDomain

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

    return FreqVec,ZMagVec,ZPhaseVec,GainData,TestParams

end



function UnpackStatsRead(FilePath)
    UnpackStatsRead(open_dialog("Pick a file"))
end


function UnpackStatsRead(FilePath)
    AllData = readtdms(FilePath)
    ImpedanceData = AllData.groups["Impedance"].props
    ZPhaseArray = AllData.groups["Data Arrays"].channels["ZPhase_Array"].data
    ZMagArray = AllData.groups["Data Arrays"].channels["ZMag_Array"].data
    GainData = AllData.groups["Calib_and_Gain"].props

    TestParams =  AllData.groups["Test_Parameters"].props

    return ImpedanceData,ZPhaseArray,ZMagArray,GainData,TestParams

end


