create or replace view aggView1984214581732181860 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin6503994922813522594 as (
with aggView7448352455320864024 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7448352455320864024 where cc.status_id=aggView7448352455320864024.v7);
create or replace view aggJoin474535603119331171 as (
with aggView8151662008474522528 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin6503994922813522594 join aggView8151662008474522528 using(v5));
create or replace view aggJoin8204006584965283688 as (
with aggView5783379588541428237 as (select v45 from aggJoin474535603119331171 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49 from title as t, aggView5783379588541428237 where t.id=aggView5783379588541428237.v45 and production_year>2000);
create or replace view aggJoin7446189344416040824 as (
with aggView3080062576210595823 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3080062576210595823 where mi_idx.info_type_id=aggView3080062576210595823.v20 and info<'8.5');
create or replace view aggView2450424983810229821 as select v40, v45 from aggJoin7446189344416040824 group by v40,v45;
create or replace view aggJoin2721593560910820539 as (
with aggView3426260765018749957 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49 from aggJoin8204006584965283688 join aggView3426260765018749957 using(v25));
create or replace view aggView8770097603507303467 as select v45, v46 from aggJoin2721593560910820539 group by v45,v46;
create or replace view aggJoin1384017614814690196 as (
with aggView7608635106285908683 as (select v45, MIN(v40) as v58 from aggView2450424983810229821 group by v45)
select v45, v46, v58 from aggView8770097603507303467 join aggView7608635106285908683 using(v45));
create or replace view aggJoin7726154665156941145 as (
with aggView1548379915509611270 as (select v9, MIN(v10) as v57 from aggView1984214581732181860 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView1548379915509611270 where mc.company_id=aggView1548379915509611270.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2405855480092093751 as (
with aggView5837542464093553478 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView5837542464093553478 where mk.keyword_id=aggView5837542464093553478.v22);
create or replace view aggJoin5083916283812063019 as (
with aggView6637750564598015653 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView6637750564598015653 where mi.info_type_id=aggView6637750564598015653.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3606686346590466685 as (
with aggView1637705019082945040 as (select v45 from aggJoin2405855480092093751 group by v45)
select v45, v35 from aggJoin5083916283812063019 join aggView1637705019082945040 using(v45));
create or replace view aggJoin7025905126439452866 as (
with aggView2058895162873284183 as (select v45 from aggJoin3606686346590466685 group by v45)
select v45, v16, v31, v57 as v57 from aggJoin7726154665156941145 join aggView2058895162873284183 using(v45));
create or replace view aggJoin6000128099624839110 as (
with aggView222953638494525595 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin7025905126439452866 join aggView222953638494525595 using(v16));
create or replace view aggJoin2560640423612269317 as (
with aggView467846705368037619 as (select v45, MIN(v57) as v57 from aggJoin6000128099624839110 group by v45,v57)
select v46, v58 as v58, v57 from aggJoin1384017614814690196 join aggView467846705368037619 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin2560640423612269317;
