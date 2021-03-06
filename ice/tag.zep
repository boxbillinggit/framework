
namespace Ice;

use Ice\Exception;
use Ice\Di\DiInterface;

/**
 * Tag helper is designed to simplify building of HTML tags.
 *
 * @package     Ice/Tag
 * @category    Helper
 * @author      Ice Team
 * @copyright   (c) 2014 Ice Team
 * @license     http://iceframework.org/license
 * @uses        Url service
 */
class Tag
{

    const HTML32 = 1;
    const HTML401_STRICT = 2;
    const HTML401_TRANSITIONAL = 3;
    const HTML401_FRAMESET = 4;
    const HTML5 = 5;
    const XHTML10_STRICT = 6;
    const XHTML10_TRANSITIONAL = 7;
    const XHTML10_FRAMESET = 8;
    const XHTML11 = 9;
    const XHTML20 = 10;
    const XHTML5 = 11;

    protected _values { get };
    protected _docType = 5 { set };
    protected _title = null { set, get };
    protected _titleSeparator = " - " { set, get };
    protected _url;

    public function __construct()
    {
        var di;

        let di = Di::$fetch(),
            this->_url = di->getUrl();
    }

    /**
     * Appends a text to current document title
     *
     * @param string title
     * @param string separator
     * @return void
     */
    public function appendTitle(string title, string separator = null) -> void
    {
        let this->_title = this->_title . (separator ? separator : this->_titleSeparator) . title;
    }

    /**
     * Prepends a text to current document title
     *
     * @param string title
     * @param string separator
     * @return void
     */
    public function prependTitle(string title, string separator = null) -> void
    {
        let this->_title = title . (separator ? separator : this->_titleSeparator) . this->_title;
    }

    /**
     * Builds a HTML INPUT[type="text"] tag
     *
     * @param array parameters
     * @return string
     */
    public function textField(array parameters) -> string
    {
        return this->input("text", parameters);
    }

    /**
     * Builds a HTML INPUT[type="password"] tag
     *
     * @param array parameters
     * @return string
     */
    public function passwordField(array parameters) -> string
    {
        return this->input("password", parameters);
    }

    /**
     * Builds a HTML INPUT[type="hidden"] tag
     *
     * @param array parameters
     * @return string
     */
    public function hiddenField(array parameters) -> string
    {
        return this->input("hidden", parameters);
    }

    /**
     * Builds a HTML INPUT[type="file"] tag
     *
     * @param array parameters
     * @return string
     */
    public function fileField(array parameters) -> string
    {
        return this->input("file", parameters);
    }

    /**
     * Builds a HTML INPUT[type="submit"] tag
     *
     * @param array parameters
     * @return string
     */
    public function submitButton(array parameters) -> string
    {
        return self::input("submit", parameters);
    }

    /**
     * Builds a HTML BUTTON tag
     *
     * @param array parameters
     * @return string
     */
    public function button(array parameters) -> string
    {
        var defaultParams;

        let defaultParams = [
            "id": 0,
            "name": 0,
            "content": 1,
            "type": "submit"
        ];

        return this->tagHtml("button", parameters, defaultParams, ["content"], "content", true);
    }

    /**
     * Builds a HTML INPUT[type="checkbox"] tag
     *
     * @param array parameters
     * @return string
     */
    public function checkField(array parameters) -> string
    {
        return this->input("checkbox", parameters);
    }

    /**
     * Builds generic INPUT tags
     *
     * @param string type
     * @param array parameters
     * @return string
     */
    private function input(string type, array parameters) -> string
    {
        var defaultParams;

        let defaultParams = [
            "id": 0,
            "name": 0,
            "value": 1,
            "type": type
        ];

        return this->tagHtml("input", parameters, defaultParams, [], null, false, false, true);
    }

    /**
     * Builds a HTML FORM tag
     *
     * @param array parameters
     * @return string
     */
    public function form(array parameters) -> string
    {
        var defaultParams, action, local;

        let defaultParams = [
            "action": 0,
            "method": "post"
        ];

        if !fetch local, parameters["local"] {
            let local = true;
        }

        if local {
            if !fetch action, parameters["action"] {
                fetch action, parameters[defaultParams["action"]];
            }

            if action !== false {
                let parameters["action"] = this->_url->get(action);
            }
        }

        return this->tagHtml("form", parameters, defaultParams, ["local"]);
    }

    /**
     * Builds a HTML TEXTAREA tag
     *
     * @param array parameters
     * @return string
     */
    public function textArea(array parameters) -> string
    {
        var defaultParams;

        let defaultParams = [
            "id": 0,
            "name": 0,
            "value": 1
        ];

        return this->tagHtml("textarea", parameters, defaultParams, ["value"], "value", true);
    }

    /**
     * Alias of the `img` method
     */
    public function image(array parameters) -> string
    {
        return this->img(parameters);
    }

    /**
     * Builds HTML IMG tags
     *
     * @param array parameters
     * @return string
     */
    public function img(array parameters) -> string
    {
        var defaultParams, src, local;

        let defaultParams = [
            "src": 0,
            "alt": 1
        ];

        if !fetch local, parameters["local"] {
            let local = true;
        }

        if local {
            if !fetch src, parameters["src"] {
                fetch src, parameters[defaultParams["src"]];
            }

            let parameters["src"] = this->_url->getStatic(src);
        }

        return this->tagHtml("img", parameters, defaultParams, ["local"], null, false, false, true);
    }

    /**
     * Alias of the `a` method
     */
    public function linkTo(array parameters) -> string
    {
        return this->a(parameters);
    }
    /**
     * Builds a HTML A tag using framework conventions
     *
     * @param array parameters
     * @return string
     */
    public function a(array parameters) -> string
    {
        var defaultParams, href, local, query;

        let defaultParams = [
            "href": 0,
            "anchor": 1,
            "title": 2
        ];

        if !fetch href, parameters["href"] {
            fetch href, parameters[defaultParams["href"]];
        }

        if !fetch local, parameters["local"] {
            let local = true;
        }

        fetch query, parameters["query"];

        let parameters["href"] = this->_url->get(href, query, local);

        return this->tagHtml("a", parameters, defaultParams, ["anchor", "local", "query"], "anchor", true);
    }

    /**
     * Builds a LINK[rel="stylesheet"] tag
     *
     * @param array parameters
     * @return string
     */
    public function link(array parameters) -> string
    {
        var defaultParams, href, local;

        let defaultParams = [
            "href": 0,
            "type": "text/css",
            "rel": "stylesheet"
        ];

        if !fetch local, parameters["local"] {
            let local = true;
        }

        if local {
            if !fetch href, parameters["href"] {
                fetch href, parameters[defaultParams["href"]];
            }

            let parameters["href"] = this->_url->getStatic(href);
        }

        return this->tagHtml("link", parameters, defaultParams, ["local"], null, false, true, true);
    }

    /**
     * Builds a SCRIPT[type="javascript"] tag
     *
     * @param array parameters
     * @return string
     */
    public function script(array parameters) -> string
    {
        var defaultParams, src, local;

        let defaultParams = [
            "src": 0,
            "type": "text/javascript"
        ];

        if !fetch local, parameters["local"] {
            let local = true;
        }

        if local {
            if !fetch src, parameters["src"] {
                fetch src, parameters[defaultParams["src"]];
            }

            if src {
                let parameters["src"] = this->_url->getStatic(src);
            }
        }

        return this->tagHtml("script", parameters, defaultParams, ["local", "content"], "content", true) . PHP_EOL;
    }

    /**
     * Builds a STYLE tag
     *
     * @param array parameters
     * @return string
     */
    public function style(array parameters) -> string
    {
        var defaultParams;

        let defaultParams = [
            "content": 0,
            "type": "text/css"
        ];

        return this->tagHtml("style", parameters, defaultParams, ["content"], "content", true, true);
    }

    /**
     * Builds a HTML tag
     *
     * @param string name Name of tag
     * @param array params Parameters like id, style
     * @param array defaultParams Default paramerters
     * @param array skip Skip parameters
     * @param string content Parameter name to append content
     * @param boolean close Close tag
     * @param boolean eol Add end of line
     * @param boolean single Void element, close a tag by " />" (depending on doctype)
     * @return string
     */
    public function tagHtml(string name, array! params = [], array defaultParams = [], array skip = [], string content = null, boolean close = false, boolean eol = false, boolean single = false) -> string
    {
        var param, key, value, attributes, code;

        let attributes = [];

        for param, key in defaultParams {
            if is_numeric(key) {
                if fetch value, params[key] {
                    let attributes[param] = value;
                }
            } else {
                let attributes[param] = key;
            }
        }

        for key in defaultParams {
            unset params[key];
        }

        let attributes = array_merge(attributes, params),
            code = this->prepareTag(name, attributes, skip, single);

        if eol {
            let code .= PHP_EOL;
        }

        if content {
            if fetch value, attributes[content] {
                let code .= value;
            }
        }

        if close {
            let code .= (eol ? PHP_EOL : "") . this->endTag(name, eol);
        }

        return code;
    }

    /**
     * Builds a HTML close tag
     *
     * @param string name
     * @param boolean eol
     * @return string
     */
    public function endTag(string name, boolean eol = true) -> string
    {
        return "</" . name . ">" . (eol ? PHP_EOL : "");
    }

    /**
     * Renders parameters keeping order in html attributes
     *
     * @param string name
     * @param array attributes
     * @param array skip
     * @param boolean single
     * @return string
     */
    public function prepareTag(string! name, array! attributes, array skip = [], boolean single = false) -> string
    {
        var order, keys, attrs, code, tmp, value, key;

        let order = ["rel", "type", "for", "src", "href", "action", "id", "name", "value", "class", "style"],
            keys = array_intersect_key(array_flip(order), attributes),
            attrs = array_merge(keys, attributes),
            code = "<" . name;

        if fetch tmp, attrs["name"] {
            if this->hasValue(tmp) {
                let attrs["value"] = this->getValue(tmp);

                if fetch tmp, attrs["type"] {
                    // Automatically check inputs
                    if tmp == "checkbox" || tmp == "radio" {
                        let attrs["checked"] = "checked";
                    }
                }
            }
        }

        for key, value in attrs {
            if typeof key == "string" && value !== null && value !== false && !in_array(key, skip) {
                let code .= " " . key . "=\"" . value. "\"";
            }
        }

        if single {
            let code .= this->_docType > self::HTML5 ? " />" : ">";
        } else {
            let code .= ">";
        }

        return code;
    }

    /**
     * Check if a helper has a default value set using Ice\Tag::setValues or value from _POST
     *
     * @param string name
     * @return boolean
     */
    public function hasValue(string name) -> boolean
    {
        // Check if there is a predefined value for it
        if isset this->_values[name] {
            return true;
        } else {
            // Check if there is a post value for the item
            if isset _POST[name] {
                return true;
            }
        }

        return false;
    }

    /**
     * Assigns default values to generated tags by helpers
     *
     * @param string id
     * @param mixed value
     * @return void
     */
    public function setValue(string! id, value) -> void
    {
        if value !== null {
            if typeof value == "array" || typeof value == "object" {
                throw new Exception("Only scalar values can be assigned to UI components");
            }
        }
        let this->_values[id] = value;
    }

    /**
     * Assigns default values to generated tags by helpers
     *
     * @param array values
     * @param boolean merge
     * @return void
     */
    public function setValues(array values, boolean merge = false) -> void
    {
        var current;

        if typeof values != "array" {
            throw new Exception("An array is required as default values");
        }

        if merge {
            let current = this->_values;
            if typeof current == "array" {
                let this->_values = array_merge(current, values);
            } else {
                let this->_values = values;
            }
        } else {
            let this->_values = values;
        }
    }

    /**
     * Every helper calls this function to check whether a component has a predefined value using Ice\Tag::setValue or value from _POST
     *
     * @param string name
     * @param mixed params
     * @return mixed
     */
    public function getValue(string name, var params = null)
    {
        var value;

        if !params || !fetch value, params["value"] {
            // Check if there is a predefined value for it
            if !fetch value, this->_values[name] {
                // Check if there is a post value for the item
                if !fetch value, _POST[name] {
                    return null;
                }
            }
        }

        return value;
    }

    /**
     * Converts texts into URL-friendly titles
     *
     * @param string text
     * @param string separator
     * @param boolean lowercase
     * @param mixed replace
     * @return string
     */
    public function friendlyTitle(string text, string separator = "-", boolean lowercase = true, replace = null) -> string
    {
        var friendly, locale;

        if extension_loaded("iconv") {
            // Save the old locale and set the new locale to UTF-8
            let locale = setlocale(LC_ALL, "en_US.UTF-8"),
                text = iconv("UTF-8", "ASCII//TRANSLIT", text);
        }

        if replace {
            if typeof replace != "array" && typeof replace != "string"{
                throw new Exception("Parameter replace must be an array or a string");
            }
            let text = str_replace(replace, " ", text);
        }

        let friendly = preg_replace("/[^a-zA-Z0-9\\/_|+ -]/", "", text);
        if lowercase {
            let friendly = strtolower(friendly);
        }

        let friendly = preg_replace("/[\\/_|+ -]+/", separator, friendly),
            friendly = trim(friendly, separator);

        if extension_loaded("iconv") {
            // Revert back to the old locale
            setlocale(LC_ALL, locale);
        }
        return friendly;
    }

    /**
     * Get the document type declaration of content
     *
     * @return string
     */
    public function getDocType() -> string
    {

        switch this->_docType {
            case self::HTML32:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">" . PHP_EOL;
            case self::HTML401_STRICT:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"" . PHP_EOL . "\t\"http://www.w3.org/TR/html4/strict.dtd\">" . PHP_EOL;
            case self::HTML401_TRANSITIONAL:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"" . PHP_EOL . "\t\"http://www.w3.org/TR/html4/loose.dtd\">" . PHP_EOL;
            case self::HTML401_FRAMESET:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\"" . PHP_EOL . "\t\"http://www.w3.org/TR/html4/frameset.dtd\">" . PHP_EOL;
            case self::HTML5:  return "<!DOCTYPE html>" . PHP_EOL;
            case self::XHTML10_STRICT:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"" . PHP_EOL . "\t\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">" . PHP_EOL;
            case self::XHTML10_TRANSITIONAL:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"" . PHP_EOL."\t\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" . PHP_EOL;
            case self::XHTML10_FRAMESET:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\"" . PHP_EOL . "\t\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">" . PHP_EOL;
            case self::XHTML11:  return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\"" . PHP_EOL . "\t\"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">" . PHP_EOL;
            case self::XHTML20: return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 2.0//EN\"" . PHP_EOL . "\t\"http://www.w3.org/MarkUp/DTD/xhtml2.dtd\">" . PHP_EOL;
            case self::XHTML5:  return "<!DOCTYPE html>" . PHP_EOL;
        }

        return "";
    }

}