
namespace Ice\Validation\Validator;

use Ice\Validation;
use Ice\Validation\Validator;

class Alnum extends Validator
{

    public function validate(<Validation> validation, string! field)
    {
        var value, label, message, replace;

        let value = validation->getValue(field);

        if value === "" || value === null {
            return true;
        }

        if !ctype_alnum(value) {
            if this->has("label") {
                let label = this->get("label");
            } else {
                let label = validation->getLabel(field);
            }

            if this->has("message") {
                let message = this->get("message");
            } else {
                let message = validation->getDefaultMessage("alnum");
            }

            let replace = [":field": label];

            validation->addMessage(field, strtr(message, replace));
            return false;
        }

        return true;
    }
}