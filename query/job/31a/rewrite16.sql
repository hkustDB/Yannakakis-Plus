create or replace view aggJoin3067515504199585393 as (
with aggView4669641762558416709 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView4669641762558416709 where ci.person_id=aggView4669641762558416709.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3773905616312659580 as (
with aggView4703553994658937820 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4703553994658937820 where mi_idx.info_type_id=aggView4703553994658937820.v17);
create or replace view aggJoin5008856528981863961 as (
with aggView514569042474920772 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView514569042474920772 where mk.keyword_id=aggView514569042474920772.v19);
create or replace view aggJoin1032738211745813303 as (
with aggView8650619972452476067 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView8650619972452476067 where mi.info_type_id=aggView8650619972452476067.v15 and info IN ('Horror','Thriller'));
create or replace view aggJoin6612956647455637250 as (
with aggView7932063887364669804 as (select v49, MIN(v30) as v61 from aggJoin1032738211745813303 group by v49)
select v49, v35, v61 from aggJoin3773905616312659580 join aggView7932063887364669804 using(v49));
create or replace view aggJoin5663457601866778293 as (
with aggView3445426521422844595 as (select v49, MIN(v61) as v61, MIN(v35) as v62 from aggJoin6612956647455637250 group by v49,v61)
select v49, v5, v63 as v63, v61, v62 from aggJoin3067515504199585393 join aggView3445426521422844595 using(v49));
create or replace view aggJoin3146186796599567465 as (
with aggView6368639185392527127 as (select v49, MIN(v63) as v63, MIN(v61) as v61, MIN(v62) as v62 from aggJoin5663457601866778293 group by v49,v61,v63,v62)
select id as v49, title as v50, v63, v61, v62 from title as t, aggView6368639185392527127 where t.id=aggView6368639185392527127.v49);
create or replace view aggJoin1619177998423236245 as (
with aggView6371764075740039386 as (select v49, MIN(v63) as v63, MIN(v61) as v61, MIN(v62) as v62, MIN(v50) as v64 from aggJoin3146186796599567465 group by v49,v61,v63,v62)
select v49, v63, v61, v62, v64 from aggJoin5008856528981863961 join aggView6371764075740039386 using(v49));
create or replace view aggJoin2755468300741773488 as (
with aggView2556440950434125281 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView2556440950434125281 where mc.company_id=aggView2556440950434125281.v8);
create or replace view aggJoin2648563536457001367 as (
with aggView6947354769151263227 as (select v49 from aggJoin2755468300741773488 group by v49)
select v63 as v63, v61 as v61, v62 as v62, v64 as v64 from aggJoin1619177998423236245 join aggView6947354769151263227 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin2648563536457001367;
