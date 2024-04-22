create or replace view aggJoin4321593793626622189 as (
with aggView4739971661822408320 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4739971661822408320 where mc.company_id=aggView4739971661822408320.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3245098940054259988 as (
with aggView3186752389452551061 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3186752389452551061 where mi_idx.info_type_id=aggView3186752389452551061.v20 and info>'6.5');
create or replace view aggJoin7915868203278358510 as (
with aggView6770074881778845410 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView6770074881778845410 where cc.status_id=aggView6770074881778845410.v7);
create or replace view aggJoin471245449524523786 as (
with aggView5432183050243703250 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4321593793626622189 join aggView5432183050243703250 using(v16));
create or replace view aggJoin4192248180717220239 as (
with aggView1022008695104160233 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1022008695104160233 where t.kind_id=aggView1022008695104160233.v25 and production_year>2005);
create or replace view aggJoin7568795792685418173 as (
with aggView6371591663610994887 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin7915868203278358510 join aggView6371591663610994887 using(v5));
create or replace view aggJoin9210767346002557453 as (
with aggView233808939752076663 as (select v45, MIN(v57) as v57 from aggJoin471245449524523786 group by v45,v57)
select movie_id as v45, keyword_id as v22, v57 from movie_keyword as mk, aggView233808939752076663 where mk.movie_id=aggView233808939752076663.v45);
create or replace view aggJoin3555025160270869909 as (
with aggView885979695315629832 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView885979695315629832 where mi.info_type_id=aggView885979695315629832.v18 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1806043895183009319 as (
with aggView8412410503981065303 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45, v57 from aggJoin9210767346002557453 join aggView8412410503981065303 using(v22));
create or replace view aggJoin6403108238209196081 as (
with aggView5494484543928230754 as (select v45 from aggJoin7568795792685418173 group by v45)
select v45, v40 from aggJoin3245098940054259988 join aggView5494484543928230754 using(v45));
create or replace view aggJoin14559211621815 as (
with aggView4648424484948630934 as (select v45, MIN(v40) as v58 from aggJoin6403108238209196081 group by v45)
select v45, v46, v49, v58 from aggJoin4192248180717220239 join aggView4648424484948630934 using(v45));
create or replace view aggJoin1380423371822116856 as (
with aggView1708464359247143995 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin14559211621815 group by v45,v58)
select v45, v35, v58, v59 from aggJoin3555025160270869909 join aggView1708464359247143995 using(v45));
create or replace view aggJoin2383364805195963437 as (
with aggView7986253672040161498 as (select v45, MIN(v58) as v58, MIN(v59) as v59 from aggJoin1380423371822116856 group by v45,v59,v58)
select v57 as v57, v58, v59 from aggJoin1806043895183009319 join aggView7986253672040161498 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin2383364805195963437;
