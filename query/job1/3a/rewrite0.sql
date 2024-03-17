create or replace view aggView539616911148820877 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4949660261783326651 as select movie_id as v12 from movie_keyword as mk, aggView539616911148820877 where mk.keyword_id=aggView539616911148820877.v1;
create or replace view aggView1245656620159818306 as select v12 from aggJoin4949660261783326651 group by v12;
create or replace view aggJoin2972954574670192960 as select movie_id as v12, info as v7 from movie_info as mi, aggView1245656620159818306 where mi.movie_id=aggView1245656620159818306.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView9176886516635822760 as select v12 from aggJoin2972954574670192960 group by v12;
create or replace view aggJoin5280166380267220226 as select title as v13 from title as t, aggView9176886516635822760 where t.id=aggView9176886516635822760.v12 and production_year>2005;
create or replace view res as select MIN(v13) as v24 from aggJoin5280166380267220226;
select sum(v24) from res;