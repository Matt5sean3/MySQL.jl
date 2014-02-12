using DBI
using MySQL

db = connect(MySQL5, "localhost", "test", "test123", "julia")

sql = "CREATE TABLE if not exists users (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(255))"
mysql_debug("d:t:O,/tmp/juliaclient.trace")
stmt = prepare(db, sql)
execute(stmt)

try

pstmt = prepare(db, sql)
    execute(stmt)
end

errcode(db)
errstring(db)

rowid = lastinsertid(db)

stmt = prepare(db, "INSERT INTO users (name) VALUES ('Jeff Bezanson')")
execute(stmt)

stmt = prepare(db, "INSERT INTO users (name) VALUES ('Viral Shah')")
execute(stmt)

stmt = prepare(db, "INSERT INTO users (name) VALUES ('Stefan Karpinski')")
execute(stmt)

rowid = lastinsertid(db)
new_stmt = prepare(db, "SELECT id from users")
execute(new_stmt)
println(fetchrow(new_stmt))
println(fetchrow(new_stmt))
println(fetchrow(new_stmt))
stmt = prepare(db, "DROP TABLE users")
execute(stmt)

disconnect(db)
