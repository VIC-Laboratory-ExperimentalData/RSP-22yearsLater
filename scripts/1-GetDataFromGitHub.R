## INSTALLATION OF THE LIBRARY

devtools::install_github("dcousin3/BornOpenData4EPrime/BornOpenData.eprime2")
library(BornOpenData.eprime2)


## Fetching the results (the branch is "main", not the default "master")
tt = readBornOpenData.eprime2(
        "VIC-Laboratory-ExperimentalData",
        "RSP-22yearsLater",
        branch = "main",
        verbose = TRUE)

## Removes all the columns collected by E-Prime that are unneeded...
tt2 <- subset(tt, select = -c(Procedure.Experiment, Running.Experiment,
        Experiment, DataFile.Basename, ExperimentVersion, 
        Procedure.Block, Running.Block, Cycle, 
        Sample, Running.Trial, 
        SessionStartDateTimeUtc, Group, StudioVersion, 
        RuntimeVersion, RuntimeVersionExpected, RuntimeCapabilities,
        VersionPersist, LevelName, Display.RefreshRate,

        ShowRSSPStimuli2.ACC,ShowRSSPStimuli3.ACC,ShowRSSPStimuli4.ACC,
        ShowRSFPStimuli2.ACC,ShowRSFPStimuli3.ACC,ShowRSFPStimuli4.ACC,
        ShowRSSPStimuli2.RT, ShowRSSPStimuli3.RT, ShowRSSPStimuli4.RT,
        ShowRSFPStimuli2.RT, ShowRSFPStimuli3.RT, ShowRSFPStimuli4.RT,
        ShowRSSPStimuli2.RTTime,ShowRSSPStimuli3.RTTime,ShowRSSPStimuli4.RTTime,
        ShowRSFPStimuli2.RTTime,ShowRSFPStimuli3.RTTime,ShowRSFPStimuli4.RTTime,
        ShowRSSPStimuli2.CRESP, ShowRSSPStimuli3.CRESP, ShowRSSPStimuli4.CRESP,
        ShowRSFPStimuli2.CRESP, ShowRSFPStimuli3.CRESP, ShowRSFPStimuli4.CRESP,
        ShowRSSPStimuli2.OnsetTime,ShowRSSPStimuli3.OnsetTime,ShowRSSPStimuli4.OnsetTime,
        ShowRSFPStimuli2.OnsetTime,ShowRSFPStimuli3.OnsetTime,ShowRSFPStimuli4.OnsetTime,
        ShowRSSPStimuli2.OnsetDelay, ShowRSSPStimuli3.OnsetDelay, ShowRSSPStimuli4.OnsetDelay,
        ShowRSFPStimuli2.OnsetDelay, ShowRSFPStimuli3.OnsetDelay, ShowRSFPStimuli4.OnsetDelay,
        ShowRSSPStimuli2.DurationError,ShowRSSPStimuli3.DurationError,ShowRSSPStimuli4.DurationError,
        ShowRSFPStimuli2.DurationError,ShowRSFPStimuli3.DurationError,ShowRSFPStimuli4.DurationError,
        ShowRSSPStimuli2.OnsetToOnsetTime, ShowRSSPStimuli3.OnsetToOnsetTime, ShowRSSPStimuli4.OnsetToOnsetTime,
        ShowRSFPStimuli2.OnsetToOnsetTime, ShowRSFPStimuli3.OnsetToOnsetTime, ShowRSFPStimuli4.OnsetToOnsetTime,
        ShowRSSPStimuli2.RESP,ShowRSSPStimuli3.RESP,ShowRSSPStimuli4.RESP,
        ShowRSFPStimuli2.RESP,ShowRSFPStimuli3.RESP,ShowRSFPStimuli4.RESP,
        ShowRSSPStimuli1.RTTime, ShowRSSPStimuli1.CRESP, ShowRSSPStimuli1.RESP,
        ShowRSFPStimuli1.RTTime, ShowRSFPStimuli1.CRESP, ShowRSFPStimuli1.OnsetTime,
        ShowRSFPStimuli1.OnsetDelay, ShowRSFPStimuli1.DurationError, ShowRSFPStimuli1.OnsetToOnsetTime,
        ShowRSFPStimuli1.RESP,
        ShowSimStimuli.RTTime, ShowSimStimuli.CRESP, ShowSimStimuli.OnsetTime,
        ShowSimStimuli.OnsetDelay, ShowSimStimuli.DurationError, ShowSimStimuli.OnsetToOnsetTime, 
        ShowSimStimuli.RESP
        )
    )

## Exporting to a tab-separaged value file
write.table(tt2, file = "RSP22.tsv", sep = "\t", 
    quote = FALSE, row.names = TRUE)

