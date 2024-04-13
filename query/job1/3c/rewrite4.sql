create or replace view aggView6617411177745380516 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin8416145926282332565 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6617411177745380516 where mi.movie_id=aggView6617411177745380516.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5741538951306183597 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1699729059490827341 as select movie_id as v12 from movie_keyword as mk, aggView5741538951306183597 where mk.keyword_id=aggView5741538951306183597.v1;
create or replace view aggView5962865224822171555 as select v12 from aggJoin1699729059490827341 group by v12;
create or replace view aggJoin7344423387372737052 as select v24 as v24 from aggJoin8416145926282332565 join aggView5962865224822171555 using(v12);
select MIN(v24) as v24 from aggJoin7344423387372737052;
