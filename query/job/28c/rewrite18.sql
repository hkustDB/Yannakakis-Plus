create or replace view aggJoin9151655740859221719 as (
with aggView8210624638346027067 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView8210624638346027067 where mc.company_id=aggView8210624638346027067.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4249301791220970068 as (
with aggView8747398642406089873 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView8747398642406089873 where t.kind_id=aggView8747398642406089873.v25 and production_year>2005);
create or replace view aggJoin6621207728197233079 as (
with aggView5222254581422436517 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView5222254581422436517 where cc.subject_id=aggView5222254581422436517.v5);
create or replace view aggJoin925356380163133512 as (
with aggView9182660549287904206 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin9151655740859221719 join aggView9182660549287904206 using(v16));
create or replace view aggJoin4415696261296938317 as (
with aggView1155699177141010397 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1155699177141010397 where mi_idx.info_type_id=aggView1155699177141010397.v20 and info<'8.5');
create or replace view aggJoin4757317492140568383 as (
with aggView2507748903815487350 as (select v45, MIN(v40) as v58 from aggJoin4415696261296938317 group by v45)
select v45, v31, v57 as v57, v58 from aggJoin925356380163133512 join aggView2507748903815487350 using(v45));
create or replace view aggJoin2206173116247054582 as (
with aggView7564879255910004379 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin6621207728197233079 join aggView7564879255910004379 using(v7));
create or replace view aggJoin9185678074304184101 as (
with aggView5898288250140076241 as (select v45 from aggJoin2206173116247054582 group by v45)
select v45, v31, v57 as v57, v58 as v58 from aggJoin4757317492140568383 join aggView5898288250140076241 using(v45));
create or replace view aggJoin5838169053575984655 as (
with aggView5437165005582300495 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView5437165005582300495 where mk.keyword_id=aggView5437165005582300495.v22);
create or replace view aggJoin1770426987826946404 as (
with aggView9006193402672593093 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView9006193402672593093 where mi.info_type_id=aggView9006193402672593093.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1690926555788569780 as (
with aggView4603377015700572029 as (select v45 from aggJoin1770426987826946404 group by v45)
select v45, v31, v57 as v57, v58 as v58 from aggJoin9185678074304184101 join aggView4603377015700572029 using(v45));
create or replace view aggJoin9169189948738901211 as (
with aggView2421818681931778381 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin1690926555788569780 group by v45,v57,v58)
select v45, v46, v49, v57, v58 from aggJoin4249301791220970068 join aggView2421818681931778381 using(v45));
create or replace view aggJoin344957600163017052 as (
with aggView4263215340596263308 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v46) as v59 from aggJoin9169189948738901211 group by v45,v57,v58)
select v57, v58, v59 from aggJoin5838169053575984655 join aggView4263215340596263308 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin344957600163017052;
