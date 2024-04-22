create or replace view aggJoin9215635073211858101 as (
with aggView186088441116868574 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView186088441116868574 where mc.company_id=aggView186088441116868574.v1);
create or replace view aggJoin8859796832849012216 as (
with aggView1299087895904894620 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView1299087895904894620 where mi.info_type_id=aggView1299087895904894620.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3942789778605221526 as (
with aggView8706341741496211042 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView8706341741496211042 where mk.keyword_id=aggView8706341741496211042.v14);
create or replace view aggJoin6348870759680000854 as (
with aggView6114411221445105867 as (select v37 from aggJoin8859796832849012216 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41 from title as t, aggView6114411221445105867 where t.id=aggView6114411221445105867.v37 and production_year>2005);
create or replace view aggJoin8777881233207154018 as (
with aggView5809057892277521230 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin9215635073211858101 join aggView5809057892277521230 using(v8));
create or replace view aggJoin7615573030733841760 as (
with aggView4759052164873602303 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView4759052164873602303 where mi_idx.info_type_id=aggView4759052164873602303.v12 and info<'8.5');
create or replace view aggJoin1288101006449354024 as (
with aggView2813000632253624645 as (select v37, MIN(v49) as v49 from aggJoin8777881233207154018 group by v37,v49)
select v37, v49 from aggJoin3942789778605221526 join aggView2813000632253624645 using(v37));
create or replace view aggJoin6152061834692567320 as (
with aggView8799837101828194241 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41 from aggJoin6348870759680000854 join aggView8799837101828194241 using(v17));
create or replace view aggJoin9171373458075254335 as (
with aggView984924381026463507 as (select v37, MIN(v38) as v51 from aggJoin6152061834692567320 group by v37)
select v37, v32, v51 from aggJoin7615573030733841760 join aggView984924381026463507 using(v37));
create or replace view aggJoin4769012109455699059 as (
with aggView5585282874632411553 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin9171373458075254335 group by v37,v51)
select v49 as v49, v51, v50 from aggJoin1288101006449354024 join aggView5585282874632411553 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4769012109455699059;
