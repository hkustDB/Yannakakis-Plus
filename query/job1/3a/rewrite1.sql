create or replace view aggView1036995339512224432 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4348472539268528482 as select movie_id as v12 from movie_keyword as mk, aggView1036995339512224432 where mk.keyword_id=aggView1036995339512224432.v1;
create or replace view aggView2331289514386987985 as select v12 from aggJoin4348472539268528482 group by v12;
create or replace view aggJoin1668891794632964536 as select id as v12, title as v13, production_year as v16 from title as t, aggView2331289514386987985 where t.id=aggView2331289514386987985.v12 and production_year>2005;
create or replace view aggView186873801496032313 as select v12, MIN(v13) as v24 from aggJoin1668891794632964536 group by v12;
create or replace view aggJoin4947881164525918638 as select v24 from movie_info as mi, aggView186873801496032313 where mi.movie_id=aggView186873801496032313.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin4947881164525918638;
