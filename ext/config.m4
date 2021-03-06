PHP_ARG_ENABLE(ice, whether to enable ice, [ --enable-ice   Enable Ice])

if test "$PHP_ICE" = "yes"; then

	

	if ! test "x" = "x"; then
		PHP_EVAL_LIBLINE(, ICE_SHARED_LIBADD)
	fi

	AC_DEFINE(HAVE_ICE, 1, [Whether you have Ice])
	ice_sources="ice.c kernel/main.c kernel/memory.c kernel/exception.c kernel/hash.c kernel/debug.c kernel/backtrace.c kernel/object.c kernel/array.c kernel/extended/array.c kernel/string.c kernel/fcall.c kernel/require.c kernel/file.c kernel/operators.c kernel/concat.c kernel/variables.c kernel/filter.c kernel/iterator.c kernel/exit.c ice/arr.zep.c
	ice/auth.zep.c
	ice/auth/driver.zep.c
	ice/auth/driver/driverinterface.zep.c
	ice/auth/driver/file.zep.c
	ice/auth/driver/model.zep.c
	ice/auth/driver/model/roles.zep.c
	ice/auth/driver/model/roles/users.zep.c
	ice/auth/driver/model/users.zep.c
	ice/auth/driver/model/users/tokens.zep.c
	ice/cli/console.zep.c
	ice/cli/dispatcher.zep.c
	ice/cli/router.zep.c
	ice/cli/task.zep.c
	ice/config.zep.c
	ice/config/ini.zep.c
	ice/cookies.zep.c
	ice/crypt.zep.c
	ice/db.zep.c
	ice/db/dbinterface.zep.c
	ice/db/driver/mongo.zep.c
	ice/db/driver/pdo.zep.c
	ice/di.zep.c
	ice/di/access.zep.c
	ice/di/diinterface.zep.c
	ice/dispatcher.zep.c
	ice/dump.zep.c
	ice/exception.zep.c
	ice/filter.zep.c
	ice/flash.zep.c
	ice/http/request.zep.c
	ice/http/request/requestinterface.zep.c
	ice/http/response.zep.c
	ice/http/response/headers.zep.c
	ice/http/response/headersinterface.zep.c
	ice/http/response/responseinterface.zep.c
	ice/i18n.zep.c
	ice/loader.zep.c
	ice/log.zep.c
	ice/log/driver.zep.c
	ice/log/driver/file.zep.c
	ice/log/loggerinterface.zep.c
	ice/mvc/app.zep.c
	ice/mvc/controller.zep.c
	ice/mvc/dispatcher.zep.c
	ice/mvc/model.zep.c
	ice/mvc/moduleinterface.zep.c
	ice/mvc/route.zep.c
	ice/mvc/route/collector.zep.c
	ice/mvc/route/datagenerator/datageneratorinterface.zep.c
	ice/mvc/route/datagenerator/groupcount.zep.c
	ice/mvc/route/datagenerator/regex.zep.c
	ice/mvc/route/dispatcher/dispatcherinterface.zep.c
	ice/mvc/route/dispatcher/groupcount.zep.c
	ice/mvc/route/parser/parserinterface.zep.c
	ice/mvc/route/parser/std.zep.c
	ice/mvc/router.zep.c
	ice/mvc/url.zep.c
	ice/mvc/view.zep.c
	ice/mvc/view/engine.zep.c
	ice/mvc/view/engine/engineinterface.zep.c
	ice/mvc/view/engine/php.zep.c
	ice/mvc/view/engine/sleet.zep.c
	ice/mvc/view/engine/sleet/compiler.zep.c
	ice/mvc/view/engine/sleet/parser.zep.c
	ice/mvc/view/viewinterface.zep.c
	ice/session.zep.c
	ice/tag.zep.c
	ice/text.zep.c
	ice/validation.zep.c
	ice/validation/validator.zep.c
	ice/validation/validator/alnum.zep.c
	ice/validation/validator/alpha.zep.c
	ice/validation/validator/between.zep.c
	ice/validation/validator/digit.zep.c
	ice/validation/validator/email.zep.c
	ice/validation/validator/file.zep.c
	ice/validation/validator/in.zep.c
	ice/validation/validator/length.zep.c
	ice/validation/validator/notin.zep.c
	ice/validation/validator/regex.zep.c
	ice/validation/validator/required.zep.c
	ice/validation/validator/same.zep.c
	ice/validation/validator/unique.zep.c
	ice/validation/validator/url.zep.c
	ice/validation/validator/with.zep.c
	ice/validation/validator/without.zep.c
	ice/version.zep.c "
	PHP_NEW_EXTENSION(ice, $ice_sources, $ext_shared,, )
	PHP_SUBST(ICE_SHARED_LIBADD)

	old_CPPFLAGS=$CPPFLAGS
	CPPFLAGS="$CPPFLAGS $INCLUDES"

	AC_CHECK_DECL(
		[HAVE_BUNDLED_PCRE],
		[
			AC_CHECK_HEADERS(
				[ext/pcre/php_pcre.h],
				[
					PHP_ADD_EXTENSION_DEP([ice], [pcre])
					AC_DEFINE([ZEPHIR_USE_PHP_PCRE], [1], [Whether PHP pcre extension is present at compile time])
				],
				,
				[[#include "main/php.h"]]
			)
		],
		,
		[[#include "php_config.h"]]
	)

	AC_CHECK_DECL(
		[HAVE_JSON],
		[
			AC_CHECK_HEADERS(
				[ext/json/php_json.h],
				[
					PHP_ADD_EXTENSION_DEP([ice], [json])
					AC_DEFINE([ZEPHIR_USE_PHP_JSON], [1], [Whether PHP json extension is present at compile time])
				],
				,
				[[#include "main/php.h"]]
			)
		],
		,
		[[#include "php_config.h"]]
	)

	CPPFLAGS=$old_CPPFLAGS

	PHP_INSTALL_HEADERS([ext/ice], [php_ICE.h])

fi
