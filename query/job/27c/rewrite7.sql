create or replace view aggJoin7639253360652389077 as (
with aggView1993106099945325906 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView1993106099945325906 where mc.company_id=aggView1993106099945325906.v25);
create or replace view aggJoin8419659716271135285 as (
with aggView8049311711924577177 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView8049311711924577177 where ml.link_type_id=aggView8049311711924577177.v21);
create or replace view aggJoin945498424039520098 as (
with aggView2444160403112796686 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView2444160403112796686 where mk.keyword_id=aggView2444160403112796686.v35);
create or replace view aggJoin7740522020969122328 as (
with aggView2253809430261473773 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView2253809430261473773 where cc.subject_id=aggView2253809430261473773.v5);
create or replace view aggJoin3467923013996654634 as (
with aggView479374016760761931 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37 from aggJoin945498424039520098 join aggView479374016760761931 using(v37));
create or replace view aggJoin4661367930305999347 as (
with aggView9113440171806810477 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin7740522020969122328 join aggView9113440171806810477 using(v7));
create or replace view aggJoin5324885527138831493 as (
with aggView6667008369775173782 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin7639253360652389077 join aggView6667008369775173782 using(v26));
create or replace view aggJoin2789105343798837653 as (
with aggView7084435786744097241 as (select v37, MIN(v52) as v52 from aggJoin5324885527138831493 group by v37,v52)
select id as v37, title as v41, production_year as v44, v52 from title as t, aggView7084435786744097241 where t.id=aggView7084435786744097241.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggJoin2527820509682313487 as (
with aggView9195548937967586325 as (select v37, MIN(v52) as v52, MIN(v41) as v54 from aggJoin2789105343798837653 group by v37,v52)
select v37, v52, v54 from aggJoin4661367930305999347 join aggView9195548937967586325 using(v37));
create or replace view aggJoin7118780228008255642 as (
with aggView5411846199246655876 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2527820509682313487 group by v37,v54,v52)
select v37, v53 as v53, v52, v54 from aggJoin8419659716271135285 join aggView5411846199246655876 using(v37));
create or replace view aggJoin6222467901703438020 as (
with aggView2250936560260341967 as (select v37, MIN(v53) as v53, MIN(v52) as v52, MIN(v54) as v54 from aggJoin7118780228008255642 group by v37,v54,v52,v53)
select v53, v52, v54 from aggJoin3467923013996654634 join aggView2250936560260341967 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin6222467901703438020;
