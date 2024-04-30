create or replace view aggView1547505151864848979 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin7347608598459936967 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1547505151864848979 where mi.movie_id=aggView1547505151864848979.v12 and info= 'Bulgaria';
create or replace view aggView6958797704871864212 as select v12, MIN(v24) as v24 from aggJoin7347608598459936967 group by v12;
create or replace view aggJoin4602763380627988286 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6958797704871864212 where mk.movie_id=aggView6958797704871864212.v12;
create or replace view aggView1053603278485170388 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4629885044214692079 as select v24 from aggJoin4602763380627988286 join aggView1053603278485170388 using(v1);
select MIN(v24) as v24 from aggJoin4629885044214692079;
