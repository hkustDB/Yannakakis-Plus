create or replace view aggView3050076658457771105 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin3874907494503490471 as (
with aggView549918412334736889 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView549918412334736889 where mk.keyword_id=aggView549918412334736889.v35);
create or replace view aggJoin6519137323998476236 as (
with aggView7147035791669366295 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView7147035791669366295 where cc.subject_id=aggView7147035791669366295.v5);
create or replace view aggJoin6059471732043411601 as (
with aggView1592168005551023413 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin6519137323998476236 join aggView1592168005551023413 using(v7));
create or replace view aggJoin545496123370996707 as (
with aggView176616543307313050 as (select v37 from aggJoin6059471732043411601 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView176616543307313050 where t.id=aggView176616543307313050.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggJoin2330021894218973498 as (
with aggView2916097722897478248 as (select v37 from aggJoin3874907494503490471 group by v37)
select v37, v41, v44 from aggJoin545496123370996707 join aggView2916097722897478248 using(v37));
create or replace view aggView34960204676860740 as select v37, v41 from aggJoin2330021894218973498 group by v37,v41;
create or replace view aggJoin2346371536690564429 as (
with aggView5870150282157193636 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView5870150282157193636 where ml.link_type_id=aggView5870150282157193636.v21);
create or replace view aggJoin6250460391900389816 as (
with aggView347948238155592306 as (select v25, MIN(v10) as v52 from aggView3050076658457771105 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView347948238155592306 where mc.company_id=aggView347948238155592306.v25);
create or replace view aggJoin2664603064401256772 as (
with aggView4633765351571653981 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37, v26, v52 as v52 from aggJoin6250460391900389816 join aggView4633765351571653981 using(v37));
create or replace view aggJoin2259429470557052399 as (
with aggView4365455853657863354 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin2664603064401256772 join aggView4365455853657863354 using(v26));
create or replace view aggJoin654579204260134827 as (
with aggView2189438748691813173 as (select v37, MIN(v52) as v52 from aggJoin2259429470557052399 group by v37,v52)
select v37, v53 as v53, v52 from aggJoin2346371536690564429 join aggView2189438748691813173 using(v37));
create or replace view aggJoin9184238281902444860 as (
with aggView9173698824250220483 as (select v37, MIN(v53) as v53, MIN(v52) as v52 from aggJoin654579204260134827 group by v37,v52,v53)
select v41, v53, v52 from aggView34960204676860740 join aggView9173698824250220483 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v41) as v54 from aggJoin9184238281902444860;
