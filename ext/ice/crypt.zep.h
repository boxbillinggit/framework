
extern zend_class_entry *ice_crypt_ce;

ZEPHIR_INIT_CLASS(Ice_Crypt);

PHP_METHOD(Ice_Crypt, __construct);
PHP_METHOD(Ice_Crypt, encrypt);
PHP_METHOD(Ice_Crypt, generateInputVector);
PHP_METHOD(Ice_Crypt, _encrypt);
PHP_METHOD(Ice_Crypt, decrypt);
PHP_METHOD(Ice_Crypt, _decrypt);
PHP_METHOD(Ice_Crypt, getJsonPayload);
PHP_METHOD(Ice_Crypt, hash);
PHP_METHOD(Ice_Crypt, addPadding);
PHP_METHOD(Ice_Crypt, stripPadding);
PHP_METHOD(Ice_Crypt, paddingIsValid);
PHP_METHOD(Ice_Crypt, invalidPayload);
PHP_METHOD(Ice_Crypt, getIvSize);
PHP_METHOD(Ice_Crypt, setKey);
PHP_METHOD(Ice_Crypt, setCipher);
PHP_METHOD(Ice_Crypt, setMode);

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt___construct, 0, 0, 1)
	ZEND_ARG_INFO(0, key)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_encrypt, 0, 0, 1)
	ZEND_ARG_INFO(0, text)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt__encrypt, 0, 0, 2)
	ZEND_ARG_INFO(0, value)
	ZEND_ARG_INFO(0, iv)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_decrypt, 0, 0, 1)
	ZEND_ARG_INFO(0, text)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt__decrypt, 0, 0, 2)
	ZEND_ARG_INFO(0, value)
	ZEND_ARG_INFO(0, iv)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_getjsonpayload, 0, 0, 1)
	ZEND_ARG_INFO(0, text)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_hash, 0, 0, 1)
	ZEND_ARG_INFO(0, value)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_addpadding, 0, 0, 1)
	ZEND_ARG_INFO(0, value)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_strippadding, 0, 0, 1)
	ZEND_ARG_INFO(0, value)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_paddingisvalid, 0, 0, 2)
	ZEND_ARG_INFO(0, pad)
	ZEND_ARG_INFO(0, value)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_invalidpayload, 0, 0, 1)
	ZEND_ARG_ARRAY_INFO(0, data, 0)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_setkey, 0, 0, 1)
	ZEND_ARG_INFO(0, key)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_setcipher, 0, 0, 1)
	ZEND_ARG_INFO(0, cipher)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO_EX(arginfo_ice_crypt_setmode, 0, 0, 1)
	ZEND_ARG_INFO(0, mode)
ZEND_END_ARG_INFO()

ZEPHIR_INIT_FUNCS(ice_crypt_method_entry) {
	PHP_ME(Ice_Crypt, __construct, arginfo_ice_crypt___construct, ZEND_ACC_PUBLIC|ZEND_ACC_CTOR)
	PHP_ME(Ice_Crypt, encrypt, arginfo_ice_crypt_encrypt, ZEND_ACC_PUBLIC)
	PHP_ME(Ice_Crypt, generateInputVector, NULL, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, _encrypt, arginfo_ice_crypt__encrypt, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, decrypt, arginfo_ice_crypt_decrypt, ZEND_ACC_PUBLIC)
	PHP_ME(Ice_Crypt, _decrypt, arginfo_ice_crypt__decrypt, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, getJsonPayload, arginfo_ice_crypt_getjsonpayload, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, hash, arginfo_ice_crypt_hash, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, addPadding, arginfo_ice_crypt_addpadding, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, stripPadding, arginfo_ice_crypt_strippadding, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, paddingIsValid, arginfo_ice_crypt_paddingisvalid, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, invalidPayload, arginfo_ice_crypt_invalidpayload, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, getIvSize, NULL, ZEND_ACC_PROTECTED)
	PHP_ME(Ice_Crypt, setKey, arginfo_ice_crypt_setkey, ZEND_ACC_PUBLIC)
	PHP_ME(Ice_Crypt, setCipher, arginfo_ice_crypt_setcipher, ZEND_ACC_PUBLIC)
	PHP_ME(Ice_Crypt, setMode, arginfo_ice_crypt_setmode, ZEND_ACC_PUBLIC)
  PHP_FE_END
};
