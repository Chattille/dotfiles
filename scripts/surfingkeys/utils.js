const LEADER = '\\';
const CLOSE_REGEX_ATTR = /(?<![a-zA-Z0-9])close(?![a-zA-Z0-9])/i;
const CLOSE_REGEX_TEXT = /\bclose\b|关闭|關閉|✕|×/i;

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
 * @param {'text' | 'attr'} type Regex for matching `text`-like content or HTML `attr`s.
 * @return {RegExp}
 */
function getCloseRegex(type) {
    if (type === 'text') return CLOSE_REGEX_TEXT;
    else return CLOSE_REGEX_ATTR;
}

/**
 * @param {Element} elem
 */
function isRenderable(elem) {
    const elemRect = elem.getBoundingClientRect();
    return (
        // has size or is a line
        elemRect.width + elemRect.height > 0
        // is in viewport
        && elemRect.top >= 0
        && elemRect.left >= 0
        && elemRect.bottom
            <= (window.innerHeight || document.documentElement.clientHeight)
        && elemRect.right
            <= (window.innerWidth || document.documentElement.clientWidth)
    );
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
 * Click the element.
 * @param {Element} elem
 */
function click(elem) {
    elem.dispatchEvent(new MouseEvent('click', { bubbles: true }));
}

/**
 * Hover over the element.
 * @param {Element} elem
 */
function hover(elem) {
    elem.dispatchEvent(new MouseEvent('mouseover', { bubbles: true }));
    elem.dispatchEvent(new MouseEvent('mouseenter', { bubbles: true }));
}

/**
 * Move the cursor away from the element.
 * @param {Element} elem
 */
function unhover(elem) {
    elem.dispatchEvent(new MouseEvent('mouseout', { bubbles: true }));
    elem.dispatchEvent(new MouseEvent('mouseleave', { bubbles: true }));
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

export {
    click,
    getClickableElements,
    getLeaderKey,
    getCloseRegex,
    hover,
    raise,
    unhover,
};
