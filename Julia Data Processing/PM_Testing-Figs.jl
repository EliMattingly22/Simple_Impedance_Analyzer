include("ImpedanceAnalyzer_Functions.jl")


function PlotStats_AgainstHeightOffPM(ZMagVec::Vector,ZPhaseVec::Vector,Height::AbstractFloat,newPlot,CVal)
    
    

    HeightVec = repeat([Height], Int(length(ZMagVec)))
    
    if newPlot
        Tmp = display(dotplot([HeightVec HeightVec],[ZMagVec ZPhaseVec], layout=(2,1),color=CVal,legend=[false false],xlabel = [" " "Pancake dist. from steel [mm]"],ylabel=["|Z|" "∠Z [deg]"]))
        # display(StatsPlots.scatter(ZMagVec,KnownMagVec))
    else
        display(dotplot!([HeightVec HeightVec],[ZMagVec ZPhaseVec], layout=(2,1),color=CVal,legend=[false false]))
        # display(StatsPlots.scatter!(ZMagVec,KnownMagVec))
    end

end

function PlotManyElements(PathArray,HeightList,ColorVec)

    for i in 1:length(KnownImpedanceVec)

        StatsData = UnpackStatsRead(PathArray[i])
        ZPhaseVec = StatsData.ZPhaseArray
        ZMagVec = StatsData.ZMagArray
    
        
        if i==1
            PlotStats_AgainstHeightOffPM(ZMagVec,ZPhaseVec,HeightList[i],true,ColorVec[i])
        else
            PlotStats_AgainstHeightOffPM(ZMagVec,ZPhaseVec,HeightList[i],false,ColorVec[i])
        end
    
    end

end


function PlotNTimetraces(PathArray,LabelList,ColorVec)
    for i in 1:length(PathArray)
        
        StatsData = UnpackStatsRead(PathArray[i])
        ZPhaseVec = StatsData.ZPhaseArray
        ZMagVec = StatsData.ZMagArray
        if i==1
            display(plot([ZMagVec ZPhaseVec], layout=(2,1),color=ColorVec[i],label = string(LabelList[i]) ,legend=[true false],xlabel = [" " "Acquisition number"],ylabel=["|Z|" "∠Z [deg]"]))
        else
            display(plot!([ZMagVec ZPhaseVec], layout=(2,1),color=ColorVec[i],label = string(LabelList[i]) ,legend=[true false],xlabel = [" " "Acquisition number"],ylabel=["|Z|" "∠Z [deg]"]))
        end
    end
end

function PlotNTimetraces_Norm(PathArray,LabelList,ColorVec)
    for i in 1:length(PathArray)
        
        StatsData = UnpackStatsRead(PathArray[i])
        ZPhaseVec = StatsData.ZPhaseArray
        ZMagVec = StatsData.ZMagArray
        if i==1
            display(plot([ZMagVec./ZMagVec[1] ZPhaseVec./ZPhaseVec[1]], layout=(2,1),color=ColorVec[i],label = string(LabelList[i]) ,legend=[true false],xlabel = [" " "Acquisition number"],ylabel=["|Z|" "∠Z [deg]"]))
        else
            display(plot!([ZMagVec./ZMagVec[1] ZPhaseVec./ZPhaseVec[1]], layout=(2,1),color=ColorVec[i],label = string(LabelList[i]) ,legend=[true false],xlabel = [" " "Acquisition number"],ylabel=["|Z|" "∠Z [deg]"]))
        end
    end
end

function PlotN_Mean_Stdeviation(PathArray,HeightList,msize=8)
    MeanLVec = zeros(length(PathArray))
    StdLVec = zeros(length(PathArray))
    for i in 1:length(PathArray)
        
        StatsData = UnpackStatsRead(PathArray[i])
        
        MeanLVec[i] = StatsData.ImpedanceData["Mean_Ls"].*1e6
        StdLVec[i] = StatsData.ImpedanceData["Std_Ls"].*1e6
    end
    display(Plots.scatter([HeightList HeightList],[MeanLVec log10.(StdLVec)], layout=(2,1),legend=[false false],xlabel = [" " "Pancake dist. from steel [mm]"],ylabel=["Mean(L) [μH]" "log₁₀(Stdev(L)) [μH]"],ms=msize))

end

PathArray = [
"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_13_15_32_47_PM_Meas_Pancake_165mm.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_13_15_27_33_PM_Meas_Pancake_133mm.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_13_15_15_56_PM_Meas_Pancake_38mm.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_13_15_21_55_PM_Meas_Pancake_88mm.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_13_15_08_52_PM_Meas_Pancake_0mm.tdms"]

HeightList = [165. , 133.0 , 38.0 , 88.0, 0.0]

ColorVec = ["blue" , "red" , "green" , "purple" ,"yellow" ]


PathArray = [
"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_09_49_47_PM_Meas_Saddle-0mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_09_53_21_PM_Meas_Saddle-50mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_09_56_42_PM_Meas_Saddle-100mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_10_00_32_PM_Meas_Saddle-150mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_10_03_56_PM_Meas_Saddle-200mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_10_09_00_PM_Meas_Saddle-250mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_10_13_03_PM_Meas_Saddle-300mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_10_19_50_PM_Meas_Saddle-350mm-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_10_28_09_PM_Meas_Saddle-400mm-10Hz.tdms"

]

HeightList = 0:50:400

###############



## 10 Hz ##

PathArray = [
"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_16_09_19_Demagnetized-MagnetizedonTop-10Hz-long.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_14_46_17_DemagnetizedNdFeB-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_14_08_06_CoilOnly-10Hz.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_13_53_49_NdFeB-1Inch-PreHeating-10Hz.tdms"]

LabelList = [PathArray[i][68:end-5] for i in 1:length(PathArray)]


## 100 Hz ##
PathArray = [
"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_15_16_41_DemagnetizedNdFeB-100Hz-long.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_15_41_39_CoilOnly-100Hz-long.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_15_55_51_Demagnetized-MagnetizedonTop-100Hz-long.tdms"

"C:\\Users\\MPI\\Documents\\Pancake Impedance on PM\\2022_01_14_14_00_20_NdFeB-1Inch-PreHeating-100Hz.tdms"]

LabelList = [PathArray[i][68:end-5] for i in 1:length(PathArray)]


