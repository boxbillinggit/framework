
namespace Ice\Auth\Driver;

use Ice\Auth\Driver;
use Ice\Auth\Driver\DriverInterface;
use Ice\Auth\Driver\Model\Roles;
use Ice\Auth\Driver\Model\Users;
use Ice\Auth\Driver\Model\Users\Tokens;

/**
 * Model Auth driver.
 *
 * @package     Ice/Auth
 * @category    Driver
 * @author      Ice Team
 * @copyright   (c) 2014 Ice Team
 * @license     http://iceframework.org/license
 */
class Model extends Driver implements DriverInterface
{

    /**
     * Logs a user in, based on the autologin cookie.
     *
     * @return mixed
     */
    public function autoLogin()
    {
        var token, user, userRoles, roles, role;

        let token = this->_cookies->get("auth_autologin");

        if token {
            // Find the token
            let token = Tokens::findOne(["token": token]);

            if token {
                // Get user for the token
                let user = token->{"getUser"}();

                if user && token->{"useragent"} === sha1(this->_request->getUserAgent()) {
                    // Get user's roles
                    let userRoles = user->{"getRoles"}(),
                        roles = [];

                    for role in iterator(userRoles) {
                        let role = <Roles> role->{"getRole"}(),
                            roles[] = role->get("name");
                    }

                    if in_array("login", roles) {
                        // Update the token to create a new unique token
                        token->update();

                        // Set the new token
                        this->_cookies->set("auth_autologin", token->{"token"}, token->{"expires"});

                        // Complete the login with the found data
                        this->completeLogin(user, roles);

                        // Automatic login was successful
                        return user;
                    }
                }

                // Token is invalid
                token->remove();
            }
        }

        return false;
    }
    /**
     * Complete the login for a user by setting session data and eg. incrementing the logins.
     *
     * @param object user User Model object
     * @param array roles User's roles
     * @return void
     */
    protected function completeLogin(var user, array roles = [])
    {
        if user instanceof Users {
            user->completeLogin();

            return parent::completeLogin(user->serialize(), roles);
        } else {
            return false;
        }
    }

    /**
     * Gets the currently logged in user from the session. Returns NULL if no user is currently logged in.
     *
     * @param mixed defaultValue Default value to return if the user is currently not logged in
     * @return mixed
     */
    public function getUser(var defaultValue = null)
    {
        var data, user;

        if !this->_user {
            let data = parent::getUser(defaultValue);

            if data === defaultValue {
                // User isn't currently logged in
                let this->_user = defaultValue;
            } else {
                let user = create_instance(this->getOption("users", "Ice\\Auth\\Driver\\Model\\Users"));

                if typeof user == "object" && (user instanceof Users) {
                    user->unserialize(data);
                    let this->_user = user;
                }
            }
        }

        if !this->_user {
            let this->_user = this->autoLogin();
        }

        return this->_user;
    }

    /**
     * Check if user has the role.
     *
     * @param object user User Model object
     * @param string role Role name
     * @return boolean
     */
    public function hasRole(<Users> user, string role = "login") -> boolean
    {
        return user->getRole(role) ? true : false;
    }

    /**
     * Logs a user in.
     *
     * @param mixed username
     * @param string password
     * @param boolean remember enable autologin
     * @return boolean
     */
    public function login(var username, string password, boolean remember = false)
    {
        var user, users, roles, userRoles, role, token, lifetime;

        let user = null;

        if empty password {
            return false;
        }

        if username {
            if typeof username == "object" {
                let user = username;
            } else {
                let users = this->getOption("users", "Ice\\Auth\\Driver\\Model\\Users"),
                    user = {users}::findOne(["username": username]);
            }
        }

        if typeof user == "object" && (user instanceof Users) {
            // Check if password match
            if user->get("password") == this->hash(password) {
                let userRoles = user->{"getRoles"}(),
                    roles = [];

                for role in iterator(userRoles) {
                    let role = <Roles> role->{"getRole"}(),
                        roles[] = role->get("name");
                }

                // Check if user has `login` role
                if in_array("login", roles) {
                    if remember {
                        // Create a new autologin token
                        let lifetime = this->getOption("lifetime"),
                            token = new Tokens(),
                            token->{"user_id"} = user->get("id"),
                            token->{"useragent"} = sha1(this->_request->getUserAgent()),
                            token->{"created"} = time(),
                            token->{"expires"} = time() + lifetime;

                        if token->create() === true {
                            // Set the autologin cookie
                            this->_cookies->set("auth_autologin", token->get("token"), token->get("expires"));
                        }
                    }

                    this->completeLogin(user, roles);

                    return true;
                }
            }

            return false;
        } else {
            // Username not specified or user not found
            return null;
        }
    }

    /**
     * Log a user out and remove any autologin cookies.
     *
     * @param boolean destroy Completely destroy the session
     * @param boolean logoutAll Remove all tokens for user
     * @return boolean
     */
    public function logout(boolean destroy = false, boolean logoutAll = false) -> boolean
    {
        var token, tokens, _token;

        let token = this->_cookies->get("auth_autologin");

        if token {
            // Delete the autologin cookie to prevent re-login
            this->_cookies->remove("auth_autologin");

            // Clear the autologin token from the database
            let token = Tokens::findOne(["token": token]);

            if token && logoutAll {
                // Delete all user tokens. This isn't the most elegant solution but does the job
                let tokens = Tokens::find(["user_id": token->{"user_id"}]);

                for _token in iterator(tokens) {
                    _token->remove();
                }
            } elseif token {
                token->remove();
            }
        }

        return parent::logout(destroy);
    }

}