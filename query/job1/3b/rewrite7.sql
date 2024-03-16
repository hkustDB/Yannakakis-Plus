create or replace view aggView680925632661325115 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin4198673827042761721 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView680925632661325115 where mk.movie_id=aggView680925632661325115.v12;
create or replace view aggView5257634464320153935 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6189098166078796577 as select v12, v24 from aggJoin4198673827042761721 join aggView5257634464320153935 using(v1);
create or replace view aggView7913734512355206551 as select v12, MIN(v24) as v24 from aggJoin6189098166078796577 group by v12;
create or replace view aggJoin939869984587066678 as select info as v7, v24 from movie_info as mi, aggView7913734512355206551 where mi.movie_id=aggView7913734512355206551.v12 and info= 'Bulgaria';
create or replace view res as select MIN(v24) as v24 from aggJoin939869984587066678;
select sum(v24) from res;