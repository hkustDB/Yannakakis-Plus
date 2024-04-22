create or replace view aggJoin382515061551698877 as (
with aggView8901781992139717921 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView8901781992139717921 where mk.keyword_id=aggView8901781992139717921.v24);
create or replace view aggJoin1508399162604410365 as (
with aggView4918681334117942352 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView4918681334117942352 where mc.company_id=aggView4918681334117942352.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin5246979983268427571 as (
with aggView3378645644522900209 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin382515061551698877 join aggView3378645644522900209 using(v40));
create or replace view aggJoin6132032268510442214 as (
with aggView4266859443102864710 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin1508399162604410365 join aggView4266859443102864710 using(v20));
create or replace view aggJoin5819309213680949727 as (
with aggView8949930378157975456 as (select v40 from aggJoin6132032268510442214 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView8949930378157975456 where t.id=aggView8949930378157975456.v40 and production_year>2000);
create or replace view aggView9027637415856102883 as select v41, v40 from aggJoin5819309213680949727 group by v41,v40;
create or replace view aggJoin475578917495673909 as (
with aggView6762387030957507734 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView6762387030957507734 where mi.info_type_id=aggView6762387030957507734.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin8932320343001860218 as (
with aggView7113479718480479847 as (select v40 from aggJoin5246979983268427571 group by v40)
select v40, v35, v36 from aggJoin475578917495673909 join aggView7113479718480479847 using(v40));
create or replace view aggView7575277050709590037 as select v35, v40 from aggJoin8932320343001860218 group by v35,v40;
create or replace view aggJoin3191320236242019621 as (
with aggView4233646068664252822 as (select v40, MIN(v41) as v53 from aggView9027637415856102883 group by v40)
select v35, v53 from aggView7575277050709590037 join aggView4233646068664252822 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin3191320236242019621;
