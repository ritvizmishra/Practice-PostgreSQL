### PostgreSQL Data Types

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

### PostgreSQL Foreign Key Usage – Quick Note

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

