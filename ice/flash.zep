
namespace Ice;

use Ice\Di\DiInterface;

class Flash
{

    protected _session;
    protected _tag;
    protected _options = [
        "session_key": "_flash",
        "success": ["class": "alert alert-success"],
        "info": ["class": "alert alert-info"],
        "warning": ["class": "alert alert-warning"],
        "danger": ["class": "alert alert-danger"],
        "html": true
    ];

    public function __construct(array options = [])
    {
        var di;

        let di = Di::$fetch(),
            this->_session = di->getSession(),
            this->_tag = di->getTag();

        if count(options) {
            let this->_options = options;
        }
    }

    /**
     * Get option value with key.
     *
     * @param string key The option key
     * @param mixed defaultValue The value to return if option key does not exist
     * @return mixed
     */
    public function getOption(string! key, var defaultValue = null)
    {
        var value;

        if fetch value, this->_options[key] {
            return value;
        }
        return defaultValue;
    }

    /**
     * Display the messages
     *
     * @param boolean remove
     * @return string
     */
    public function getMessages(boolean remove = true) -> string
    {
        var key, type, message, messages, body;

        let key = this->getOption("session_key"),
            messages = this->_session->get(key),
            body = "";

        if typeof messages == "array" {
            for type, message in messages {
                let body .= this->getMessage(type, message);
            }
        }

        if remove {
            this->_session->remove(key);
        }

        return body;
    }

    /**
     * Get a message formatting it with HTML
     *
     * @param string type
     * @param mixed message
     */
    public function getMessage(string type, var messages)
    {
        var params, body, close, message;

        let params = this->getOption(type),
            close = this->_tag->a(["#", "×", "class": "close"]),
            body = "";

        if typeof messages != "array" {
            let messages = [messages];
        }

        for message in messages {
            if this->getOption("html") {
                let body .= this->_tag->tagHtml("div", params, ["content": close . message],  ["content"], "content", true) . PHP_EOL;
            } else {
                let body .= message . PHP_EOL;
            }
        }

        return body;
    }

    /**
     * Adds a message to the flash
     *
     * @param string type
     * @param string message
     */
    public function message(string type, string message) -> void
    {
        var key, messages;

        let key = this->getOption("session_key"),
            messages = this->_session->get(key, []);

        if !isset messages[type] {
            let messages[type] = [];
        }

        let messages[type][] = message;

        this->_session->set(key, messages);
    }

    /**
     * Add success message
     *
     * @param string message
     * @return void
     */
    public function success(string message) -> void
    {
        this->message("success", message);
    }

    /**
     * Alias of success message
     */
    public function ok(string message) -> void
    {
        this->message("success", message);
    }

    /**
     * Add info message
     *
     * @param string message
     * @return void
     */
    public function info(string message) -> void
    {
        this->message("info", message);
    }

    /**
     * Alias of info message
     */
    public function notice(string message) -> void
    {
        this->message("info", message);
    }

    /**
     * Add warning message
     *
     * @param string message
     * @return void
     */
    public function warning(string message) -> void
    {
        this->message("warning", message);
    }

    /**
     * Alias of warning message
     */
    public function alert(string message) -> void
    {
        this->message("warning", message);
    }

    /**
     * Add danger message
     *
     * @param string message
     * @return void
     */
    public function danger(string message) -> void
    {
        this->message("danger", message);
    }

    /**
     * Alias of danger message
     */
    public function error(string message) -> void
    {
        this->message("danger", message);
    }

}