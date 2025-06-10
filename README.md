### {Quick Notes} PostgreSQL Data Types

A categorized list of data types supported in PostgreSQL.

---

#### 1. Numeric Types

| Type              | Description                         |
|-------------------|-------------------------------------|
| `smallint`        | 2 bytes, range: -32,768 to 32,767   |
| `integer` / `int` | 4 bytes, range: -2B to 2B           |
| `bigint`          | 8 bytes, very large range           |
| `decimal(p,s)`    | Exact precision fixed-point         |
| `numeric(p,s)`    | Same as decimal                     |
| `real`            | 4-byte floating point               |
| `double precision`| 8-byte floating point               |
| `serial`          | Auto-incrementing 4-byte integer    |
| `bigserial`       | Auto-incrementing 8-byte integer    |

---

#### 2. Character Types

| Type         | Description                          |
|--------------|--------------------------------------|
| `char(n)`    | Fixed-length string                  |
| `varchar(n)` | Variable-length string with limit    |
| `text`       | Variable-length, no limit            |

---

#### 3. Date/Time Types

| Type         | Description                            |
|--------------|----------------------------------------|
| `timestamp`  | Date and time without time zone        |
| `timestamptz`| Date and time with time zone           |
| `date`       | Calendar date                          |
| `time`       | Time of day without time zone          |
| `timetz`     | Time of day with time zone             |
| `interval`   | Time span (e.g., 3 days, 5 hours)      |

---

#### 4. Boolean Type

| Type      | Description                    |
|-----------|--------------------------------|
| `boolean` | Values: `TRUE`, `FALSE`, `NULL`|

---

#### 5. Geometric Types

| Type      | Description                      |
|-----------|----------------------------------|
| `point`   | (x, y) coordinate pair           |
| `line`    | Infinite line                    |
| `lseg`    | Line segment                     |
| `box`     | Rectangular box                  |
| `path`    | Series of connected points       |
| `polygon` | Closed geometric shape           |
| `circle`  | Circle (center + radius)         |

---

#### 6. Network Types

| Type       | Description           |
|------------|-----------------------|
| `cidr`     | IP address + subnet   |
| `inet`     | IP address only       |
| `macaddr`  | MAC address (6-byte)  |
| `macaddr8` | MAC address (8-byte)  |

---

#### 7. Text Search Types

| Type       | Description                          |
|------------|--------------------------------------|
| `tsvector` | Preprocessed document for search     |
| `tsquery`  | Query format for text searching      |

---

#### 8. JSON Types

| Type   | Description                       |
|--------|-----------------------------------|
| `json` | Stores JSON as raw text           |
| `jsonb`| Binary JSON (indexed, faster)     |

---

#### 9. UUID

| Type  | Description                  |
|-------|------------------------------|
| `uuid`| Universally Unique Identifier|

---

#### 10. Array Types

- Any base type can be made into an array using `[]`
  ```sql
  int[], text[], varchar(20)[]

---

#### 11. Range Types

| Type         | Description                     |
|--------------|---------------------------------|
| `int4range`  | Range of integers               |
| `numrange`   | Range of numerics               |
| `tsrange`    | Range of timestamps             |
| `tstzrange`  | Timestamps with time zone       |
| `daterange`  | Range of dates                  |

---

#### 12. Special Types

| Type             | Description                 |
|------------------|-----------------------------|
| `money`          | Currency with formatting    |
| `bit(n)`         | Bit string of fixed length  |
| `bit varying(n)` | Bit string with max length  |
| `oid`            | Object Identifier (internal)|
| `xml`            | XML-formatted text          |

---

#### 13. Custom/User-Defined Types

| Type           | Description                               |
|----------------|-------------------------------------------|
| `ENUM`         | Custom set of named values                |
| `Composite`    | Structured type with multiple fields      |
| `Domain`       | Constrained base type                     |
| `Custom`       | Fully user-defined types via `CREATE TYPE`|

---

> **Note:** PostgreSQL supports rich data modeling with custom types, array types, and JSONB for document storage, offering much more flexibility than MySQL.

---

#### 🔗 References

- [PostgreSQL Official Docs](https://www.postgresql.org/docs/current/datatype.html)

---

### {Quick Notes} PostgreSQL Foreign Key Usage

In **PostgreSQL**, the `FOREIGN KEY` keyword is used to define a foreign key constraint — it links a column (or columns) in one table to the primary key in another.

#### Common Syntax:

**Inline (Column-level):**
```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(id)
);
```

**Table-level (More flexible):**
```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);
```

> Both are valid. Use **table-level** if you want to name the constraint or define actions like `ON DELETE CASCADE`, `ON UPDATE SET NULL`, etc.

#### Tip:
Use `FOREIGN KEY` constraints to enforce referential integrity and prevent orphan records between related tables.

---

### {Quick Notes} Altering Column Data Types & When to Use `USING`

#### Modifying a Column's Data Type
To change the data type of a column in PostgreSQL:
```sql
ALTER TABLE table_name
ALTER COLUMN column_name TYPE new_data_type;
```

#### When to Use `USING`
You need to use `USING` when PostgreSQL **cannot automatically convert** the old type to the new one.

**Example:** Changing `INTEGER` to `TEXT`:
```sql
ALTER TABLE products
ALTER COLUMN price TYPE TEXT USING price::TEXT;
```

This tells PostgreSQL *how* to convert the data explicitly.

#### When You Can Skip `USING`
You can skip the `USING` clause if the types are **implicitly compatible** (e.g., `VARCHAR` to `TEXT`, `INT` to `BIGINT`).

**Example:**
```sql
ALTER TABLE users
ALTER COLUMN name TYPE TEXT;
```
No `USING` needed here because `VARCHAR` and `TEXT` are compatible.

#### Best Practice
Use `USING` when:
- Changing between incompatible types
- You want **explicit control** over how data is transformed

Skip it when:
- You're doing a safe change between compatible types
- The conversion is automatic and lossless

---

### {Quick Notes} Creating Custom Data Types

PostgreSQL supports creating **custom data types**, which is useful for enhancing schema clarity and enforcing strict constraints.

#### 1. **Creating an Enum Type**
Useful for fields with a fixed set of values (e.g., gender, status).
```sql
CREATE TYPE sex_type AS ENUM ('M', 'F', 'O');
```

**Usage:**
```sql
CREATE TABLE employee (
  name VARCHAR(50),
  sex sex_type
);
```

---

#### 2. **Creating a Composite Type**
Good for structured data stored as a single column.
```sql
CREATE TYPE address AS (
  street VARCHAR,
  city VARCHAR,
  zip INT
);
```

**Usage:**
```sql
CREATE TABLE company (
  name VARCHAR(100),
  location address
);
```

---

#### 3. **Creating a Domain Type**
Best for adding constraints to basic types (e.g., email format).
```sql
CREATE DOMAIN positive_int AS INT
  CHECK (VALUE > 0);
```

**Usage:**
```sql
CREATE TABLE product (
  id positive_int
);
```

---

#### When to Use Custom Types
- To enforce consistent structure across multiple tables
- To improve schema readability
- To centralize validation logic (like `CHECK` constraints)

--- 

### {Quick Notes} Creating Indexes

Indexes in PostgreSQL help speed up data retrieval operations by reducing the amount of data scanned.

---

#### Basic Index Creation
```sql
CREATE INDEX index_name
ON table_name (column1, column2);  -- Can index one or more columns
```

**Example:**
```sql
CREATE INDEX idx_customer_last_name
ON customer (last_name);
```

---

#### Unique Index
Ensures that values in the indexed column(s) are unique.
```sql
CREATE UNIQUE INDEX idx_email_unique
ON users (email);
```

---

#### Index with Expression
You can create indexes on expressions, not just columns.
```sql
CREATE INDEX idx_lower_email
ON users (LOWER(email));
```

---

#### Partial Index
Indexes only part of a table (rows meeting a condition).
```sql
CREATE INDEX idx_active_users
ON users (last_login)
WHERE status = 'active';
```

---

#### When to Use Indexes
- Columns frequently used in `WHERE`, `JOIN`, `ORDER BY`, or `GROUP BY`
- To enforce uniqueness or quick lookups
- For large tables where performance is key

---

#### Caution
- Indexes use storage and slow down `INSERT`, `UPDATE`, `DELETE`
- Don’t over-index — analyze query patterns first

---

### {Quick Note} Foreign Key Actions: 

When defining **foreign key constraints**, PostgreSQL allows specifying what should happen to child table rows when parent table rows are updated or deleted. These options are added using `ON DELETE` or `ON UPDATE`.

---

#### Available Options

##### 1. `CASCADE`
- **Effect:** Automatically propagates changes (delete or update) from the parent to the child.
- **Use Case:** If a parent row is deleted, its corresponding child rows should also be deleted.

```sql
ON DELETE CASCADE
ON UPDATE CASCADE
```

##### 2. `SET NULL`
- **Effect:** Sets the foreign key column in the child table to `NULL` when the parent row is deleted or updated.
- **Use Case:** Use when losing the parent row shouldn't delete the child but just remove the relationship.

```sql
ON DELETE SET NULL
```

##### 3. `SET DEFAULT`
- **Effect:** Sets the foreign key column to its default value when the parent row is deleted or updated.
- **Note:** A default must be explicitly defined.

```sql
ON DELETE SET DEFAULT
```

##### 4. `RESTRICT`
- **Effect:** Prevents deletion or update on the parent if any referencing child rows exist.
- **Use Case:** Ensures parent rows can’t be removed while still in use.

```sql
ON DELETE RESTRICT
```

##### 5. `NO ACTION`
- **Effect:** Similar to `RESTRICT`, but the check is deferred until the end of the statement.
- **Default behavior** if nothing is specified.

```sql
ON DELETE NO ACTION
```

---

#### Example:
```sql
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE
);
```
This setup ensures that if a customer is deleted, all their orders will also be deleted.

---

### {Quick Note} Resetting SERIAL Primary Key Sequence

Sometimes, the `SERIAL` primary key sequence might not start from 1 or may drift due to deletes or other operations.

---

#### Steps to Reset the Sequence

##### 1. Identify the Sequence Name

PostgreSQL automatically creates a sequence for `SERIAL` columns with the pattern:

`<table>_<column>_seq`

To get the exact sequence name, run:

```sql
SELECT pg_get_serial_sequence('product', 'id');
```

---

##### 2. Reset the Sequence

To restart the sequence at 1 (or any desired number), use:

```sql
ALTER SEQUENCE product_id_seq RESTART WITH 1;
```

---

##### 3. Insert New Records

After resetting, the next inserted row will use the restarted sequence value.

```sql
INSERT INTO product (type_id, name, supplier, description)
VALUES (1, 'Example', 'Supplier', 'Desc');  -- id will be 1
```

---

#### Important Notes

- If existing rows have IDs that conflict with the reset sequence, you may get duplicate key errors.
- Adjust or clean existing data accordingly before resetting.

---

### {Quick Note} Pattern Matching Cheat Sheet

#### 1. `LIKE` Operator
**Used for basic pattern matching with wildcards:**

- `%` → matches any sequence of characters (including none)
- `_` → matches a single character

##### Examples:
```sql
-- Names starting with 'Ri'
SELECT * FROM customer WHERE first_name LIKE 'Ri%';

-- Names ending with 'a'
SELECT * FROM customer WHERE first_name LIKE '%a';

-- Case-insensitive search for 'emma'
SELECT * FROM customer WHERE first_name ILIKE '%emma%';
```

---

#### 2. `SIMILAR TO` Operator
**Used for more complex pattern matching (SQL-standard regex style).**

##### Key Features:
- Supports regex elements like `|`, `[]`, `()`, etc.
- More powerful than `LIKE`, but slower

##### Examples:
```sql
-- First names starting with A or J
SELECT * FROM customer WHERE first_name SIMILAR TO '(A|J)%';

-- First names ending in 'n' or 'z'
SELECT * FROM customer WHERE first_name SIMILAR TO '%(n|z)';
```

---

#### 3. Regex Matching (`~`, `~*`, `!~`, `!~*`)
- `~`   → case-sensitive regex match
- `~*`  → case-insensitive regex match
- `!~`  → case-sensitive regex NOT match
- `!~*` → case-insensitive regex NOT match

##### Example:
```sql
-- First names containing digits (unlikely but shows usage)
SELECT * FROM customer WHERE first_name ~ '\d';
```

---

#### Recommendation:
- Use `LIKE`/`ILIKE` for simple patterns
- Use `SIMILAR TO` if you need alternation or character groups
- Use `~`/`~*` for full regex capabilities

---

### {Quick Note} PostgreSQL Views

#### What is a View?
A **view** in PostgreSQL is a **virtual table** based on the result of a SQL query. It doesn't store data physically but lets you query data as if it were a real table.

> "A saved SELECT query that you can reuse like a table."

---

#### Analogy:
Imagine you often join two tables (like `customer` and `sales_order`). Instead of repeating the join every time, you create a view — a shortcut that always returns that join.

---

#### Creating a View
```sql
CREATE VIEW customer_orders AS
SELECT c.first_name, c.last_name, s.purchase_order_num
FROM customer c
JOIN sales_order s ON c.id = s.customer_id;
```

Now you can use:
```sql
SELECT * FROM customer_orders;
```

---

#### Benefits of Views
| Reason                 | Benefit                          |
|------------------------|----------------------------------|
| Simplify queries       | Avoid writing complex joins      |
| Security               | Hide sensitive columns           |
| Reusability            | Use same logic in many places    |
| Abstraction            | Present clean, business-ready data |

---

#### Types of Views

##### 1. **Regular View**
- Defined with `CREATE VIEW`
- Acts like a virtual table
- Sometimes updatable (if query is simple)

##### 2. **Materialized View**
- Stores data physically
- Better for performance on heavy queries
- Needs manual refresh

```sql
CREATE MATERIALIZED VIEW top_customers AS
SELECT customer_id, COUNT(*) AS order_count
FROM sales_order
GROUP BY customer_id;

-- To refresh manually:
REFRESH MATERIALIZED VIEW top_customers;
```

---

#### Notes:
- Most views are **read-only** unless PostgreSQL can map the updates to base tables
- Materialized views do not update automatically

---

### {Quick Notes} NATURAL JOIN in PostgreSQL

A **NATURAL JOIN** in PostgreSQL automatically joins tables using all columns with the same name and compatible data types.

#### Table Definitions
```sql
-- Table 1: student
CREATE TABLE student (
  student_id INT,
  name VARCHAR(50)
);

-- Table 2: marks
CREATE TABLE marks (
  student_id INT,
  subject VARCHAR(20),
  score INT
);
```

#### Sample Data
```sql
-- Insert data into student
INSERT INTO student (student_id, name) VALUES
(1, 'Ritviz'),
(2, 'Abhinav');

-- Insert data into marks
INSERT INTO marks (student_id, subject, score) VALUES
(1, 'Math', 95),
(1, 'Science', 88),
(2, 'Math', 91);
```

#### NATURAL JOIN Example
```sql
SELECT *
FROM student
NATURAL JOIN marks;
```

#### Output Explanation
The query joins both tables using the **`student_id`** column (since it's common in both tables). The result looks like this:

| student_id | name     | subject | score |
|------------|----------|---------|-------|
| 1          | Ritviz   | Math    | 95    |
| 1          | Ritviz   | Science | 88    |
| 2          | Abhinav  | Math    | 91    |

#### Notes
- If no common column is found, it returns a **Cartesian product**.
- If multiple columns match, it uses **all of them** to join.
- Use `JOIN ... ON` for more control.

---


### {Quick Note} Function Parameter Modes: `IN`, `OUT`, and `INOUT`

In PostgreSQL, function parameters can have different **modes** that control how data flows **into** and **out of** a function.

---

#### 1. `IN` (Default)
- Input-only parameter
- Value is passed **into** the function
- **Cannot be modified or returned** unless included in `RETURN`

```sql
CREATE FUNCTION greet(name TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN 'Hello, ' || name || '!';
END;
$$ LANGUAGE plpgsql;

-- Usage
SELECT greet('Ritviz');  -- Output: Hello, Ritviz!
```

---

#### 2. `OUT`
- Output-only parameter
- **Not passed** during the function call
- The function **assigns** a value to it and returns it

```sql
CREATE FUNCTION get_year(out current_year INT)
AS $$
BEGIN
    current_year := EXTRACT(YEAR FROM CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;

-- Usage
SELECT * FROM get_year();  -- Output: current_year = 2025
```

---

#### 3. `INOUT`
- Acts as both **input** and **output**
- Value is passed in and can be **modified** and returned

```sql
CREATE FUNCTION double_num(INOUT num INT)
AS $$
BEGIN
    num := num * 2;
END;
$$ LANGUAGE plpgsql;

-- Usage
SELECT double_num(4);  -- Output: 8
```

---

#### Summary Table

| Mode   | Passed in? | Modified? | Returned? |
|--------|------------|-----------|-----------|
| `IN`   | ✅         | ❌        | ✅ (via RETURN) |
| `OUT`  | ❌         | ✅        | ✅         |
| `INOUT`| ✅         | ✅        | ✅         |

---


### {Quick Note} `RETURN QUERY` in Functions

In PL/pgSQL, `RETURN QUERY` is used inside a function to return the **result of a `SELECT` statement directly**. It's especially useful for:

- Functions returning **multiple rows**
- Functions using `RETURNS TABLE(...)` or `RETURNS SETOF ...`

---

#### Syntax

```sql
RETURN QUERY SELECT ...;
```

You can use multiple `RETURN QUERY` statements to accumulate rows from different queries.

---

#### Example 1: Using `RETURNS TABLE`

```sql
CREATE FUNCTION get_top_students()
RETURNS TABLE(name TEXT, marks INT)
AS $$
BEGIN
    RETURN QUERY
    SELECT student_name, student_marks
    FROM students
    WHERE student_marks > 90;
END;
$$ LANGUAGE plpgsql;

-- Usage
SELECT * FROM get_top_students();
```

This returns a table with `name` and `marks` for students scoring above 90.

---

#### Example 2: Using with `SETOF TYPE`

```sql
-- Define a custom type
CREATE TYPE emp_info AS (
    name TEXT,
    salary NUMERIC
);
```

```sql
-- Use RETURN QUERY with SETOF
CREATE FUNCTION high_salary_emps()
RETURNS SETOF emp_info
AS $$
BEGIN
    RETURN QUERY
    SELECT emp_name, emp_salary
    FROM employees
    WHERE emp_salary > 100000;
END;
$$ LANGUAGE plpgsql;

-- Usage
SELECT * FROM high_salary_emps();
```

---

#### Summary Table

| Keyword        | Description                                  |
|----------------|----------------------------------------------|
| `RETURN`       | Return a single value or row                 |
| `RETURN NEXT`  | Add one row to result (used in loops)        |
| `RETURN QUERY` | Return results of a full query (multi-row)   |

---

### {Quick Note} Cursors in PostgreSQL

#### What are Cursors?

Cursors in PostgreSQL are used to **retrieve query results one row at a time**, rather than fetching the entire result set at once.

They're helpful when:
- You're dealing with **large datasets**.
- You need to **process rows one-by-one** in a loop.
- You're working within a **PL/pgSQL function or DO block**.

---

#### Steps to Use a Cursor

##### 1. Declare
```sql
DECLARE my_cursor CURSOR FOR
SELECT * FROM employees WHERE department = 'Sales';
```

##### 2. Open (optional inside functions)
```sql
OPEN my_cursor;
```

##### 3. Fetch
```sql
FETCH NEXT FROM my_cursor;
-- or FETCH n ROWS FROM my_cursor;
```

##### 4. Loop Through Rows
```sql
LOOP
    FETCH my_cursor INTO emp_record;
    EXIT WHEN NOT FOUND;
    -- process emp_record
END LOOP;
```

##### 5. Close
```sql
CLOSE my_cursor;
```

---

##### Example in PL/pgSQL
```sql
DO $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR SELECT employee_id, name FROM employees;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Employee: %, %', emp_record.employee_id, emp_record.name;
    END LOOP;
    CLOSE emp_cursor;
END $$;
```

---

##### Notes
- Cursors are often used **inside procedures and functions**.
- If you want simpler syntax, you can also use a `FOR record_var IN cursor_query LOOP` structure.









