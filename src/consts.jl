const mysql_lib = isfile("/usr/lib/libmysqlclient.so")?"/usr/lib/libmysqlclient.so":"/usr/local/mysql/lib/libmysqlclient.dylib"
const STMT_ATTR_UPDATE_MAX_LENGTH = 0
const CR_UNKNOWN_ERROR = 2000 #Message: Unknown MySQL error
const CR_SOCKET_CREATE_ERROR = 2001 #Message: Can't create UNIX socket (%d)
const CR_CONNECTION_ERROR = 2002 #Message: Can't connect to local MySQL server through socket '%s'
const CR_CONN_HOST_ERROR = 2003 #Message: Can't connect to MySQL server on '%s' (%d)
const CR_IPSOCK_ERROR = 2004 #Message: Can't create TCP/IP socket (%d)
const CR_UNKNOWN_HOST = 2005 #Message: Unknown MySQL server host '%s' (%d)
const CR_SERVER_GONE_ERROR = 2006 #Message: MySQL server has gone away
const CR_VERSION_ERROR = 2007 #Message: Protocol mismatch; server version = %d, client version =%d

const CR_OUT_OF_MEMORY = 2008 #Message: MySQL client ran out of memory
const CR_WRONG_HOST_INFO = 2009 #Message: Wrong host info
const CR_LOCALHOST_CONNECTION = 2010 #Message: Localhost via UNIX socket
const CR_TCP_CONNECTION = 2011 #Message: %s via TCP/IP
const CR_SERVER_HANDSHAKE_ERR = 2012 #Message: Error in server handshake
const CR_SERVER_LOST = 2013 #Message: Lost connection to MySQL server during query
const CR_COMMANDS_OUT_OF_SYNC = 2014 #Message: Commands out of sync; you can't run this command now
const CR_NAMEDPIPE_CONNECTION = 2015 #Message: Named pipe: %s
const CR_NAMEDPIPEWAIT_ERROR = 2016 #Message: Can't wait for named pipe to host: %s pipe: %s (%lu)
const CR_NAMEDPIPEOPEN_ERROR = 2017 #Message: Can't open named pipe to host: %s pipe: %s (%lu)
const CR_NAMEDPIPESETSTATE_ERROR = 2018 #Message: Can't set state of named pipe to host: %s pipe: %s (%lu)
const CR_CANT_READ_CHARSET = 2019 #Message: Can't initialize character set %s (path: %s)
const CR_NET_PACKET_TOO_LARGE = 2020 #Message: Got packet bigger than 'max_allowed_packet' bytes
const CR_EMBEDDED_CONNECTION = 2021 #Message: Embedded server
const CR_PROBE_SLAVE_STATUS = 2022 #Message: Error on SHOW SLAVE STATUS:
const CR_PROBE_SLAVE_HOSTS = 2023 #Message: Error on SHOW SLAVE HOSTS:
const CR_PROBE_SLAVE_CONNECT = 2024 #Message: Error connecting to slave:
const CR_PROBE_MASTER_CONNECT = 2025 #Message: Error connecting to master:
const CR_SSL_CONNECTION_ERROR = 2026 #Message: SSL connection error
const CR_MALFORMED_PACKET = 2027 #Message: Malformed packet
const CR_WRONG_LICENSE = 2028 #Message: This client library is licensed only for use with MySQL servers having '%s' license
const CR_NULL_POINTER = 2029 #Message: Invalid use of null pointer
const CR_NO_PREPARE_STMT = 2030 #Message: Statement not prepared
const CR_PARAMS_NOT_BOUND = 2031 #Message: No data supplied for parameters in prepared statement
const CR_DATA_TRUNCATED = 2032 #Message: Data truncated
const CR_NO_PARAMETERS_EXISTS = 2033 #Message: No parameters exist in the statement
const CR_INVALID_PARAMETER_NO = 2034 #Message: Invalid parameter number
const CR_INVALID_BUFFER_USE = 2035 #Message: Can't send long data for non-string/non-binary data types (parameter: %d)
const CR_UNSUPPORTED_PARAM_TYPE = 2036 #Message: Using unsupported buffer type: %d (parameter: %d)
const CR_SHARED_MEMORY_CONNECTION = 2037 #Message: Shared memory: %s
const CR_SHARED_MEMORY_CONNECT_REQUEST_ERROR = 2038 #Message: Can't open shared memory; client could not create request event (%lu)
const CR_SHARED_MEMORY_CONNECT_ANSWER_ERROR = 2039 #Message: Can't open shared memory; no answer event received from server (%lu)
const CR_SHARED_MEMORY_CONNECT_FILE_MAP_ERROR = 2040 #Message: Can't open shared memory; server could not allocate file mapping (%lu)
const CR_SHARED_MEMORY_CONNECT_MAP_ERROR = 2041 #Message: Can't open shared memory; server could not get pointer to file mapping (%lu)
const CR_SHARED_MEMORY_FILE_MAP_ERROR = 2042 #Message: Can't open shared memory; client could not allocate file mapping (%lu)
const CR_SHARED_MEMORY_MAP_ERROR = 2043 #Message: Can't open shared memory; client could not get pointer to file mapping (%lu)
const CR_SHARED_MEMORY_EVENT_ERROR = 2044 #Message: Can't open shared memory; client could not create %sj event (%lu)
const CR_SHARED_MEMORY_CONNECT_ABANDONED_ERROR = 2045 #Message: Can't open shared memory; no answer from server (%lu)
const CR_SHARED_MEMORY_CONNECT_SET_ERROR = 2046 #Message: Can't open shared memory; cannot send request event to server (%lu)
const CR_CONN_UNKNOW_PROTOCOL = 2047 #Message: Wrong or unknown protocol
const CR_INVALID_CONN_HANDLE = 2048 #Message: Invalid connection handle
const CR_SECURE_AUTH = 2049 #Message: Connection using old (pre-4.1.1) authentication protocol refused (client option 'secure_auth' enabled)
const CR_FETCH_CANCELED = 2050 #Message: Row retrieval was canceled by mysql_stmt_close() call
const CR_NO_DATA = 2051 #Message: Attempt to read column without prior row fetch
const CR_NO_STMT_METADATA = 2052 #Message: Prepared statement contains no metadata
const CR_NO_RESULT_SET = 2053 #Message: Attempt to read a row while there is no result set associated with the statement
const CR_NOT_IMPLEMENTED = 2054 #Message: This feature is not implemented yet
const CR_SERVER_LOST_EXTENDED = 2055 # Message: Lost connection to MySQL server at '%s', system error: %d


Messages = {
    2000=>"Message: Unknown MySQL error",
    2001=>"Message: Can't create UNIX socket (%d)",
    2002=>"Message: Can't connect to local MySQL server through socket '%s'
      (%d)",
    2003=>"Message: Can't connect to MySQL server on '%s' (%d)",
    2004=>"Message: Can't create TCP/IP socket (%d)",
    2005=>"Message: Unknown MySQL server host '%s' (%d)",
    2006=>"Message: MySQL server has gone away",
    2007=>"Message: Protocol mismatch; server version = %d, client version =
      %d",
    2008=>"Message: MySQL client ran out of memory",
    2009=>"Message: Wrong host info",
    2010=>"Message: Localhost via UNIX socket",
    2011=>"Message: %s via TCP/IP",
    2012=>"Message: Error in server handshake",
    2013=>"Message: Lost connection to MySQL server during query",
    2014=>"Message: Commands out of sync; you can't run this command now",
    2015=>"Message: Named pipe: %s",
    2016=>"Message: Can't wait for named pipe to host: %s pipe: %s (%lu)",
    2017=>"Message: Can't open named pipe to host: %s pipe: %s (%lu)",
    2018=>"Message: Can't set state of named pipe to host: %s pipe: %s (%lu)",
    2019=>"Message: Can't initialize character set %s (path: %s)",
    2020=>"Message: Got packet bigger than 'max_allowed_packet' bytes",
    2021=>"Message: Embedded server",
    2022=>"Message: Error on SHOW SLAVE STATUS:",
    2023=>"Message: Error on SHOW SLAVE HOSTS:",
    2024=>"Message: Error connecting to slave:",
    2025=>"Message: Error connecting to master:",
    2026=>"Message: SSL connection error",
    2027=>"Message: Malformed packet",
    2028=>"Message: This client library is licensed only for use with MySQL
      servers having '%s' license",
    2029=>"Message: Invalid use of null pointer",
    2030=>"Message: Statement not prepared",
    2031=>"Message: No data supplied for parameters in prepared statement",
    2032=>"Message: Data truncated",
    2033=>"Message: No parameters exist in the statement",
    2034=>"Message: Invalid parameter number",
    2035=>"Message: Can't send long data for non-string/non-binary data types
      (parameter: %d)",
    2036=>"Message: Using unsupported buffer type: %d (parameter: %d)",
    2037=>"Message: Shared memory: %s",
    2038=>"Message: Can't open shared memory; client could not create request
      event (%lu)",
    2039=>"Message: Can't open shared memory; no answer event received from
      server (%lu)",
    2040=>"Message: Can't open shared memory; server could not allocate file
      mapping (%lu)",
    2041=>"Message: Can't open shared memory; server could not get pointer to
      file mapping (%lu)",
    2042=>"Message: Can't open shared memory; client could not allocate file
      mapping (%lu)",
    2043=>"Message: Can't open shared memory; client could not get pointer to
      file mapping (%lu)",
    2044=>"Message: Can't open shared memory; client could not create %s
      event (%lu)",
    2045=>"Message: Can't open shared memory; no answer from server (%lu)",
    2046=>"Message: Can't open shared memory; cannot send request event to
      server (%lu)",
    2047=>"Message: Wrong or unknown protocol",
    2048=>"Message: Invalid connection handle",
    2049=>"Message: Connection using old (pre-4.1.1) authentication protocol
      refused (client option 'secure_auth' enabled)",
    2050=>"Message: Row retrieval was canceled by mysql_stmt_close() call",
    2051=>"Message: Attempt to read column without prior row fetch",
    2052=>"Message: Prepared statement contains no metadata",
    2053=>"Message: Attempt to read a row while there is no result set
      associated with the statement",
    2054=>"Message: This feature is not implemented yet",
    2055=>"Message:Lost connection to MySQL Server at '%s', system error:%d"
}

