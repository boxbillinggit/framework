
extern zend_class_entry *ice_validation_validator_url_ce;

ZEPHIR_INIT_CLASS(Ice_Validation_Validator_Url);

PHP_METHOD(Ice_Validation_Validator_Url, validate);

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_validation_validator_url_validate, 0, 0, 2)
	ZEND_ARG_OBJ_INFO(0, validation, Ice\\Validation, 0)
	ZEND_ARG_INFO(0, field)
ZEND_END_ARG_INFO()

ZEPHIR_INIT_FUNCS(ice_validation_validator_url_method_entry) {
	PHP_ME(Ice_Validation_Validator_Url, validate, arginfo_ice_validation_validator_url_validate, ZEND_ACC_PUBLIC)
  PHP_FE_END
};
