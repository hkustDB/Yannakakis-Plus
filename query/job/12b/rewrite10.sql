create or replace view aggJoin358470488825767243 as (
with aggView4146556861796057724 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView4146556861796057724 where mi.info_type_id=aggView4146556861796057724.v21);
create or replace view aggJoin4347918809885337969 as (
with aggView7314178110577351150 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView7314178110577351150 where mc.company_id=aggView7314178110577351150.v1);
create or replace view aggJoin1640772334374475925 as (
with aggView9108852758530345644 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin4347918809885337969 join aggView9108852758530345644 using(v8));
create or replace view aggJoin3889007739190844461 as (
with aggView7696228331457538404 as (select v29 from aggJoin1640772334374475925 group by v29)
select movie_id as v29, info_type_id as v26 from movie_info_idx as mi_idx, aggView7696228331457538404 where mi_idx.movie_id=aggView7696228331457538404.v29);
create or replace view aggJoin5750895084554468415 as (
with aggView3330369578928890852 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29 from aggJoin3889007739190844461 join aggView3330369578928890852 using(v26));
create or replace view aggJoin3147088188114897405 as (
with aggView4100895243720010500 as (select v29 from aggJoin5750895084554468415 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView4100895243720010500 where t.id=aggView4100895243720010500.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin7496812067001507707 as (
with aggView7415864044834626982 as (select v29, MIN(v30) as v42 from aggJoin3147088188114897405 group by v29)
select v22, v42 from aggJoin358470488825767243 join aggView7415864044834626982 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin7496812067001507707;
