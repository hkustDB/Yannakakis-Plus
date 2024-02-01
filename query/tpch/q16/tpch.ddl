CREATE TABLE nation
(
    n_nationkey INTEGER,
    n_name      VARCHAR,
    n_regionkey INTEGER,
    n_comment   VARCHAR,
    PRIMARY KEY (n_nationkey)
);

CREATE TABLE region
(
    r_regionkey INTEGER,
    r_name      VARCHAR,
    r_comment   VARCHAR,
    PRIMARY KEY (r_regionkey)
);

CREATE TABLE part
(
    p_partkey     INTEGER,
    p_name        VARCHAR,
    p_mfgr        VARCHAR,
    p_brand       VARCHAR,
    p_type        VARCHAR,
    p_size        INTEGER,
    p_container   VARCHAR,
    p_retailprice DECIMAL,
    p_comment     VARCHAR,
    PRIMARY KEY (p_partkey)
);

CREATE TABLE supplier
(
    s_suppkey   INTEGER,
    s_name      VARCHAR,
    s_address   VARCHAR,
    s_nationkey INTEGER,
    s_phone     VARCHAR,
    s_acctbal   DECIMAL,
    s_comment   VARCHAR,
    PRIMARY KEY (s_suppkey)
);

CREATE TABLE partsupp
(
    ps_partkey    INTEGER,
    ps_suppkey    INTEGER,
    ps_availqty   INTEGER,
    ps_supplycost DECIMAL,
    ps_comment    VARCHAR,
    PRIMARY KEY (ps_partkey, ps_suppkey)
);

CREATE TABLE customer
(
    c_custkey    INTEGER,
    c_name       VARCHAR,
    c_address    VARCHAR,
    c_nationkey  INTEGER,
    c_phone      VARCHAR,
    c_acctbal    DECIMAL,
    c_mktsegment VARCHAR,
    c_comment    VARCHAR,
    PRIMARY KEY (c_custkey)
);

CREATE TABLE orders
(
    o_orderkey      INTEGER,
    o_custkey       INTEGER,
    o_orderstatus   VARCHAR,
    o_totalprice    DECIMAL,
    o_orderdate     DATE,
    o_orderpriority VARCHAR,
    o_clerk         VARCHAR,
    o_shippriority  INTEGER,
    o_comment       VARCHAR,
    PRIMARY KEY (o_orderkey)
);

CREATE TABLE lineitem
(
    l_orderkey      INTEGER,
    l_partkey       INTEGER,
    l_suppkey       INTEGER,
    l_linenumber    INTEGER,
    l_quantity      DECIMAL,
    l_extendedprice DECIMAL,
    l_discount      DECIMAL,
    l_tax           DECIMAL,
    l_returnflag    VARCHAR,
    l_linestatus    VARCHAR,
    l_shipdate      DATE,
    l_commitdate    DATE,
    l_receiptdate   DATE,
    l_shipinstruct  VARCHAR,
    l_shipmode      VARCHAR,
    l_comment       VARCHAR,
    PRIMARY KEY (l_orderkey, l_linenumber)
);