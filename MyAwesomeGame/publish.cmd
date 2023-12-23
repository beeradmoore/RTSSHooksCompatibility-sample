@echo off

dotnet publish ./MyAwesomeGame/MyAwesomeGame.csproj --verbosity normal --self-contained -r win-x64 -c Release -o .\publish\with_rtss_enabled\
dotnet publish ./MyAwesomeGame/MyAwesomeGame.csproj --verbosity normal --self-contained -r win-x64 -c Release_RTSS_Disabled -o .\publish\with_rtss_disabled\
