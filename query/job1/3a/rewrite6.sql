create or replace view aggView1771173217652367821 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin8825475075517930455 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView1771173217652367821 where mk.movie_id=aggView1771173217652367821.v12;
create or replace view aggView2549185396234678103 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin3968475971720904042 as select v1, v24 as v24 from aggJoin8825475075517930455 join aggView2549185396234678103 using(v12);
create or replace view aggView5692412780597763558 as select v1, MIN(v24) as v24 from aggJoin3968475971720904042 group by v1;
create or replace view aggJoin3707326927763009851 as select keyword as v2, v24 from keyword as k, aggView5692412780597763558 where k.id=aggView5692412780597763558.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin3707326927763009851;
