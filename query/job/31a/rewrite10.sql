create or replace view aggJoin382401018463825902 as (
with aggView3925805977542821486 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView3925805977542821486 where ci.person_id=aggView3925805977542821486.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3343703215946187720 as (
with aggView6139903495958305398 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView6139903495958305398 where mi_idx.info_type_id=aggView6139903495958305398.v17);
create or replace view aggJoin7202073932735179702 as (
with aggView5471330197293117996 as (select v49, MIN(v35) as v62 from aggJoin3343703215946187720 group by v49)
select movie_id as v49, info_type_id as v15, info as v30, v62 from movie_info as mi, aggView5471330197293117996 where mi.movie_id=aggView5471330197293117996.v49 and info IN ('Horror','Thriller'));
create or replace view aggJoin2940385827726667850 as (
with aggView5276820718707722212 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView5276820718707722212 where mk.keyword_id=aggView5276820718707722212.v19);
create or replace view aggJoin8972859780428427960 as (
with aggView7683037547857028512 as (select v49, MIN(v63) as v63 from aggJoin382401018463825902 group by v49,v63)
select id as v49, title as v50, v63 from title as t, aggView7683037547857028512 where t.id=aggView7683037547857028512.v49);
create or replace view aggJoin6053013477634955351 as (
with aggView4513490305994102604 as (select v49, MIN(v63) as v63, MIN(v50) as v64 from aggJoin8972859780428427960 group by v49,v63)
select v49, v63, v64 from aggJoin2940385827726667850 join aggView4513490305994102604 using(v49));
create or replace view aggJoin2379301467102855244 as (
with aggView316122210092884349 as (select id as v15 from info_type as it1 where info= 'genres')
select v49, v30, v62 from aggJoin7202073932735179702 join aggView316122210092884349 using(v15));
create or replace view aggJoin4529865486150680735 as (
with aggView6568325979321852478 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView6568325979321852478 where mc.company_id=aggView6568325979321852478.v8);
create or replace view aggJoin4795474340044751139 as (
with aggView2441318429549987370 as (select v49 from aggJoin4529865486150680735 group by v49)
select v49, v30, v62 as v62 from aggJoin2379301467102855244 join aggView2441318429549987370 using(v49));
create or replace view aggJoin2774274529482158355 as (
with aggView8339167676283737661 as (select v49, MIN(v62) as v62, MIN(v30) as v61 from aggJoin4795474340044751139 group by v49,v62)
select v63 as v63, v64 as v64, v62, v61 from aggJoin6053013477634955351 join aggView8339167676283737661 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin2774274529482158355;
