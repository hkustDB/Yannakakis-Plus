create or replace view aggJoin950638384718242016 as (
with aggView488560994070113813 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView488560994070113813 where mc.company_id=aggView488560994070113813.v1);
create or replace view aggJoin682889385679186396 as (
with aggView9001160031662881989 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView9001160031662881989 where mi.info_type_id=aggView9001160031662881989.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7434717418294443397 as (
with aggView8829930798483905159 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView8829930798483905159 where mk.keyword_id=aggView8829930798483905159.v14);
create or replace view aggJoin7127105505605619314 as (
with aggView484583973247776564 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin950638384718242016 join aggView484583973247776564 using(v8));
create or replace view aggJoin4685884128236081474 as (
with aggView4226587642215647307 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView4226587642215647307 where mi_idx.info_type_id=aggView4226587642215647307.v12 and info<'8.5');
create or replace view aggJoin776215629090785900 as (
with aggView8815604207100158079 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView8815604207100158079 where t.kind_id=aggView8815604207100158079.v17 and production_year>2005);
create or replace view aggJoin8355963543999879121 as (
with aggView3309663639785584663 as (select v37, MIN(v38) as v51 from aggJoin776215629090785900 group by v37)
select v37, v49 as v49, v51 from aggJoin7127105505605619314 join aggView3309663639785584663 using(v37));
create or replace view aggJoin6297127476180212812 as (
with aggView3549927650869833679 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin8355963543999879121 group by v37,v51,v49)
select v37, v32, v49, v51 from aggJoin4685884128236081474 join aggView3549927650869833679 using(v37));
create or replace view aggJoin408832093253579395 as (
with aggView5175526972873188758 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin6297127476180212812 group by v37,v51,v49)
select v37, v27, v49, v51, v50 from aggJoin682889385679186396 join aggView5175526972873188758 using(v37));
create or replace view aggJoin8717598529584452442 as (
with aggView1447637679434397294 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v50) as v50 from aggJoin408832093253579395 group by v37,v51,v50,v49)
select v49, v51, v50 from aggJoin7434717418294443397 join aggView1447637679434397294 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8717598529584452442;
