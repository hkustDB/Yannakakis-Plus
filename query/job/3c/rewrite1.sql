create or replace view aggJoin5701247452240357374 as (
with aggView4832452643014756094 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id)
select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView4832452643014756094 where mk.movie_id=aggView4832452643014756094.v12);
create or replace view aggJoin9068871456604141356 as (
with aggView1079541358426434049 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v12 from aggJoin5701247452240357374 join aggView1079541358426434049 using(v1));
create or replace view aggJoin8416641724144600375 as (
with aggView4100333881024548190 as (select v12 from aggJoin9068871456604141356 group by v12)
select title as v13, production_year as v16 from title as t, aggView4100333881024548190 where t.id=aggView4100333881024548190.v12 and production_year>1990);
create or replace view aggView5158466352482862876 as select v13 from aggJoin8416641724144600375 group by v13;
select MIN(v13) as v24 from aggView5158466352482862876;
