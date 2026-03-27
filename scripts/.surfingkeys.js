const {
    Hints,
    addSearchAlias,
    getClickableElements,
    imap,
    iunmap,
    map,
    mapkey,
    removeSearchAlias,
    unmap,
} = api;
const eventOptions = { bubbles: true };
const mouseOver = new MouseEvent('mouseover', eventOptions);
const mouseEnter = new MouseEvent('mouseenter', eventOptions);
const mouseOut = new MouseEvent('mouseout', eventOptions);
const mouseLeave = new MouseEvent('mouseleave', eventOptions);

const CLOSE_REGEX = /\bclose\b|关闭|關閉|x|×/i;

// }}} Keymaps {{{

// ----- general -----
map('<Ctrl-[>', '<Esc>');

// ----- tabs -----
map('swap', 't');
map('t', 'on'); // open a new tab
// history
map('H', 'S'); // backward
map('L', 'D'); // forward
unmap('S');
// scroll
map('D', 'P'); // scroll down a whole page
unmap('P');
unmap('e');
// move to the left tab
map('J', 'E');
unmap('E');
unmap('B');
// move to the right tab
map('K', 'R');
unmap('R');
// move to the previous tab
map('gl', '<Ctrl-6>');
unmap('<Ctrl-6>');
// select a tab
map('<Ctrl-t>', 'T');
unmap('T');

// ----- links -----
map('F', 'C'); // open quietly
unmap('C');
mapkey('<Ctrl-h>', 'Mouse over/enter element', function () {
    Hints.create('', function (element) {
        element.dispatchEvent(mouseOver);
        element.dispatchEvent(mouseEnter);
    });
});
mapkey('<Ctrl-j>', 'Mouse out/leave element', function () {
    Hints.create('', function (element) {
        element.dispatchEvent(mouseOut);
        element.dispatchEvent(mouseLeave);
    });
});

// ----- passthrough -----
map('<Ctrl-p>', 'p');

// ----- mouse clicks -----
map('p', 'q'); // pictures and buttons
unmap('q');
mapkey('<Ctrl-x>', 'Click close button', function () {
    const elems = getClickableElements('[rel=close]', CLOSE_REGEX);
    if (!elems.length) return false;
    Hints.click(elems);
    return true;
});

// ----- omnibar -----
map('on', 'swap'); // open in new tab
unmap('swap');
map('oN', 'go'); // open in current tab
unmap('go');
unmap('A'); // AI

// ----- search -----
addSearchAlias(
    'G',
    'github',
    'https://github.com/search?q=',
    's',
    null,
    null,
    'o',
    {
        favicon_url:
            'https://github.githubassets.com/favicons/favicon-dark.svg',
    },
);
removeSearchAlias('e'); // Wikipedia
removeSearchAlias('w'); // Bing
removeSearchAlias('s'); // Stackoverflow
removeSearchAlias('y'); // YouTube
unmap('sh'); // search with GitHub

// ----- insert -----
imap('<Ctrl-h>', '<Alt-b>'); // move one word backward
imap('<Ctrl-l>', '<Alt-f>'); // move one word forward
imap('<Ctrl-w>', '<Alt-w>'); // delete one word backward
imap('<Ctrl-d>', '<Alt-d>'); // delete one word forward
iunmap('<Alt-b>');
iunmap('<Alt-f>');
iunmap('<Alt-w>');
iunmap('<Alt-d>');

// }}} Settings {{{

// ----- cosmetic -----
settings.theme = `
.sk_theme {
  background: #1e1e2eff;
  color: #cdd6f4ff;
}

.sk_theme input {
  color: #cdd6f4ff;
}

.sk_theme .url {
  color: #a6adc8ff;
}

.sk_theme .annotation {
  color: #a6adc8ff;
}

.sk_theme kbd {
  background: #313244ff;
  color: #cdd6f4ff;
}

.sk_theme .frame {
  background: #5e78a8ff;
}

.sk_theme .omnibar_highlight {
  color: #89b4faff;
}

.sk_theme .omnibar_folder {
  color: #b4befeff;
}

.sk_theme .omnibar_timestamp {
  color: #f5c2e7ff;
}

.sk_theme .omnibar_visitcount {
  color: #89b4faff;
}

.sk_theme .prompt,
.sk_theme .resultPage {
  color: #7f849cff;
}

.sk_theme .feature_name {
  color: #fab387ff;
}

.sk_theme .separator {
  color: #89b4faff;
}

#sk_omnibar {
  box-shadow: 0px 2px 10px #11111b4d;
  font-size: 1.2em;
}

#sk_omnibarSearchArea>input {
  background: transparent;
}

#sk_omnibarSearchArea {
  border-bottom-color: #6c7086ff;
}

#sk_omnibarSearchResult {
  max-height: 70vh;
}

#sk_omnibarSearchResult.llmChat>h4 {
  background-color: #a6e3a1ff;
  color: #1e1e2eff;
}

.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
  background: #313244ff;
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused {
  background: #495a80ff;
}

.sk_theme #sk_omnibarSearchResult>ul>li.window {
  border-color: #45475aff;
}

.sk_theme #sk_omnibarSearchResult>ul>li.window.focused {
  border-color: #89b4faff;
}

.sk_theme #sk_omnibarSearchResult>ul>li {
  padding: 0.5rem 0.5rem;
}

#sk_omnibarSearchResult .tab_in_window {
  box-shadow: 0px 2px 10px #11111b4d;
}

#sk_status {
  border-color: #45475aff;
}

.expandRichHints span.annotation {
  color: #89dcebff;
}

.expandRichHints kbd>.candidates {
  color: #f38ba8ff;
}

#sk_keystroke {
  background: #1e1e2eff;
  color: #cdd6f4ff;
}

#sk_keystroke kbd {
  font-size: 1.2em;
}

#sk_usage,
#sk_popup,
#sk_editor {
  background: #1e1e2eff;
  box-shadow: 0px 2px 10px #11111b4d;
}

#sk_usage .feature_name>span {
  border-bottom-color: #45475aff;
}

kbd {
  border-color: #45475aff;
  border-bottom-color: #585b70ff;
  box-shadow: inset 0 -1px 0 #585b70ff;
}

#sk_banner {
  border-color: #f9e2afff;
  background: #766c62ff;
}

#sk_tabs {
  background: #00000085;
}

div.sk_tab {
  background: -webkit-gradient(
    linear,
    left top,
    left bottom,
    color-stop(0%, #495a80ff),
    color-stop(100%, #3e4b6bff)
  );
  box-shadow: 0px 3px 7px 0px #11111b4d;
  border-top-color: #1e1e2eff;
}

div.sk_tab_title {
  // color: #1e1e2eff;
  color: #cdd6f4ff;
}

div.sk_tab_url {
  color: #181825ff;
}

div.sk_tab_hint {
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fdf3dfff), color-stop(100%, #f9e2afff));
  color: #1e1e2eff;
  border-color: #f5d07fff;
  box-shadow: 0px 3px 7px 0px #11111b4d;
}

div.sk_tab_group {
  color: #a6adc8ff;
  border-color: #45475aff;
  background: #1e1e2eff;
}

#sk_bubble {
  border-color: #45475aff;
  box-shadow: 0 0 20px #11111b4d;
  color: #bac2deff;
  background-color: #181825ff;
}

.sk_scroller_indicator_top {
  background-image: linear-gradient(#11111bff, transparent);
}

.sk_scroller_indicator_middle {
  background-image: linear-gradient(transparent, #11111bff, transparent);
}

.sk_scroller_indicator_bottom {
  background-image: linear-gradient(transparent, #11111bff);
}

#sk_bubble * {
  color: #cdd6f4ff !important;
}

div.sk_arrow>div:nth-of-type(1) {
  border-left-color: transparent;
  border-right-color: transparent;
  background: transparent;
}

div.sk_arrow[dir=down]>div:nth-of-type(1) {
  border-top-color: #45475aff;
}

div.sk_arrow[dir=up]>div:nth-of-type(1) {
  border-bottom-color: #45475aff;
}

div.sk_arrow>div:nth-of-type(2) {
  border-left-color: transparent;
  border-right-color: transparent;
  background: transparent;
}

div.sk_arrow[dir=down]>div:nth-of-type(2) {
  border-top-color: #181825ff;
}

div.sk_arrow[dir=up]>div:nth-of-type(2) {
  border-bottom-color: #181825ff;
}`;
