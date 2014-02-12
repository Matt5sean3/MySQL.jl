type CMySQLBind
    @unix_only length :: Ptr{Uint}
    @windows_only length :: Ptr{Uint32}
    is_null :: Ptr{Bool}
    buffer :: Ptr{Void}
    error :: Ptr{Bool}
    row_ptr :: Ptr{Uint8}
    store_param_func :: Ptr{Void}
    fetch_result :: Ptr{Void}
    skip_result :: Ptr{Void}
    @unix_only buffer_length :: Uint
    @windows_only buffer_length :: Uint32
    @unix_only offset :: Uint
    @windows_only offset :: Uint32
    @unix_only length_value :: Uint
    @windows_only length_value :: Uint32
    param_number :: Uint32
    pack_length :: Uint32
    @unix_only buffer_type :: Uint32#Uint
    @windows_only buffer_type :: Uint32#Uint32
    error_value :: Bool
    is_unsigned :: Bool
    long_data_used :: Bool
    is_null_value :: Bool
    extension :: Ptr{Void}
end

type JMySQLBind
    @unix_only buffer_type :: Uint
    @windows_only buffer_type :: Uint32
    buffer :: Any
    @unix_only buffer_length :: Uint
    @windows_only buffer_length :: Uint32
    @unix_only length :: Uint
    @windows_only length :: Uint32
    is_null :: Bool
    is_unsigned :: Bool
    error :: Bool
end

function CMySQLBind(bind::JMySQLBind)
    CMySQLBind(
               pointer_from_objref(bind.length),
               pointer_from_objref(bind.is_null),
               pointer_from_objref(bind.buffer),
               pointer_from_objref(bind.error),
               C_NULL,
               C_NULL,
               C_NULL,
               C_NULL,
               bind.buffer_length,
               0,0,0,0,
               bind.buffer_type,
               false,
               bind.is_unsigned,
               false,
               false,
               C_NULL
               )
    end
                
function show(jbind::JMySQLBind)
    return "buffer_type=$(Uint(jbind.buffer_type))
            buffer=$(int(bytestring(jbind.buffer)))
            length=$(jbind.length)
            is_unsigned=$(jbind.is_unsigned)
            error=$(jbind.error)
            "
    end
type CMySQLField
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
    name_length :: Uint32
    org_name_length :: Uint32
    table_length :: Uint32
    org_table_length :: Uint32
    db_length :: Uint32
    catalog_length :: Uint32
    def_length :: Uint32
    flags :: Uint32
    decimals :: Uint32
    charsetnr :: Uint32
    field_type :: Uint #type in C struct
    extension :: Ptr{Void}
end

type JMySQLField
    c_mysql_field :: CMySQLField
    name :: String
    table :: String
#    def :: String
    field_type :: Uint
    length :: Uint
    max_length :: Uint
    flags :: Uint
    decimals :: Uint
    charsetnr :: Uint
end

#function JMysqlField(pt::Ptr{CMysqlField})
function JMySQLField(cfield::CMySQLField)
#    def = cfield.def == C_NULL? "" :bytestring(cfield.def)
        JMySQLField(cfield, 
                    bytestring(cfield.name), 
                    bytestring(cfield.table),
#                    def, 
                    cfield.field_type, 
                    cfield.length, 
                    cfield.max_length, 
                    cfield.flags, 
                    cfield.decimals, 
                    cfield.charsetnr,
                    )
end

function show(field::JMySQLField)
    return "MYSQL_FIELD Object
name=$(field.name)
table=$(field.table)
field_type=$(field.field_type)
length=$(field.length)
max_length=$(field.max_length)
flags=$(field.flags)
decimals=$(field.decimals)
charsetnr=$(field.charsetnr)"
end
