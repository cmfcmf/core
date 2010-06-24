<?php
/**
 * Copyright Zikula Foundation 2009 - Zikula Application Framework
 *
 * This work is contributed to the Zikula Foundation under one or more
 * Contributor Agreements and licensed to You under the following license:
 *
 * @license GNU/LGPLv2.1 (or at your option, any later version).
 * @package Util
 *
 * Please see the NOTICE file distributed with this source code for further
 * information regarding copyright and licensing.
 */

/**
 * DataUtil is the class used to manage datas and variables.
 */
class DataUtil
{
    /**
     * Clean a variable, remove slashes. This method is recursive array safe.
     *
     * @param string $var The variable to clean.
     *
     * @return The formatted variable
     */
    public static function cleanVar($var)
    {
        if (!get_magic_quotes_gpc()) {
            return $var;
        }

        if (is_array($var)) {
            foreach ($var as $k => $v) {
                $var[$k] = self::cleanVar($v);
            }
        } else {
            System::stripslashes($var);
        }

        return $var;
    }

    /**
     * Decode a character a previously encoded character.
     *
     * @param string $value The value we wish to encode.
     *
     * @return The decoded value.
     */
    public static function decode($value)
    {
        return base64_decode($value);
    }

    /**
     * Take a name-value-pair string and convert it to an associative array, optionally urldecoding the response.
     *
     * @param string  $nvpstr    Name-value-pair String.
     * @param string  $separator Separator used in the NVP string.
     * @param boolean $urldecode Whether to urldecode the NVP fields.
     *
     * @return array Assoc is associative array.
     */
    public static function decodeNVP ($nvpstr, $separator='&', $urldecode=true)
    {
        $assoc = array();
        $items = explode ($separator, $nvpstr);
        foreach ($items as $item) {
            $fields = explode ('=', $item);
            $key    = $urldecode ? urldecode($fields[0]) : $fields[0];
            $value  = $urldecode ? urldecode($fields[1]) : $fields[1];
            $assoc[$key] = $value;
        }

        return $assoc;
    }

    /**
     * Decrypt the given value using the mcrypt library function.
     * 
     * If the mcrypt functions do not exist, we fallback to the RC4 implementation which is shipped with Zikula.
     *
     * @param string  $value   The value we wish to decrypt.
     * @param string  $key     The encryption key to use (optional) (default=null).
     * @param string  $alg     The encryption algirthm to use (only used with mcrypt functions) (optional) (default=null, signifies MCRYPT_RIJNDAEL_128).
     * @param boolean $encoded Whether or not the value is base64 encoded (optional) (default=true).
     *
     * @return string The decrypted value.
     */
    public static function decrypt($value, $key = null, $alg = null, $encoded = true)
    {
        $res = false;
        $key = ($key ? $key : 'ZikulaEncryptionKey');
        $val = ($encoded ? self::decode($value) : $value);

        if (function_exists('mcrypt_create_iv') && function_exists('mcrypt_decrypt')) {
            $alg = ($alg ? $alg : MCRYPT_RIJNDAEL_128);
            $iv = mcrypt_create_iv(mcrypt_get_iv_size($alg, MCRYPT_MODE_ECB), crc32($key));
            $res = mcrypt_decrypt($alg, $key, $val, MCRYPT_MODE_CBC);
        } else {
            require_once 'lib/vendor/encryption/rc4crypt.class.php';
            $res = rc4crypt::decrypt($key, $val);
        }

        return $res;
    }

    /**
     * Encode a character sting such that it's 8-bit clean. It maps to base64_encode().
     *
     * @param string $value The value we wish to encode.
     *
     * @return string The encoded value.
     */
    public static function encode($value)
    {
        return base64_encode($value);
    }

    /**
     * Take a key and value and encode them into an NVP-string entity.
     *
     * @param string  $key          The key to encode.
     * @param string  $value        The value to encode.
     * @param string  $separator    The Separator to use in the NVP string.
     * @param boolean $includeEmpty Whether to also include empty values.
     *
     * @return string String-encoded NVP or an empty string.
     */
    public static function encodeNVP ($key, $value, $separator='&', $includeEmpty=true)
    {
        if (!$key) {
            return LogUtil::registerError ('Invalid NVP key received');
        }

        if ($includeEmpty || ($value != null && strlen($value) > 1)) {
            return ("&".urlencode($key) ."=" .urlencode($value));
        }

        return '';
    }

    /**
     * Take an array and encode it as a NVP string.
     *
     * @param string  $nvps         The array of name-value paris.
     * @param string  $separator    The Separator to use in the NVP string.
     * @param boolean $includeEmpty Whether to also include empty values.
     *
     * @return string String-encoded NVP or an empty string.
     */
    public static function encodeNVPArray ($nvps, $separator='&', $includeEmpty=true)
    {
        if (!is_array($nvps)) {
            return LogUtil::registerError ('NVPS array is not an array');
        }

        $str = '';
        foreach ($nvps as $k => $v) {
            $str .= self::encodeNVP ($k, $v, $separator, $includeEmpty);
        }

        return $str;
    }

    /**
     * Encrypt the given value using the mcrypt library function.
     * 
     * If the mcrypt functions do not exist, we fallback to the RC4 implementation which is shipped with Zikula.
     *
     * @param string  $value   The value we wish to decrypt.
     * @param string  $key     The encryption key to use (optional) (default=null).
     * @param string  $alg     The encryption algirthm to use (only used with mcrypt functions) (optional) (default=null, signifies MCRYPT_RIJNDAEL_128).
     * @param boolean $encoded Whether or not the value is base64 encoded (optional) (default=true).
     *
     * @return string The encrypted value.
     */
    public static function encrypt($value, $key = null, $alg = null, $encoded = true)
    {
        $res = false;
        $key = ($key ? $key : 'ZikulaEncryptionKey');

        if (function_exists('mcrypt_create_iv') && function_exists('mcrypt_decrypt')) {
            $alg = ($alg ? $alg : MCRYPT_RIJNDAEL_128);
            $iv = mcrypt_create_iv(mcrypt_get_iv_size($alg, MCRYPT_MODE_ECB), crc32($key));
            $res = mcrypt_encrypt($alg, $key, $value, MCRYPT_MODE_CBC);
        } else {
            require_once 'lib/vendor/encryption/rc4crypt.class.php';
            $res = rc4crypt::encrypt($key, $value);
        }

        return ($encoded && $res ? self::encode($res) : $res);
    }

    /**
     * Format a variable for display. This method is recursive array safe.
     *
     * @param string $var The variable to format.
     *
     * @return string The formatted variable.
     */
    public static function formatForDisplay($var)
    {
        // This search and replace finds the text 'x@y' and replaces
        // it with HTML entities, this provides protection against
        // email harvesters
        static $search = array('/(.)@(.)/se');

        static $replace = array('"&#" .
                                sprintf("%03d", ord("\\1")) .
                                ";&#064;&#" .
                                sprintf("%03d", ord("\\2")) . ";";');

        if (is_array($var)) {
            foreach ($var as $k => $v) {
                $var[$k] = self::formatForDisplay($v);
            }
        } else {
            $var = htmlspecialchars((string)$var);
            $var = preg_replace($search, $replace, $var);
        }

        return $var;
    }

    /**
     * Format a variable for HTML display. This method is recursive array safe.
     *
     * @param string $var The variable to format.
     *
     * @return string The formatted variable.
     */
    public static function formatForDisplayHTML($var)
    {
        // This search and replace finds the text 'x@y' and replaces
        // it with HTML entities, this provides protection against
        // email harvesters
        //
        // Note that the use of \024 and \022 are needed to ensure that
        // this does not break HTML tags that might be around either
        // the username or the domain name
        static $search = array(
            '/([^\024])@([^\022])/se');

        static $replace = array('"&#" .
                                sprintf("%03d", ord("\\1")) .
                                ";&#064;&#" .
                                sprintf("%03d", ord("\\2")) . ";";');

        static $allowedtags = null;
        static $outputfilter;

        if (!isset($allowedtags)) {
            $allowedHTML = array();
            $allowableHTML = System::getVar('AllowableHTML');
            if (is_array($allowableHTML)) {
                foreach ($allowableHTML as $k => $v) {
                    if ($k == '!--') {
                        if ($v != 0) {
                            $allowedHTML[] = "$k.*?--";
                        }
                    } else {
                        switch ($v) {
                            case 0:
                                break;
                            case 1:
                                $allowedHTML[] = "/?$k\s*/?";
                                break;
                            case 2:
                                // intelligent regex to deal with > in parameters, bug #1782 credits to jln
                                $allowedHTML[] = "/?\s*$k" . "(\s+[\w:]+\s*=\s*(\"[^\"]*\"|'[^']*'))*" . '\s*/?';
                                break;
                        }
                    }
                }
            }

            if (count($allowedHTML) > 0) {
                // 2nd part of bugfix #1782
                $allowedtags = '~<\s*(' . join('|', $allowedHTML) . ')\s*>~is';
            } else {
                $allowedtags = '';
            }
        }

        if (!isset($outputfilter)) {
            if (ModUtil::available('SecurityCenter') && !System::isInstalling()) {
                $outputfilter = System::getVar('outputfilter');
            } else {
                $outputfilter = 0;
            }
        }

        if (is_array($var)) {
            foreach ($var as $k => $v) {
                $var[$k] = self::formatForDisplayHTML($v);
            }
        } else {
            // Run additional filters
            if ($outputfilter > 0) {
                $var = ModUtil::apiFunc('SecurityCenter', 'user', 'secureoutput', array('var' => $var, 'filter' => $outputfilter));
            }

            // Preparse var to mark the HTML that we want
            if (!empty($allowedtags)) {
                $var = preg_replace($allowedtags, "\022\\1\024", $var);
            }

            // Encode email addresses
            $var = preg_replace($search, $replace, $var);

            // Fix html entities
            $var = htmlspecialchars($var);

            // Fix the HTML that we want
            $var = preg_replace_callback('#\022([^\024]*)\024#', create_function('$m', 'return DataUtil::formatForDisplayHTML_callback($m);'), $var);

            // Fix entities if required
            if (System::getVar('htmlentities')) {
                $var = preg_replace('/&amp;([a-z#0-9]+);/i', "&\\1;", $var);
            }
        }

        return $var;
    }

    /**
     * Function formatForDisplayHTML callback.
     *
     * @param array $m String to format.
     *
     * @access private
     *
     * @return string|void on empty
     */
    public static function formatForDisplayHTML_callback($m)
    {
        if (!$m) {
            return;
        }
        return '<' . strtr($m[1], array('&gt;' => '>', '&lt;' => '<', '&quot;' => '"'/*, '&amp;' => '&'*/)) . '>';
    }


    /**
     * Format a variable for DB-storage. This method is recursive array safe.
     *
     * @param string $var The variable to format.
     *
     * @return The formatted variable.
     */
    public static function formatForStore($var)
    {
        if (is_array($var)) {
            foreach ($var as $k => $v) {
                $var[$k] = self::formatForStore($v);
            }
        } else {
            $dbType = DBConnectionStack::getConnectionDBType();
            if ($dbType == 'mssql' || $dbType == 'oci8' || $dbType == 'oracle') {
                $var = str_replace("'", "''", $var);
            } else
                $var = addslashes($var);
        }

        return $var;
    }

    /**
     * Format a variable for operating-system usage. This method is recursive array safe.
     *
     * @param string  $var      The variable to format.
     * @param boolean $absolute Allow absolute paths (default=false) (optional).
     *
     * @return string The formatted variable.
     */
    public static function formatForOS($var, $absolute = false)
    {
        if (is_array($var)) {
            foreach ($var as $k => $v) {
                $var[$k] = self::formatForOS($v);
            }
        } else {
            static $cached;
            if ($cached == null) {
                $cached = array();
            }

            if (isset($cached[$var])) {
                return $cached[$var];
            }
            $orgVar = $var;

            $clean_array = array();

            //if we're supporting absolute paths and the first charater is a slash and , then
            //an absolute path is passed
            $absolutepathused = ($absolute && substr($var, 0, 1) == '/');

            // Split the path at possible path delimiters.
            // Setting PREG_SPLIT_NOEMPTY eliminates double delimiters on the fly.
            $dirty_array = preg_split('#[:/\\\\]#', $var, -1, PREG_SPLIT_NO_EMPTY);

            // now walk the path and do the relevant things
            foreach ($dirty_array as $current) {
                if ($current == '.') {
                    // current path element is a dot, so we don't do anything
                } elseif ($current == '..') {
                    // current path element is .., so we remove the last path in case of relative paths
                    if (!$absolutepathused) {
                        array_pop($clean_array);
                    }
                } else {
                    // current path element is valid, so we add it to the path
                    $clean_array[] = $current;
                }
            }

            // Build the path
            // Rather than use DIRECTORY_SEPARATOR, normalise the $var because we cannot be sure what we got
            // and since we cannot use realpath() because this will turn paths into absolute - for legacy reasons 
            // recipient's of the call my not be expecting absolute values (drak).
            $var = str_replace('\\', '/', $var);
            $var = implode('/', $clean_array);

            // If an absolute path was passed to the function, we need to make it absolute again
            if ($absolutepathused) {
                $var = '/' . $var;
            }

            // Prepare var
            // needed for magic_quotes_runtime = 0
            $var = addslashes($var);

            $cached[$orgVar] = $var;
        }

        return $var;
    }

    /**
     * Format a variable for URL usage.
     *
     * @param string $var The variable to format.
     *
     * @return string The formatted variable for URL usage.
     */
    public static function formatForURL($var)
    {
        return self::formatPermalink($var);
    }

    /**
     * Format a variable for permalink usage.
     *
     * @param string $var The variable to format.
     *
     * @return string The formatted variable for permalink usage.
     */
    public static function formatPermalink($var)
    {
        static $permalinksseparator;
        if (!isset($permalinksseparator)) {
            $permalinksseparator = System::getVar('shorturlsseparator');
        }

        $var = strip_tags($var);
        $var = preg_replace("/&[#a-zA-Z0-9]+;|\?/", '', $var); // remove &....; and ?
        $var = strtr($var, ' ', $permalinksseparator); //words separation

        $permasearch = explode(',', System::getVar('permasearch'));
        $permareplace = explode(',', System::getVar('permareplace'));

        // replace all chars $permasearch with the one in $permareplace
        foreach ($permasearch as $key => $value) {
             $var = mb_ereg_replace("[$value]", $permareplace[$key], $var);
        }

        // final clean
        $var = mb_ereg_replace("[^a-z0-9_{$permalinksseparator}]", '', $var, "imsr");
        $var = trim($var, $permalinksseparator);

        return $var;
    }

    /**
     * Censor variable contents. This method is recursive array safe.
     *
     * @param string $var The variable to censor.
     *
     * @return string The censored variable.
     */
    public static function censor($var)
    {
        static $doCensor;
        if (!isset($doCensor)) {
            $doCensor = ModUtil::available('MultiHook');
        }

        if (!$doCensor) {
            return $var;
        }

        if (is_array($var)) {
            foreach ($var as $k => $v) {
                $var[$k] = self::censor($v);
            }
        } else {
            $var = ModUtil::apiFunc('MultiHook', 'user', 'censor', array('word' => $var)); // preg_replace($search, $replace, $var);
        }

        return $var;
    }

    /**
     * Hash function.
     * 
     * Perform SHA1 or SHA256 hashing on a string using native PHP functions if available and if not uses own classes.
     *
     * @param string $string String to be hashed.
     * @param string $type   String element of hash_algos() (default=sha1).
     *
     * @deprecated
     * @see    hash()
     * @return string hex hash
     */
    public static function hash($string, $type = 'sha1')
    {
        LogUtil::log(__f('Warning! Function %1$s is deprecated. Please use %2$s instead.', array('DataUtil::hash()', 'hash()')), 'STRICT');
        return hash(strtolower($type), $string);
    }

    /**
     * Get boolean ini value.
     *
     * This method converts the several possible return values from
     * allegedly "boolean" ini settings to proper booleans
     * Properly converted input values are: 'off', 'on', 'false', 'true', '0', '1'
     * If the ini_value doesn't match any of those, the value is returned as-is.
     *
     * @param string $ini_key The ini_key you need the value of.
     *
     * @return boolean|mixed
     */
    public static function getBooleanIniValue($ini_key)
    {
        $ini_val = ini_get($ini_key);
        switch (strtolower($ini_val)) {
            case 'off':
                return false;
                break;
            case 'on':
                return true;
                break;
            case 'false':
                return false;
                break;
            case 'true':
                return true;
                break;
            case '0':
                return false;
                break;
            case '1':
                return true;
                break;
            default:
                return $ini_val;
        }
    }

    /**
     * Check for serialization.
     *
     * @param string  $string  String to check.
     * @param boolean $checkmb True or false.
     *
     * @return boolean
     */
    public static function is_serialized($string, $checkmb = true)
    {
        if ($string == 'b:0;') {
            return true;
        }

        if ($checkmb) {
            return (self::mb_unserialize($string) === false ? false : true);
        } else {
            return (@unserialize($string) === false ? false : true);
        }
    }

    /**
     * Unserialize function.
     *
     * Will unserialise serialised data that was previously encoded as iso and converted to utf8
     * This generally not required.
     *
     * @param string $string Serialised data.
     *
     * @return mixed
     */
    public static function mb_unserialize($string)
    {
        // we use a callback here to avoid problems with certain characters (single quotes and dollarsign) - drak
        return @unserialize(preg_replace_callback('#s:(\d+):"(.*?)";#s', create_function('$m', 'return self::_mb_unserialize_callback($m);'), $string));
    }

    /**
     * Private callback function for mb_unserialize().
     *
     * Note this is still a private method although we have to use public visibility.
     *
     * @param string $match String to use.
     *
     * @access private
     * @return string
     */
    public static function _mb_unserialize_callback($match)
    {
        $length = strlen($match[2]);
        return "s:$length:\"$match[2]\";";
    }

    /**
     * Convert to UTF8 function.
     *
     * Converts a string or an array (recursivly) to utf-8.
     *
     * @param mixed $input String or array to convert to utf-8.
     *
     * @return mixed Converted string or array.
     */
    public static function convertToUTF8($input = '')
    {
        if (is_array($input)) {
            $return = array();
            foreach ($input as $key => $value) {
                $return[$key] = self::convertToUTF8($value);
            }
            return $return;
        } elseif (is_string($input)) {
            if (function_exists('mb_convert_encoding')) {
                return mb_convert_encoding($input, 'UTF-8', strtoupper(ZLanguage::getEncoding()));
            } else {
                return utf8_encode($input);
            }
        } else {
            return $input;
        }
    }

    /**
     * Convert a string from utf-8.
     *
     * @param mixed $input String or array to convert from utf-8.
     *
     * @return mixed Converted string.
     */
    public static function convertFromUTF8($input = '')
    {
        if (is_array($input)) {
            $return = array();
            foreach ($input as $key => $value) {
                $return[$key] = self::convertFromUTF8($value);
            }
            return $return;
        } elseif (is_string($input)) {
            if (function_exists('mb_convert_encoding')) {
                return mb_convert_encoding($input, strtoupper(ZLanguage::getEncoding()), 'UTF-8');
            } else {
                return utf8_decode($input);
            }
        } else {
            return $input;
        }
    }


    /**
     * Take user input and transform to a number according to locale.
     *
     * @param mixed $number Number to transform.
     *
     * @return mixed
     */
    public static function transformNumberInternal($number)
    {
        $i18n = ZI18n::getInstance();
        return $i18n->transformNumberInternal($number);
    }

    /**
     * Transform a currency to an internal number according to locale.
     *
     * @param mixed $number Number to transform.
     *
     * @return mixed
     */
    public static function transformCurrencyInternal($number)
    {
        $i18n = ZI18n::getInstance();
        return $i18n->transformCurrencyInternal($number);
    }

    /**
     * Format a number to currency according to locale.
     *
     * @param mixed $number Number to format.
     *
     * @return unknown_type
     */
    public static function formatCurrency($number)
    {
        $i18n = ZI18n::getInstance();
        return $i18n->transformCurrencyDisplay($number);
    }

    /**
     * Format a number for display in locale.
     *
     * @param mixed $number         Number to format.
     * @param mixed $decimal_points Desc : null=default locale, false=precision, int=precision.
     *
     * @return mixed
     */
    public static function formatNumber($number, $decimal_points=null)
    {
        $i18n = ZI18n::getInstance();
        return $i18n->transformNumberDisplay($number, $decimal_points);
    }

    /**
     * Native ini file parser because PHP can't handle such a simple function cross platform.
     *
     * Taken from http://mach13.com/loose-and-multiline-parse_ini_file-function-in-php
     *
     * @param file $iIniFile File to parse.
     *
     * @return array Array with the content of ini file.
     */
    public static function parseIniFile($iIniFile)
    {
        $aResult = array();
        $aMatches = array();

        $a = &$aResult;
        $s = '\s*([[:alnum:]_\- \*]+?)\s*';

        preg_match_all('#^\s*((\['.$s.'\])|(("?)'.$s.'\\5\s*=\s*("?)(.*?)\\7))\s*(;[^\n]*?)?$#ms', file_get_contents($iIniFile), $aMatches, PREG_SET_ORDER);

        foreach ($aMatches as $aMatch) {
            if (empty($aMatch[2])) {
                $a[$aMatch[6]] = $aMatch[8];
            } else {
                $a = &$aResult[$aMatch[3]];
            }
        }
        return $aResult;
    }
}

