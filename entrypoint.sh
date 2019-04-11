#!/bin/bash
set -e

# #PHP
PHP_ERROR_REPORTING=${PHP_ERROR_REPORTING:-"E_ALL & ~E_DEPRECATED & ~E_NOTICE & ~E_WARNING"}
sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/apache2/php.ini
sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/cli/php.ini

sed -ri "s/^error_reporting\s*=.*$//g" /etc/php5/apache2/php.ini
sed -ri "s/^error_reporting\s*=.*$//g" /etc/php5/cli/php.ini

sed -ri 's/session.gc_maxlifetime = 1440/session.gc_maxlifetime = 3600/g' /etc/php5/apache2/php.ini
sed -ri 's/session.gc_maxlifetime = 1440/session.gc_maxlifetime = 3600/g' /etc/php5/cli/php.ini

sed -ri 's/register_argc_argv = Off/register_argc_argv = On/g' /etc/php5/apache2/php.ini
sed -ri 's/register_argc_argv = Off/register_argc_argv = On/g' /etc/php5/cli/php.ini

sed -ri 's/register_long_arrays = Off/register_long_arrays = On/g' /etc/php5/apache2/php.ini
sed -ri 's/register_long_arrays = Off/register_long_arrays = On/g' /etc/php5/cli/php.ini

sed -ri 's/allow_call_time_pass_reference = Off/allow_call_time_pass_reference = On/g' /etc/php5/apache2/php.ini
sed -ri 's/allow_call_time_pass_reference = Off/allow_call_time_pass_reference = On/g' /etc/php5/cli/php.ini

sed -ri 's/max_execution_time = 30/max_execution_time = 1200/g' /etc/php5/apache2/php.ini
sed -ri 's/max_execution_time = 30/max_execution_time = 1200/g' /etc/php5/cli/php.ini

sed -ri 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php5/apache2/php.ini
sed -ri 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php5/cli/php.ini

sed -ri 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php5/apache2/php.ini
sed -ri 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php5/cli/php.ini

echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php5/apache2/php.ini
echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php5/cli/php.ini

# #APACHE2
sed -ri 's/LogLevel warn/LogLevel error/g' /etc/apache2/apache2.conf
sed -ri 's/Timeout 60/Timeout 300/g' /etc/apache2/apache2.conf
sed -ri 's/KeepAlive Off/KeepAlive On/g' /etc/apache2/apache2.conf

# sed -ri 's/ServerTokens OS/ServerTokens Prod/g' /etc/apache2/apache2.conf
# sed -ri 's/AddDefaultCharset UTF-8/#AddDefaultCharset UTF-8/g' /etc/apache2/apache2.conf
# sed -ri 's/#ExtendedStatus On/ExtendedStatus On/g' /etc/apache2/apache2.conf
# sed -ri 's/#ServerName www.example.com:80/ServerName 127.0.0.1 /g' /etc/apache2/apache2.conf
# sed -ri 's/ServerSignature On/ServerSignature Off/g' /etc/apache2/apache2.conf

touch /etc/apache2/conf.d/custom.conf

echo "ServerTokens Prod" >> /etc/apache2/conf.d/custom.conf
echo "AddDefaultCharset UTF-8" >> /etc/apache2/conf.d/custom.conf
echo "ExtendedStatus On" >> /etc/apache2/conf.d/custom.conf
echo "ServerName 127.0.0.1" >> /etc/apache2/conf.d/custom.conf
echo "ServerSignature Off" >> /etc/apache2/conf.d/custom.conf

#SERVICE APACHE2 EXEC
source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND