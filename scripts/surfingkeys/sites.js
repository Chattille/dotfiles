const { mapkey } = api;
import { click, getLeaderKey, hover, raise, unhover } from './utils';

const LEADER = getLeaderKey();
const DARKMODE_SWITCHER = `${LEADER}d`;

/**
 * @param {string} query
 * @param {Element} source
 * @return {Element}
 */
function queryFrom(query, source) {
    const target = source.querySelector(query);
    if (!target) raise(`Query '${query}' not found.`);
    return target;
}

function setupBilibili() {
    function toggleDarkMode() {
        // Surfingkeys only checks domains
        // so check paths here and do nothing for these pages
        const link = window.location.href;
        if (
            /www\.bilibili\.com\/(?:blackboard|match|tv\/$|movie\/$|documentary\/$)/i.test(
                link,
            )
        ) {
            return;
        }

        const ctx = {
            avatarMenu: null,
            colorschemeMenu: null,
        };

        /** Check current colorscheme. */
        function isDark() {
            if (link == 'https://www.bilibili.com/') {
                // home page
                return document
                    .getElementsByTagName('html')[0]
                    .classList.contains('bili_dark');
            } else if (link.match('https://www.bilibili.com/video/')) {
                // video page
                return document
                    .getElementsByTagName('html')[0]
                    .classList.contains('night-mode');
            } else {
                // search page, user page, bangumi page, etc.
                // check stylesheet
                const styleId = '#__css-map__';
                /** @type {HTMLLinkElement} */
                const stylesheet = queryFrom(styleId, document.head);
                return stylesheet.href.includes('dark.css');
            }
        }

        /** @param {Element} options  */
        function toggleColorscheme(options) {
            const mode = queryFrom(
                `.single-link-item.sub-link-item:${
                    isDark() ? 'last' : 'first'
                }-child`,
                options,
            );

            // change colorscheme
            click(mode);

            // hide menu popups
            unhover(ctx.colorschemeMenu);
            unhover(ctx.avatarMenu);
        }

        /** @type {MutationCallback} */
        function colorschemeMenuCallback(ms, observer) {
            for (const m of ms) {
                if (m.type != 'childList') continue;
                if (!m.addedNodes.length) continue;

                const classes = m.addedNodes[0].classList;
                if (
                    classes.contains('v-popover')
                    && classes.contains('is-right')
                ) {
                    // colorscheme options popped up
                    observer.disconnect();
                    toggleColorscheme(m.addedNodes[0]);
                }
            }
        }

        /** @param {Element} panel */
        function avatarPanelHandler(panel) {
            // find colorscheme menu
            const colorschemeMenu = queryFrom(
                '.links-item:not(:has(~ .links-item)) .v-popover-wrap',
                panel,
            );
            ctx.colorschemeMenu = colorschemeMenu;

            // show colorscheme options
            hover(colorschemeMenu);

            const colorschemeOptions = colorschemeMenu.querySelector(
                '.v-popover.is-right',
            );
            if (colorschemeOptions) {
                toggleColorscheme(colorschemeOptions);
            } else {
                // wait for the colorscheme options to pop up
                const colorschemeMenuObserver = new MutationObserver(
                    colorschemeMenuCallback,
                );
                colorschemeMenuObserver.observe(colorschemeMenu, {
                    childList: true,
                });
            }
        }

        /** @type {MutationCallback} */
        function avatarCallback(ms, observer) {
            for (const m of ms) {
                if (m.type != 'childList') continue;
                if (!m.addedNodes.length) continue;

                const classes = m.addedNodes[0].classList;
                if (
                    classes.contains('v-popover')
                    && classes.contains('is-bottom')
                ) {
                    // avatar panel popped up
                    observer.disconnect();
                    // continue subsequent handling
                    avatarPanelHandler(m.addedNodes[0]);
                }
            }
        }

        const avatarMenu = queryFrom('.header-avatar-wrap', document);
        ctx.avatarMenu = avatarMenu;

        // show avatar panel
        hover(avatarMenu);

        const avatarPanel = avatarMenu.querySelector('.v-popover.is-bottom');
        if (avatarPanel) {
            avatarPanelHandler(avatarPanel);
        } else {
            // wait for the avatar panel to pop up
            const avatarMenuObserver = new MutationObserver(avatarCallback);
            avatarMenuObserver.observe(avatarMenu, { childList: true });
        }
    }

    mapkey(DARKMODE_SWITCHER, 'Toggle dark mode', toggleDarkMode, {
        domain: /.*(?<!app|game|link|live|love|member|show)\.bilibili\.com/i,
    });
}

function setupSites() {
    setupBilibili();
}

export { setupSites };
