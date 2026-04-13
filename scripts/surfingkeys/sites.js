const { mapkey } = api;
import { getLeaderKey, raise } from './utils';

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
        function isDark() {
            // check current colorscheme
            const styleId = '#__css-map__';
            /** @type {HTMLLinkElement} */
            const stylesheet = queryFrom(styleId, document.head);
            return stylesheet.href.includes('dark.css');
        }

        /** @param {Element} menu  */
        function toggleColorscheme(menu) {
            const mode = queryFrom(
                `.single-link-item.sub-link-item:${
                    isDark() ? 'last' : 'first'
                }-child`,
                menu,
            );
            mode.dispatchEvent(new MouseEvent('click', { bubbles: true }));

            // hide popups
            queryFrom('.header-avatar-wrap', document).dispatchEvent(
                new MouseEvent('mouseleave', { bubbles: true }),
            );
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
                    // colorscheme menu popped up
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

            // show colorscheme options
            colorschemeMenu.dispatchEvent(
                new MouseEvent('mouseenter', { bubbles: true }),
            );

            const colorschemeOptions = colorschemeMenu.querySelector(
                '.v-popover.is-right',
            );
            if (colorschemeOptions) {
                toggleColorscheme(colorschemeOptions);
            } else {
                // wait for the colorscheme selector to pop up
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

        // show avatar panel
        avatarMenu.dispatchEvent(
            new MouseEvent('mouseenter', { bubbles: true }),
        );

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
        domain: /.*\.bilibili\.com/i,
    });
}

function setupSites() {
    setupBilibili();
}

export { setupSites };
