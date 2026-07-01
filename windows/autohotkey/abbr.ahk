;; abbreviations

#NoTrayIcon

ConfPath := EnvGet("USERPROFILE") . "\.config\ahkconfig.ini"

NeedsAbbr()
{
    if WinActive("ahk_exe brave.exe")
    {
        return True
    }
    return False
}

MakeAbbr(Key)
{
    try {
        Val := IniRead(ConfPath, "abbr", Key)
        Send Val
    } catch Error as Err {
        MsgBox("Failed to read ini file.`nReason: " . Err.Message)
    }
}

#HotIf NeedsAbbr()

::s;en::
{
    MakeAbbr("en")
}
::s;n::
{
    MakeAbbr("n")
}
::s;c::
{
    MakeAbbr("c")
}
::s;eg::
{
    MakeAbbr("eg")
}
::s;gw::
{
    MakeAbbr("gw")
}
::s;sc::
{
    MakeAbbr("sc")
}
::s;g::
{
    MakeAbbr("g")
}
::s;mfa::
{
    MakeAbbr("mfa")
}
