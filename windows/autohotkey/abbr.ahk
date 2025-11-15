;; abbreviations

#NoTrayIcon

NeedsAbbr()
{
    if WinActive("ahk_exe brave.exe")
    {
        return True
    }
    return False
}

#HotIf NeedsAbbr()

::s;en::site:english.news.cn
::s;n::site:news.cn
::s;c::site:chinadaily.com.cn
::s;eg::site:english.www.gov.cn
::s;gw::site:www.gov.cn
::s;sc::site:sc.gov.cn
::s;g::site:gov.cn
::s;mfa::site:mfa.gov.cn
