create or replace view aggJoin4978028128470425622 as (
with aggView3990298543077054676 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView3990298543077054676 where ci.person_id=aggView3990298543077054676.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7562485169157856882 as (
with aggView515059368828458305 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView515059368828458305 where mi_idx.info_type_id=aggView515059368828458305.v10);
create or replace view aggJoin2284220093570692809 as (
with aggView148255792079217764 as (select v37, MIN(v23) as v50 from aggJoin7562485169157856882 group by v37)
select id as v37, title as v38, v50 from title as t, aggView148255792079217764 where t.id=aggView148255792079217764.v37);
create or replace view aggJoin2690250577224568042 as (
with aggView1650842697435550591 as (select v37, MIN(v50) as v50, MIN(v38) as v52 from aggJoin2284220093570692809 group by v37,v50)
select movie_id as v37, info_type_id as v8, info as v18, v50, v52 from movie_info as mi, aggView1650842697435550591 where mi.movie_id=aggView1650842697435550591.v37 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin8142785354498080623 as (
with aggView439853049391909429 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v50, v52 from aggJoin2690250577224568042 join aggView439853049391909429 using(v8));
create or replace view aggJoin5454289537215194820 as (
with aggView2753559463739028249 as (select v37, MIN(v50) as v50, MIN(v52) as v52, MIN(v18) as v49 from aggJoin8142785354498080623 group by v37,v50,v52)
select movie_id as v37, keyword_id as v12, v50, v52, v49 from movie_keyword as mk, aggView2753559463739028249 where mk.movie_id=aggView2753559463739028249.v37);
create or replace view aggJoin1649563184871875889 as (
with aggView367022837829970180 as (select v37, MIN(v51) as v51 from aggJoin4978028128470425622 group by v37,v51)
select v12, v50 as v50, v52 as v52, v49 as v49, v51 from aggJoin5454289537215194820 join aggView367022837829970180 using(v37));
create or replace view aggJoin5582481781575341536 as (
with aggView8559620603821262594 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v50, v52, v49, v51 from aggJoin1649563184871875889 join aggView8559620603821262594 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5582481781575341536;
