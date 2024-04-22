create or replace view aggView5402623727714707451 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggView5293757699988659805 as select id as v37, title as v41 from title as t where production_year>=1950 and production_year<=2010;
create or replace view aggJoin6040960358454368941 as (
with aggView3042524820792898669 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView3042524820792898669 where ml.link_type_id=aggView3042524820792898669.v21);
create or replace view aggJoin8315035605004972706 as (
with aggView4494741566273597329 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView4494741566273597329 where mk.keyword_id=aggView4494741566273597329.v35);
create or replace view aggJoin353677240154398718 as (
with aggView5203605128390542243 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView5203605128390542243 where cc.subject_id=aggView5203605128390542243.v5);
create or replace view aggJoin906633841131536681 as (
with aggView7387378403632581243 as (select v37 from aggJoin8315035605004972706 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView7387378403632581243 where mi.movie_id=aggView7387378403632581243.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin5738836763562502787 as (
with aggView5787255986621180271 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin353677240154398718 join aggView5787255986621180271 using(v7));
create or replace view aggJoin3404709955227183275 as (
with aggView7904694088132562030 as (select v37 from aggJoin5738836763562502787 group by v37)
select v37, v53 as v53 from aggJoin6040960358454368941 join aggView7904694088132562030 using(v37));
create or replace view aggJoin3838527468625121924 as (
with aggView5434631184723261883 as (select v37 from aggJoin906633841131536681 group by v37)
select v37, v53 as v53 from aggJoin3404709955227183275 join aggView5434631184723261883 using(v37));
create or replace view aggJoin6280551392667811212 as (
with aggView293374261754211112 as (select v37, MIN(v53) as v53 from aggJoin3838527468625121924 group by v37,v53)
select v37, v41, v53 from aggView5293757699988659805 join aggView293374261754211112 using(v37));
create or replace view aggJoin1731955511570018132 as (
with aggView8288150656538271530 as (select v37, MIN(v53) as v53, MIN(v41) as v54 from aggJoin6280551392667811212 group by v37,v53)
select company_id as v25, company_type_id as v26, v53, v54 from movie_companies as mc, aggView8288150656538271530 where mc.movie_id=aggView8288150656538271530.v37);
create or replace view aggJoin137173209981737055 as (
with aggView323255542823365595 as (select id as v26 from company_type as ct where kind= 'production companies')
select v25, v53, v54 from aggJoin1731955511570018132 join aggView323255542823365595 using(v26));
create or replace view aggJoin2387171048088043610 as (
with aggView3909009005742953896 as (select v25, MIN(v53) as v53, MIN(v54) as v54 from aggJoin137173209981737055 group by v25,v54,v53)
select v10, v53, v54 from aggView5402623727714707451 join aggView3909009005742953896 using(v25));
select MIN(v10) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin2387171048088043610;
