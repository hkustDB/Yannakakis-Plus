create or replace view aggView5047424480614375693 as select id as v29, title as v33 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggView5570547025277767672 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin6405332240763747573 as (
with aggView660155635425815360 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView660155635425815360 where ml.link_type_id=aggView660155635425815360.v13);
create or replace view aggJoin279264749213291083 as (
with aggView8342027806635025070 as (select v29, MIN(v33) as v46 from aggView5047424480614375693 group by v29)
select v29, v45 as v45, v46 from aggJoin6405332240763747573 join aggView8342027806635025070 using(v29));
create or replace view aggJoin3479547740881359920 as (
with aggView1815313072369018624 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView1815313072369018624 where mk.keyword_id=aggView1815313072369018624.v27);
create or replace view aggJoin3776939583826024450 as (
with aggView3815562403977550147 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29 from aggJoin3479547740881359920 join aggView3815562403977550147 using(v29));
create or replace view aggJoin5460009731800790279 as (
with aggView7447868582618726488 as (select v29 from aggJoin3776939583826024450 group by v29)
select v29, v45 as v45, v46 as v46 from aggJoin279264749213291083 join aggView7447868582618726488 using(v29));
create or replace view aggJoin7838440006944467636 as (
with aggView2741300506651141448 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin5460009731800790279 group by v29,v46,v45)
select company_id as v17, company_type_id as v18, v45, v46 from movie_companies as mc, aggView2741300506651141448 where mc.movie_id=aggView2741300506651141448.v29);
create or replace view aggJoin6566396457183792032 as (
with aggView3424669371462127433 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v45, v46 from aggJoin7838440006944467636 join aggView3424669371462127433 using(v18));
create or replace view aggJoin3492659512402684196 as (
with aggView2987156802921060500 as (select v17, MIN(v45) as v45, MIN(v46) as v46 from aggJoin6566396457183792032 group by v17,v46,v45)
select v2, v45, v46 from aggView5570547025277767672 join aggView2987156802921060500 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin3492659512402684196;
