
namespace Ice\Auth\Driver\Model\Roles;

use Ice\Di;
use Ice\Mvc\Model;
use Ice\Di\DiInterface;

/**
 * Model user's Roles.
 *
 * @package     Ice/Auth
 * @category    Model
 * @author      Ice Team
 * @copyright   (c) 2014 Ice Team
 * @license     http://iceframework.org/license
 */
class Users extends Model
{

    protected _from = "roles_users";

    /**
     * Initialize roles-users relations
     *
     * @return void
     */
    public function initialize()
    {
        var auth;

        let auth = Di::$fetch()->getAuth();

        this->belongsTo("user_id", auth->getOption("users", "Ice\\Auth\\Driver\\Model\\Users"), "id", [
            "alias": "User"
        ]);

        this->belongsTo("role_id", "Ice\\Auth\\Driver\\Model\\Roles", "id", [
            "alias": "Role"
        ]);
    }

}