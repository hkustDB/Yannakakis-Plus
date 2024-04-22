create or replace view aggJoin7096749770946676288 as (
with aggView521440361364066131 as (select id as v37, title as v54 from title as t where production_year>=1950 and production_year<=2010)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView521440361364066131 where ml.movie_id=aggView521440361364066131.v37);
create or replace view aggJoin1126030213857354927 as (
with aggView2158600702611935436 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select v37, v54, v53 from aggJoin7096749770946676288 join aggView2158600702611935436 using(v21));
create or replace view aggJoin231077481527779987 as (
with aggView4565116036973386785 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView4565116036973386785 where mc.company_id=aggView4565116036973386785.v25);
create or replace view aggJoin8755920429865506501 as (
with aggView1497534012717210487 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView1497534012717210487 where mk.keyword_id=aggView1497534012717210487.v35);
create or replace view aggJoin3501050266646353578 as (
with aggView4652993618360241397 as (select v37, MIN(v54) as v54, MIN(v53) as v53 from aggJoin1126030213857354927 group by v37,v54,v53)
select v37, v26, v52 as v52, v54, v53 from aggJoin231077481527779987 join aggView4652993618360241397 using(v37));
create or replace view aggJoin5975824418655728645 as (
with aggView7531645288706165241 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView7531645288706165241 where cc.subject_id=aggView7531645288706165241.v5);
create or replace view aggJoin3006098279761989054 as (
with aggView3396648701124050110 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin5975824418655728645 join aggView3396648701124050110 using(v7));
create or replace view aggJoin605158064800955622 as (
with aggView5190947559962576965 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37, v26, v52 as v52, v54 as v54, v53 as v53 from aggJoin3501050266646353578 join aggView5190947559962576965 using(v37));
create or replace view aggJoin1500194773766289898 as (
with aggView4946425509097775858 as (select v37 from aggJoin3006098279761989054 group by v37)
select v37, v26, v52 as v52, v54 as v54, v53 as v53 from aggJoin605158064800955622 join aggView4946425509097775858 using(v37));
create or replace view aggJoin6279895531758720477 as (
with aggView6449088492110456625 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54, v53 from aggJoin1500194773766289898 join aggView6449088492110456625 using(v26));
create or replace view aggJoin7984066039420127890 as (
with aggView2699292981820929757 as (select v37, MIN(v52) as v52, MIN(v54) as v54, MIN(v53) as v53 from aggJoin6279895531758720477 group by v37,v54,v52,v53)
select v52, v54, v53 from aggJoin8755920429865506501 join aggView2699292981820929757 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin7984066039420127890;
