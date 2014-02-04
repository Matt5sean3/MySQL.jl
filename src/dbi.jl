function Base.connect(::Type{MySQL5},
                      host::String,
                      user::String,
                      passwd::String,
                      db::String, # TODO: Let this be optional?
                      port::Integer = 0,
                      unix_socket::Any = C_NULL,
                      client_flag::Integer = 0)
    mysqlptr = C_NULL

    mysqlptr = mysql_init(mysqlptr)

    if mysqlptr == C_NULL
        error("Failed to connect to MySQL database")
    end

    mysqlptr = mysql_real_connect(mysqlptr,
                                  host,
                                  user,
                                  passwd,
                                  db,
                                  convert(Cint, port), # TODO: Confirm type here
                                  unix_socket,
                                  convert(Uint64, client_flag)) # TODO: Confirm type here

    if mysqlptr == C_NULL
        error("Failed to connect to MySQL database")
    end

    return MySQLDatabaseHandle(mysqlptr, 0)
end

function DBI.disconnect(db::MySQLDatabaseHandle)
    mysql_close(db.ptr)
    return
end

function DBI.columninfo(db::MySQLDatabaseHandle,
                        table::String,
                        column::String)
    error("DBI API not fully implemented")
end

function DBI.prepare(db::MySQLDatabaseHandle, sql::String)
    stmtptr = mysql_stmt_init(db.ptr)
    if stmtptr == C_NULL
        error("Failed to allocate statement handle")
    end
    status = mysql_stmt_prepare(stmtptr, sql)
    db.status = status
    if status != 0
        msg = bytestring(mysql_stmt_error(stmtptr))
        error(msg)
    end
    stmt = MySQLStatementHandle(db, stmtptr)
    return stmt
end

function DBI.errcode(db::MySQLDatabaseHandle)
    return int(mysql_errno(db.ptr))
end

# TODO: Make a copy here?
function DBI.errstring(db::MySQLDatabaseHandle)
    return bytestring(mysql_error(db.ptr))
end

function DBI.execute(stmt::MySQLStatementHandle)
    status = mysql_stmt_execute(stmt.ptr)
    stmt.db.status = status
    if status != 0
        error(errstring(stmt.db))
    else
        stmt.executed += 1
    end
    return
end

function DBI.fetchall(stmt::MySQLStatementHandle)
    error("DBI API not fully implemented")
end

function DBI.fetchdf(stmt::MySQLStatementHandle)
    error("DBI API not fully implemented")
end


function fetch_column_meta(stmt::MySQLStatementHandle)
    println("fetch meta")
    if stmt.stored == false

        mysql_stmt_attr_set(stmt.ptr, STMT_ATTR_UPDATE_MAX_LENGTH, int8(1))
        println("attr set")
        mysql_stmt_store_result(stmt.ptr)
        println("store result")
        stmt.stored = true
    end
    mysql_res = mysql_stmt_result_metadata(stmt.ptr)
    fields = mysql_fetch_fields(mysql_res)
    fields_count = mysql_num_fields(mysql_res)
    #y = unsafe_load(fields)
    jfields = Array(JMySQLField, fields_count)
    #cmysqlbinds = Array(CMySQLBind, fields_count)
    #jmysqlbinds = Array(JMySQLBind, fields_count)
    cmysqlbinds = CMySQLBind[]
    jmysqlbinds = JMySQLBind[]
    for x in 1:fields_count
        field = JMySQLField(unsafe_load(fields, x))
        jfields[x] = field
        println(field.max_length)
        buffer = Array(Uint8, field.max_length) 
        #buffer = uint(0)

        jbind = JMySQLBind(field.field_type, buffer, field.max_length, 0, false,false, false)
        cbind = CMySQLBind(jbind)
        #cmysqlbinds[x] = cbind
        #jmysqlbinds[x] = jbind
        push!(cmysqlbinds, cbind)
        push!(jmysqlbinds, jbind)
    end 
    mysql_stmt_bind_result(stmt.ptr, cmysqlbinds)
    return cmysqlbinds, jmysqlbinds
end

function DBI.fetchrow(stmt::MySQLStatementHandle)
    cmysqlbinds, jmysqlbinds = fetch_column_meta(stmt)
    println("bound")
    mysql_stmt_fetch(stmt.ptr) 
    println("fetched")
    #println(jmysqlbinds[0].buffer_type)
    #println(bytestring(cmysqlbinds[0].buffer))
    println((cmysqlbinds[1].buffer))
    println(unsafe_pointer_to_objref(cmysqlbinds[1].buffer))
    #println(jmysqlbinds[1])
    #println(int32(jmysqlbinds[1].buffer))
    #println(show(jmysqlbinds[1]))
    #error("DBI API not fully implemented")
    
end

function DBI.finish(stmt::MySQLStatementHandle)
    failed = mysql_stmt_close(stmt.ptr)
    if failed
        error("Failed to close MySQL statement handle")
    end
    return
end

function DBI.lastinsertid(db::MySQLDatabaseHandle)
    return int64(mysql_insert_id(db.ptr))
end

# TODO: Rename this
function DBI.sqlescape(db::MySQLDatabaseHandle, dirtysql::String)
    to = Array(Uint8, 4 * length(dirtysql))
    writelength = mysql_real_escape_string(db.ptr,
                                           to,
                                           dirtysql,
                                           convert(Uint32, length(dirtysql)))
    return bytestring(to[1:writelength])
end

function DBI.tableinfo(db::MySQLDatabaseHandle, table::String)
    error("DBI API not fully implemented")
end
