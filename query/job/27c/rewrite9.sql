create or replace view aggJoin7165970305845542893 as (
with aggView607678872817998989 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView607678872817998989 where mc.company_id=aggView607678872817998989.v25);
create or replace view aggJoin253753319572937486 as (
with aggView6300080686423026423 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView6300080686423026423 where ml.link_type_id=aggView6300080686423026423.v21);
create or replace view aggJoin4066365427589808882 as (
with aggView2789936635690697576 as (select id as v37, title as v54 from title as t where production_year>=1950 and production_year<=2010)
select movie_id as v37, info as v31, v54 from movie_info as mi, aggView2789936635690697576 where mi.movie_id=aggView2789936635690697576.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin8408249194565321576 as (
with aggView5936237764773920628 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView5936237764773920628 where mk.keyword_id=aggView5936237764773920628.v35);
create or replace view aggJoin1389422998756690906 as (
with aggView5726715775904644759 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView5726715775904644759 where cc.subject_id=aggView5726715775904644759.v5);
create or replace view aggJoin2315865225395381717 as (
with aggView7564632376204153589 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin1389422998756690906 join aggView7564632376204153589 using(v7));
create or replace view aggJoin5746688097696686074 as (
with aggView4555291516978776745 as (select v37, MIN(v53) as v53 from aggJoin253753319572937486 group by v37,v53)
select v37, v53 from aggJoin8408249194565321576 join aggView4555291516978776745 using(v37));
create or replace view aggJoin6961672084758579053 as (
with aggView5484124882860206845 as (select v37 from aggJoin2315865225395381717 group by v37)
select v37, v31, v54 as v54 from aggJoin4066365427589808882 join aggView5484124882860206845 using(v37));
create or replace view aggJoin794532973163802166 as (
with aggView4657544107314466057 as (select v37, MIN(v54) as v54 from aggJoin6961672084758579053 group by v37,v54)
select v37, v26, v52 as v52, v54 from aggJoin7165970305845542893 join aggView4657544107314466057 using(v37));
create or replace view aggJoin3501935126571616541 as (
with aggView3438237799972917288 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54 from aggJoin794532973163802166 join aggView3438237799972917288 using(v26));
create or replace view aggJoin9166299000824314731 as (
with aggView772756905532250438 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin3501935126571616541 group by v37,v54,v52)
select v53 as v53, v52, v54 from aggJoin5746688097696686074 join aggView772756905532250438 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin9166299000824314731;
