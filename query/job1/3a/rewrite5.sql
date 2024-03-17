create or replace view aggView2094482841444383535 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin1577368746208034976 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2094482841444383535 where mi.movie_id=aggView2094482841444383535.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView992591876333472531 as select v12, MIN(v24) as v24 from aggJoin1577368746208034976 group by v12;
create or replace view aggJoin9089119033548222266 as select keyword_id as v1, v24 from movie_keyword as mk, aggView992591876333472531 where mk.movie_id=aggView992591876333472531.v12;
create or replace view aggView6443954856416378358 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6436913811670911815 as select v24 from aggJoin9089119033548222266 join aggView6443954856416378358 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin6436913811670911815;
select sum(v24) from res;