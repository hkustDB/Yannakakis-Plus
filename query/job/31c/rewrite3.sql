create or replace view aggJoin2489436180523558549 as (
with aggView8452069926136795021 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8452069926136795021 where mk.keyword_id=aggView8452069926136795021.v19);
create or replace view aggJoin7188195971240538409 as (
with aggView3482463084962811802 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView3482463084962811802 where mc.company_id=aggView3482463084962811802.v8);
create or replace view aggJoin4920393598423671654 as (
with aggView7166292049422771626 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView7166292049422771626 where mi_idx.info_type_id=aggView7166292049422771626.v17);
create or replace view aggJoin1938980724977507711 as (
with aggView3585338362901400996 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView3585338362901400996 where mi.info_type_id=aggView3585338362901400996.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5773589852008011458 as (
with aggView8204390634201072895 as (select v49 from aggJoin2489436180523558549 group by v49)
select v49 from aggJoin7188195971240538409 join aggView8204390634201072895 using(v49));
create or replace view aggJoin2205881516278101044 as (
with aggView5415931315062968887 as (select v49 from aggJoin5773589852008011458 group by v49)
select id as v49, title as v50 from title as t, aggView5415931315062968887 where t.id=aggView5415931315062968887.v49);
create or replace view aggJoin7933451191765123168 as (
with aggView2381957973956351339 as (select v49, MIN(v50) as v64 from aggJoin2205881516278101044 group by v49)
select v49, v35, v64 from aggJoin4920393598423671654 join aggView2381957973956351339 using(v49));
create or replace view aggJoin7689788185130819373 as (
with aggView938014784848612691 as (select v49, MIN(v64) as v64, MIN(v35) as v62 from aggJoin7933451191765123168 group by v49,v64)
select v49, v30, v64, v62 from aggJoin1938980724977507711 join aggView938014784848612691 using(v49));
create or replace view aggJoin5132873313526279473 as (
with aggView3973490792530703579 as (select v49, MIN(v64) as v64, MIN(v62) as v62, MIN(v30) as v61 from aggJoin7689788185130819373 group by v49,v64,v62)
select person_id as v40, note as v5, v64, v62, v61 from cast_info as ci, aggView3973490792530703579 where ci.movie_id=aggView3973490792530703579.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4172314764242252970 as (
with aggView3122551585062790646 as (select v40, MIN(v64) as v64, MIN(v62) as v62, MIN(v61) as v61 from aggJoin5132873313526279473 group by v40,v64,v61,v62)
select name as v41, v64, v62, v61 from name as n, aggView3122551585062790646 where n.id=aggView3122551585062790646.v40);
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin4172314764242252970;
