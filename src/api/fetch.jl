function mysql_stmt_bind_result(stmtptr::Ptr{Void}, bindarray::Array{CMySQLBind,1})
    println("before execution") 
    val = ccall((:mysql_stmt_bind_result, mysql_lib),
                 Cint, # TODO: Confirm proper type to use here
                 (Ptr{Void}, Ptr{Void}),
                 stmtptr, bindarray)
    println("after execution") 
    if val != 0
        message = mysql_stmt_error(stmtptr)
        error(message)
    end
    val
end

function mysql_stmt_result_metadata(stmtptr::Ptr{Void})
    
    ccall((:mysql_stmt_result_metadata, mysql_lib),
                 Ptr{Void}, # TODO: Confirm proper type to use here
                 (Ptr{Void}, ),
                 stmtptr)
end

function mysql_fetch_fields(mysql_res::Ptr{Void})
    
    ccall((:mysql_fetch_fields, mysql_lib),
                 Ptr{CMySQLField}, # TODO: Confirm proper type to use here
                 (Ptr{Void}, ),
                 mysql_res)
end




function mysql_stmt_fetch(stmtptr::Ptr{Void})
    val = ccall((:mysql_stmt_fetch, mysql_lib),
                 Cint, # TODO: Confirm proper type to use here
                 (Ptr{Void}, ),
                 stmtptr)
    if val == 1
        error(mysql_stmt_error(stmtptr))
    end
    val
end

function mysql_num_fields(mysql_res::Ptr{Void})
    
    ccall((:mysql_num_fields, mysql_lib),
                 Cuint, # TODO: Confirm proper type to use here
                 (Ptr{Void}, ),
                 mysql_res)
end

