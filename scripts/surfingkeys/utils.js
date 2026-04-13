const LEADER = '\\';
const CLOSE_REGEX = /\bclose\b|关闭|關閉|✕|×/i;

/**
 * Throw an error with `msg`.
 * @param {string} msg Error message.
 */
function raise(msg) {
    throw new Error(`[Surfingkeys] ${msg}`);
}

/**
 * Return the <Leader> key.
 * @return {string}
 */
function getLeaderKey() {
    return LEADER;
}

/**
 * Return regex for close buttons.
 * @return {RegExp}
 */
function getCloseRegex() {
    return CLOSE_REGEX;
}

/**
 * @param {Element} elem
 */
function isRenderable(elem) {
    if (elem.offsetWidth && elem.offsetHeight) return true;
    else return false;
}

/**
 * An element has a 'pointer' cursor
 * or a `<button>` has an 'auto' and 'default' cursor.
 *
 * @param {Element} elem
 * @returns {boolean}
 */
function isClickable(elem) {
    const cursorStyle = getComputedStyle(elem).cursor;
    return (
        cursorStyle == 'pointer'
        || ((cursorStyle == 'auto' || cursorStyle == 'default')
            && elem.nodeName == 'BUTTON')
    );
}

/**
 * @param {Element} elem
 * @param {string} selector
 */
function matchesSelector(elem, selector) {
    return elem.matches(selector);
}

/**
 * @param {Element} elem
 * @param {RegExp} text
 */
function matchesText(elem, text) {
    return text.test(elem.textContent);
}

/**
 * @param {Element} elem
 * @param {{ [attr: string]: RegExp }?} pats
 */
function matchesPattern(elem, pats) {
    for (const [attr, reg] of Object.entries(pats)) {
        const attrValue = elem.getAttribute(attr);
        if (attrValue && reg.test(attrValue)) return true;
    }
    return false;
}

/**
 * @callback ElementFilter
 * @param {Element} elem
 * @returns {boolean}
 */

/**
 * Walk through and `filter` elements and their shadowRoots starting at `root`.
 *
 * @param {Element} root Where to start the iteration
 * @param {ElementFilter} filter A filter function for elements
 */
function walkElement(root, filter) {
    /** @type {Element[]} */
    const elems = [];
    let currentNode = null;
    const nodeIterator = document.createNodeIterator(
        root,
        NodeFilter.SHOW_ELEMENT,
        null,
    );

    while ((currentNode = nodeIterator.nextNode())) {
        if (filter(currentNode)) elems.push(currentNode);

        if (currentNode.shadowRoot) {
            elems.push(...walkElement(currentNode.shadowRoot, filter));
        }
    }

    return elems;
}

/**
 * Similar to `api.getClickableElements()` but simpler and checks attributes.
 *
 * @param {string=} selector Selector string that the elem should match
 * @param {RegExp=} text `text` regex that the elem's `textContent` should match
 * @param {{ [attr: string]: RegExp }=} pats Regex for each elem `attr` to match
 */
function getClickableElements(selector, text, pats) {
    return walkElement(document.body, (elem) => {
        return (
            isRenderable(elem)
            && isClickable(elem)
            && ((selector && matchesSelector(elem, selector))
                || (text && matchesText(elem, text))
                || (pats && matchesPattern(elem, pats)))
        );
    });
}

export { getClickableElements, getLeaderKey, getCloseRegex, raise };
