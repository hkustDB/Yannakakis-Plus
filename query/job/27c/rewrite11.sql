create or replace view aggJoin8977837279488097233 as (
with aggView3763530479942578145 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView3763530479942578145 where mc.company_id=aggView3763530479942578145.v25);
create or replace view aggJoin3731477271311352484 as (
with aggView8867938486612431961 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView8867938486612431961 where ml.link_type_id=aggView8867938486612431961.v21);
create or replace view aggJoin1993147138944972836 as (
with aggView1215137089371409253 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView1215137089371409253 where mk.keyword_id=aggView1215137089371409253.v35);
create or replace view aggJoin2777999443045173030 as (
with aggView2931772693967744016 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView2931772693967744016 where cc.subject_id=aggView2931772693967744016.v5);
create or replace view aggJoin7086645402065508154 as (
with aggView6201382832617564406 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin2777999443045173030 join aggView6201382832617564406 using(v7));
create or replace view aggJoin7098600761173440035 as (
with aggView5256507983505215269 as (select v37 from aggJoin7086645402065508154 group by v37)
select v37, v26, v52 as v52 from aggJoin8977837279488097233 join aggView5256507983505215269 using(v37));
create or replace view aggJoin3256605314806660539 as (
with aggView7480928577512840534 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin7098600761173440035 join aggView7480928577512840534 using(v26));
create or replace view aggJoin5350505641511366994 as (
with aggView2099424487468159688 as (select v37, MIN(v52) as v52 from aggJoin3256605314806660539 group by v37,v52)
select id as v37, title as v41, production_year as v44, v52 from title as t, aggView2099424487468159688 where t.id=aggView2099424487468159688.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggJoin8328705645907601437 as (
with aggView6431040595985631252 as (select v37, MIN(v52) as v52, MIN(v41) as v54 from aggJoin5350505641511366994 group by v37,v52)
select movie_id as v37, info as v31, v52, v54 from movie_info as mi, aggView6431040595985631252 where mi.movie_id=aggView6431040595985631252.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin7988187487258376395 as (
with aggView3943688655683030848 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin8328705645907601437 group by v37,v54,v52)
select v37, v53 as v53, v52, v54 from aggJoin3731477271311352484 join aggView3943688655683030848 using(v37));
create or replace view aggJoin7754201818247997086 as (
with aggView8226119280838540445 as (select v37, MIN(v53) as v53, MIN(v52) as v52, MIN(v54) as v54 from aggJoin7988187487258376395 group by v37,v54,v52,v53)
select v53, v52, v54 from aggJoin1993147138944972836 join aggView8226119280838540445 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin7754201818247997086;
