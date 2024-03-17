create or replace view aggView8860888494135719774 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin8608301401870953705 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8860888494135719774 where mi.movie_id=aggView8860888494135719774.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1467044867245868846 as select v12, MIN(v24) as v24 from aggJoin8608301401870953705 group by v12;
create or replace view aggJoin1494386638262024040 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1467044867245868846 where mk.movie_id=aggView1467044867245868846.v12;
create or replace view aggView8509929546494024645 as select v1, MIN(v24) as v24 from aggJoin1494386638262024040 group by v1;
create or replace view aggJoin4215946384124567962 as select keyword as v2, v24 from keyword as k, aggView8509929546494024645 where k.id=aggView8509929546494024645.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin4215946384124567962;
select sum(v24) from res;