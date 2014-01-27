function mysql_stmt_bind_result(stmtptr::Ptr{Void}, bindptr::Ptr{Void})
    
    val = ccall((:mysql_stmt_bind_result, mysql_lib),
                 Cint, # TODO: Confirm proper type to use here
                 (Ptr{Void}, Ptr{Void}),
                 stmtptr, bindptr)
   if val !=0
        error(Messages[val])
   end
    val
end

function mysql_stmt_result_metadata(stmtptr::Ptr{Void})
    
    val = ccall((:mysql_stmt_result_metadata, mysql_lib),
                 Ptr{Void}, # TODO: Confirm proper type to use here
                 (Ptr{Void}, ),
                 stmtptr)
   if val == C_NULL
        error(Messages[val])
   end
    val
end

function mysql_fetch_fields(mysql_res::Ptr{Void})
    
    val = ccall((:mysql_fetch_fields, mysql_lib),
                 Ptr{CMysqlField}, # TODO: Confirm proper type to use here
                 (Ptr{Void}, ),
                 mysql_res)
   if val == C_NULL
        error(Messages[val])
   end
    val
end




function mysql_stmt_fetch(stmtptr::Ptr{Void})
    val = ccall((:mysql_stmt_fetch, mysql_lib),
                 Cint, # TODO: Confirm proper type to use here
                 (Ptr{Void}, ),
                 stmtptr)
    if val!=0 
        if val in [MYSQL_NO_DATA, MYSQL_DATA_TRUNCATED]
            return val
        elseif val in Messages
            error(Messages[val])
        end
    end
    val
        
end
