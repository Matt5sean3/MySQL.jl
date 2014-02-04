abstract MySQL5 <: DBI.DatabaseSystem

type MySQLDatabaseHandle <: DBI.DatabaseHandle
    ptr::Ptr{Void}
    status::Cint
end

type MySQLStatementHandle <: DBI.StatementHandle
    db::MySQLDatabaseHandle
    ptr::Ptr{Void}
    executed::Int
    stored::Bool
    function MySQLStatementHandle(db::MySQLDatabaseHandle,
                                  ptr::Ptr{Void})
        new(db, ptr, 0, false)
    end
end
