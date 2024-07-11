;; characters with diacritics

#NoTrayIcon

Contexts := ["brave.exe", "GoldenDict.exe", "WeChat.exe", "WindowsTerminal.exe"]
NeedsAccents()
{
    for win in Contexts
    {
        if WinActive("ahk_exe " . win)
        {
            return True
        }
    }
    return False
}

#HotIf NeedsAccents()

Trigger := 0
!e::global Trigger := 1 ; acute
!\::global Trigger := 2 ; grave
!a::global Trigger := 3 ; macron
!u::global Trigger := 4 ; trema
!3::global Trigger := 5 ; caron
!i::global Trigger := 6 ; circumflex
!,::global Trigger := 7 ; cedilla
!n::global Trigger := 8 ; tilde

MakeAccent(Char)
{
    Send Char
    global Trigger := 0
}

#Hotstring C * ?

#HotIf (Trigger = 1) ; acute

::a::
{
    MakeAccent "{U+00E1}"
}
::e::
{
    MakeAccent "{U+00E9}"
}
::i::
{
    MakeAccent "{U+00ED}"
}
::o::
{
    MakeAccent "{U+00F3}"
}
::u::
{
    MakeAccent "{U+00FA}"
}
::A::
{
    MakeAccent "{U+00C1}"
}
::E::
{
    MakeAccent "{U+00C9}"
}
::I::
{
    MakeAccent "{U+00CD}"
}
::O::
{
    MakeAccent "{U+00D3}"
}
::U::
{
    MakeAccent "{U+00DA}"
}

#HotIf (Trigger = 2) ; grave

::a::
{
    MakeAccent "{U+00E0}"
}
::e::
{
    MakeAccent "{U+00E8}"
}
::i::
{
    MakeAccent "{U+00EC}"
}
::o::
{
    MakeAccent "{U+00F2}"
}
::u::
{
    MakeAccent "{U+00F9}"
}
::A::
{
    MakeAccent "{U+00C0}"
}
::E::
{
    MakeAccent "{U+00C8}"
}
::I::
{
    MakeAccent "{U+00CC}"
}
::O::
{
    MakeAccent "{U+00D2}"
}
::U::
{
    MakeAccent "{U+00D9}"
}

#HotIf (Trigger = 3) ; macron

::a::
{
    MakeAccent "{U+0101}"
}
::e::
{
    MakeAccent "{U+0113}"
}
::i::
{
    MakeAccent "{U+012B}"
}
::o::
{
    MakeAccent "{U+014D}"
}
::u::
{
    MakeAccent "{U+016B}"
}
::A::
{
    MakeAccent "{U+0100}"
}
::E::
{
    MakeAccent "{U+0112}"
}
::I::
{
    MakeAccent "{U+012A}"
}
::O::
{
    MakeAccent "{U+014C}"
}
::U::
{
    MakeAccent "{U+016A}"
}

#HotIf (Trigger = 4) ; trema

::a::
{
    MakeAccent "{U+00E4}"
}
::e::
{
    MakeAccent "{U+00EB}"
}
::i::
{
    MakeAccent "{U+00EF}"
}
::o::
{
    MakeAccent "{U+00F6}"
}
::u::
{
    MakeAccent "{U+00FC}"
}
::A::
{
    MakeAccent "{U+00C4}"
}
::E::
{
    MakeAccent "{U+00CB}"
}
::I::
{
    MakeAccent "{U+00CF}"
}
::O::
{
    MakeAccent "{U+00D6}"
}
::U::
{
    MakeAccent "{U+00DC}"
}

#HotIf (Trigger = 5) ; caron

::a::
{
    MakeAccent "{U+01CE}"
}
::e::
{
    MakeAccent "{U+011B}"
}
::i::
{
    MakeAccent "{U+01D0}"
}
::o::
{
    MakeAccent "{U+01D2}"
}
::u::
{
    MakeAccent "{U+01D4}"
}
::A::
{
    MakeAccent "{U+01CD}"
}
::E::
{
    MakeAccent "{U+011A}"
}
::I::
{
    MakeAccent "{U+01CF}"
}
::O::
{
    MakeAccent "{U+01D1}"
}
::U::
{
    MakeAccent "{U+01D3}"
}

#HotIf (Trigger = 6) ; circumflex

::a::
{
    MakeAccent "{U+00E2}"
}
::e::
{
    MakeAccent "{U+00EA}"
}
::i::
{
    MakeAccent "{U+00EE}"
}
::o::
{
    MakeAccent "{U+00F4}"
}
::u::
{
    MakeAccent "{U+00FB}"
}
::A::
{
    MakeAccent "{U+00C2}"
}
::E::
{
    MakeAccent "{U+00CA}"
}
::I::
{
    MakeAccent "{U+00CE}"
}
::O::
{
    MakeAccent "{U+00D4}"
}
::U::
{
    MakeAccent "{U+00DB}"
}

#HotIf (Trigger = 7) ; cedilla

::c::
{
    MakeAccent "{U+00E7}"
}
::C::
{
    MakeAccent "{U+00C7}"
}

#HotIf (Trigger = 8) ; tilde

::n::
{
    MakeAccent "{U+00F1}"
}
::N::
{
    MakeAccent "{U+00D1}"
}