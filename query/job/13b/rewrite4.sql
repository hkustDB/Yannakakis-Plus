create or replace view aggJoin2502996814005622929 as (
with aggView2335795503273411462 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2335795503273411462 where mc.company_id=aggView2335795503273411462.v1);
create or replace view aggJoin8333755061661252859 as (
with aggView6226448961068891108 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2502996814005622929 join aggView6226448961068891108 using(v8));
create or replace view aggJoin542481914423468190 as (
with aggView6187974369296064059 as (select v22, MIN(v43) as v43 from aggJoin8333755061661252859 group by v22,v43)
select movie_id as v22, info_type_id as v10, info as v29, v43 from movie_info_idx as miidx, aggView6187974369296064059 where miidx.movie_id=aggView6187974369296064059.v22);
create or replace view aggJoin1272210743766923609 as (
with aggView903736678267517609 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView903736678267517609 where mi.info_type_id=aggView903736678267517609.v12);
create or replace view aggJoin6744514707030192988 as (
with aggView3402452685801546210 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29, v43 from aggJoin542481914423468190 join aggView3402452685801546210 using(v10));
create or replace view aggJoin7029033559178481443 as (
with aggView9093810841874078767 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin6744514707030192988 group by v22,v43)
select id as v22, title as v32, kind_id as v14, v43, v44 from title as t, aggView9093810841874078767 where t.id=aggView9093810841874078767.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin7924553180334315788 as (
with aggView7491470289636922259 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43, v44 from aggJoin7029033559178481443 join aggView7491470289636922259 using(v14));
create or replace view aggJoin6402854694422662803 as (
with aggView7648529297342736182 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v32) as v45 from aggJoin7924553180334315788 group by v22,v43,v44)
select v43, v44, v45 from aggJoin1272210743766923609 join aggView7648529297342736182 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin6402854694422662803;
