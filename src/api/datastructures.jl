immutable MySQLBind
    buffer_type :: Uint
    buffer :: Ptr{Uint8}
    buffer_length :: Uint
    length :: Ptr{Uint}
    is_null :: Ptr{Bool}
    is_unsigned :: Ptr{Bool}
    error :: Ptr{Bool}
end

type CMysqlField
    name :: Ptr{Uint8}
    org_name :: Ptr{Uint8}
    table :: Ptr{Uint8}
    org_table :: Ptr{Uint8}
    db :: Ptr{Uint8}
    catalog :: Ptr{Uint8}
    def :: Ptr{Uint8}
    @windows_only length :: Uint32
    @windows_only max_length :: Uint32
    @unix_only length :: Uint
    @unix_only max_length :: Uint
    org_name_length :: Uint32
    table_length :: Uint32
    org_table_length :: Uint32
    db_length :: Uint32
    catalog_length :: Uint32
    def_length :: Uint32
    flags :: Uint
    decimals :: Uint
    charsetnr :: Uint
    field_type :: Uint #type in C struct
    extension :: Ptr{Void}
end

type JMysqlField
    c_mysql_field :: CMysqlField
    name :: String
    table :: String
    def :: String
    field_type :: Uint
    length :: Uint
    max_length :: Uint
    flags :: Uint
    decimals :: Uint
    charsetnr :: Uint
end

function JMysqlField(pt::Ptr{CMysqlField})
    cfield = unsafe_ref(pt+1)
    println(cfield.name)
    println(bytestring(cfield.name))
    println(cfield.table)
    println(bytestring(cfield.table))
    println(cfield.def)
    def = cfield.def == C_NULL? "" :bytestring(cfield.def)
        JMysqlField(cfield, 
                    bytestring(cfield.name), 
                    bytestring(cfield.table),
                    def, 
                    cfield.field_type, 
                    cfield.length, 
                    cfield.max_length, 
                    cfield.flags, 
                    cfield.decimals, 
                    cfield.charsetnr,
                    )
end

function show(field::JMysqlField)
    return "MYSQL_FIELD Object
name=$(field.name)
table=$(field.table)
def=$(field.def)
field_type=$(field.field_type)
length=$(field.length)
max_length=$(field.max_length)
flags=$(field.flags)
decimals=$(field.decimals)
charsetnr=$(field.charsetnr)"
end
