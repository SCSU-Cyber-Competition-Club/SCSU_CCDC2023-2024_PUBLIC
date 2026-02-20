$FileList = @(
    #kits/processinject
    "process_inject_spawn.c",
    #kits/sleepmask
    "sleepmask.c",
    "evasive_sleep_stack_spoof.c",
    #loader
    "loader.aps",
    "loader.rc",
    "loader.sln",
    "loader.vcxproj",
    "loader.vcxproj.filters",
    "loader.vcxproj.user",
    "resource.h",
    #loader/helpers
    "encoder.py",
    "gen_file.py",
    #loaders/injection
    "Native.h",
    "fiber.cpp",
    "stageless.cpp",
    "stager_download.cpp",
    "stager_read.cpp",
    #loader/main
    "beacon.cpp",
    "beaconsvc.cpp",
    #post-ex
    "command-all.cna",
    "inline-x.cna",
    "powerpick.cs",
    "crtl.profile",
    "mwccdc.profile"
)


foreach ($File in $FileList) {
    $result = Get-ChildItem -Path C:\ -Filter $File -Recurse -ErrorAction SilentlyContinue

    if ($result) {
        Write-Host "FILE FOUND!" -BackgroundColor Red
        if ($result -eq "resource.h") {
            Write-Host "IMPORTANT: resource.h is a generic filename. This may not be associated with Cobalt Strike. DO NOT DELETE THIS UNLESS YOU KNOW EXACTLY WHAT IT'S BEING USED FOR." -BackgroundColor Red
            }
        }
    else {
        Write-Host "$File not found." -ForegroundColor Green
    }
}