SHOW TABLE STATUS

CREATE TABLE employees (

    id INT NOT NULL,

    fname VARCHAR(30),

    lname VARCHAR(30),

    hired DATE NOT NULL DEFAULT '1970-01-01',

    separated DATE NOT NULL DEFAULT '9999-12-31',

    job_code INT NOT NULL,

    store_id INT NOT NULL

)

PARTITION BY RANGE (job_code) (

    PARTITION p0 VALUES LESS THAN (100),

    PARTITION p1 VALUES LESS THAN (1000),

    PARTITION p2 VALUES LESS THAN (10000)
);

mengfc


webex.doc

not null   的好处 range分区时 null lessthan无法处理  



list 分区



CREATE TABLE employees (

    id INT NOT NULL,

    fname VARCHAR(30),

    lname VARCHAR(30),

    hired DATE NOT NULL DEFAULT '1970-01-01',

    separated DATE NOT NULL DEFAULT '9999-12-31',

    job_code INT,

    store_id INT

)

PARTITION BY LIST(store_id)

    PARTITION pNorth VALUES IN (3,5,6,9,17),

    PARTITION pEast VALUES IN (1,2,10,11,19,20),

    PARTITION pWest VALUES IN (4,12,13,14,18),

    PARTITION pCentral VALUES IN (7,8,15,16)

)；


ALTER TABLE employees DROP PARTITION pWest;


CREATE TABLE employees (

    id INT NOT NULL,

    fname VARCHAR(30),

    lname VARCHAR(30),

    hired DATE NOT NULL DEFAULT '1970-01-01',

    separated DATE NOT NULL DEFAULT '9999-12-31',

    job_code INT,

    store_id INT

)

PARTITION BY HASH(store_id)

PARTITIONS 4；


CREATE TABLE t1 (col1 INT, col2 CHAR(5), col3 DATE)

    PARTITION BY HASH( YEAR(col3) )

    PARTITIONS 4；


    CREATE TABLE ts (id INT, purchased DATE)

    PARTITION BY RANGE(YEAR(purchased))

    SUBPARTITION BY HASH(TO_DAYS(purchased))

    SUBPARTITIONS 2

    (

        PARTITION p0 VALUES LESS THAN (1990),

        PARTITION p1 VALUES LESS THAN (2000),

        PARTITION p2 VALUES LESS THAN MAXVALUE

    )；


CREATE TABLE account (acct_num INT, amount DECIMAL(10,2));
CREATE TRIGGER ins_sum BEFORE INSERT ON account
FOR EACH ROW SET @sum = @sum + NEW.amount;


注释：从MySQL 5.0.10之前的MySQL版本升级到5.0.10或更高版本时（包括所有的MySQL 5.1版本），必须在升级之前舍弃所有的触发程序，并在随后重新创建它们，否则，在升级之后DROP TRIGGER不工作。关于推荐的升级步骤，请参见2.10.1节，“从5.0版升级” 。

DROP TRIGGER语句需要SUPER权限。

触发器 --------- aop


mysql> delimiter //

mysql> CREATE TRIGGER upd_check BEFORE UPDATE ON account

    -> FOR EACH ROW

    -> BEGIN

    ->     IF NEW.amount < 0 THEN

    ->         SET NEW.amount = 0;

    ->     ELSEIF NEW.amount > 100 THEN

    ->         SET NEW.amount = 100;

    ->     END IF;

    -> END;//

mysql> delimiter ;


hibernate shards

hivedb





    CREATE TABLE `test` (
      `ver` varchar(10) DEFAULT NULL,
      `kid` int(11) DEFAULT NULL,
      `mid` int(11) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

    insert  into `test`(`ver`,`kid`,`mid`) values ('0.0.1',203,29),('0.0.1',203,4),('0.0.1',203,38),('0.0.1',203,86),
    ('0.0.1',203,42),('0.0.1',203,546),('0.0.1',203,34),('0.0.1',204,15),('0.0.1',204,20),('0.0.1',204,371),('0.0.1',204,78),('0.0.1',204,57),
    ('0.0.1',204,38),('0.0.1',204,960),(NULL,NULL,0);    
select t1.* from test t1 where (select count(*) from test t2 where t1.kid=t2.kid and t1.mid<t2.mid)<=2 order by kid desc,mid desc;


MySQL with HandlerSocket


mysql-cluster

ndb

mysql memcache

mariadb


