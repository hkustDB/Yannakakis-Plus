create or replace view aggView1916128814801265520 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin970422808537383560 as select movie_id as v23, v35 from movie_keyword as mk, aggView1916128814801265520 where mk.keyword_id=aggView1916128814801265520.v8;
create or replace view aggView4776804235701142031 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6088680428355968846 as select movie_id as v23, v36 from cast_info as ci, aggView4776804235701142031 where ci.person_id=aggView4776804235701142031.v14;
create or replace view aggView5913375649853946515 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin6643776449160181259 as select v23, v36, v37 from aggJoin6088680428355968846 join aggView5913375649853946515 using(v23);
create or replace view aggView2488297308784027939 as select v23, MIN(v35) as v35 from aggJoin970422808537383560 group by v23,v35;
create or replace view aggJoin4582573682273700079 as select v36 as v36, v37 as v37, v35 from aggJoin6643776449160181259 join aggView2488297308784027939 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4582573682273700079;
