import theme from './theme';

import { setupSites } from './sites';
import {
    click,
    getClickableElements,
    getLeaderKey,
    getCloseRegex,
    hover,
    unhover,
} from './utils';

const CLOSE_REGEX = getCloseRegex();
const LEADER = getLeaderKey();

const {
    Hints,
    addSearchAlias,
    imap,
    iunmap,
    map,
    mapkey,
    removeSearchAlias,
    unmap,
} = api;

// }}} Keymaps {{{

// ----- site-specific -----
setupSites();

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

// ----- passthrough -----
map('<Ctrl-p>', 'p');
unmap('p');

// ----- mouse actions -----
map(`${LEADER}q`, 'q'); // pictures and buttons
unmap('q');
mapkey(`${LEADER}x`, 'Click close button', () => {
    const elems = getClickableElements('[rel=close]', CLOSE_REGEX, {
        ['aria-label']: CLOSE_REGEX,
        title: CLOSE_REGEX,
    });
    if (!elems.length) return;

    Hints.create(elems, (element) => click(element));
});
mapkey(`${LEADER}j`, 'Mouse over/enter an element', () => {
    Hints.create('', (element) => hover(element));
});
unmap('<Ctrl-h>');
mapkey(`${LEADER}k`, 'Mouse out/leave an element', () => {
    Hints.create('', (element) => unhover(element));
});
unmap('<Ctrl-j>');
mapkey(`${LEADER}v`, 'Play/pause video', () => {
    Hints.create('video', (element) => {
        if (element.paused) element.play();
        else element.pause();
    });
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
imap('<Ctrl-b>', '<Ctrl-f>'); // move to line start
iunmap('<Alt-b>');
iunmap('<Alt-f>');
iunmap('<Alt-w>');
iunmap('<Alt-d>');
iunmap('<Ctrl-f>');

// }}} Settings {{{
settings.modeAfterYank = 'Normal';
settings.verticalTabs = false;
settings.hintAlign = 'left';
settings.theme = theme;
