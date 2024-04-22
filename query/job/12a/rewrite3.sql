create or replace view aggView6612479506498201032 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin6446205416869362078 as (
with aggView3957978938040154808 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView3957978938040154808 where mi.info_type_id=aggView3957978938040154808.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin8706903494310024318 as (
with aggView3991795926627781329 as (select v29 from aggJoin6446205416869362078 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView3991795926627781329 where t.id=aggView3991795926627781329.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggView8648187631731267318 as select v30, v29 from aggJoin8706903494310024318 group by v30,v29;
create or replace view aggJoin1466620749179341626 as (
with aggView7454927532185929721 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView7454927532185929721 where mi_idx.info_type_id=aggView7454927532185929721.v26);
create or replace view aggJoin979753663615168462 as (
with aggView1765670972186016179 as (select v27, v29 from aggJoin1466620749179341626 group by v27,v29)
select v29, v27 from aggView1765670972186016179 where v27>'8.0');
create or replace view aggJoin3202966654786253396 as (
with aggView8710190328696170281 as (select v29, MIN(v27) as v42 from aggJoin979753663615168462 group by v29)
select v30, v29, v42 from aggView8648187631731267318 join aggView8710190328696170281 using(v29));
create or replace view aggJoin4267125090363436525 as (
with aggView1741770440250409371 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin3202966654786253396 group by v29,v42)
select company_id as v1, company_type_id as v8, v42, v43 from movie_companies as mc, aggView1741770440250409371 where mc.movie_id=aggView1741770440250409371.v29);
create or replace view aggJoin6222613305183548068 as (
with aggView8832355003027602700 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v42, v43 from aggJoin4267125090363436525 join aggView8832355003027602700 using(v8));
create or replace view aggJoin6488503473895025422 as (
with aggView7478834657139377876 as (select v1, MIN(v42) as v42, MIN(v43) as v43 from aggJoin6222613305183548068 group by v1,v43,v42)
select v2, v42, v43 from aggView6612479506498201032 join aggView7478834657139377876 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin6488503473895025422;
