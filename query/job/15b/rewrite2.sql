create or replace view aggJoin7593046200357024102 as (
with aggView3929251549346250208 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView3929251549346250208 where mi.info_type_id=aggView3929251549346250208.v22 and note LIKE '%internet%');
create or replace view aggJoin6513626757115522088 as (
with aggView5689498505611817024 as (select v40, v35 from aggJoin7593046200357024102 group by v40,v35)
select v40, v35 from aggView5689498505611817024 where v35 LIKE 'USA:% 200%');
create or replace view aggJoin514420422912904122 as (
with aggView6794044115533660837 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView6794044115533660837 where mc.company_id=aggView6794044115533660837.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin5937060015287050335 as (
with aggView6893251397230541472 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin514420422912904122 join aggView6893251397230541472 using(v20));
create or replace view aggJoin886978085562647613 as (
with aggView6021723599547519236 as (select v40 from aggJoin5937060015287050335 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView6021723599547519236 where t.id=aggView6021723599547519236.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin1195490723734878089 as (
with aggView7239326339286735043 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView7239326339286735043 where mk.keyword_id=aggView7239326339286735043.v24);
create or replace view aggJoin104021677774644420 as (
with aggView848674615949380472 as (select v40 from aggJoin1195490723734878089 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView848674615949380472 where aka_t.movie_id=aggView848674615949380472.v40);
create or replace view aggJoin6790197807105376264 as (
with aggView6461424683609805652 as (select v40 from aggJoin104021677774644420 group by v40)
select v40, v41, v44 from aggJoin886978085562647613 join aggView6461424683609805652 using(v40));
create or replace view aggView2892826823847970454 as select v40, v41 from aggJoin6790197807105376264 group by v40,v41;
create or replace view aggJoin2765331276654198267 as (
with aggView5809018196781364523 as (select v40, MIN(v35) as v52 from aggJoin6513626757115522088 group by v40)
select v41, v52 from aggView2892826823847970454 join aggView5809018196781364523 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin2765331276654198267;
