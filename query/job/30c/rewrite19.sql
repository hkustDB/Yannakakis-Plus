create or replace view aggJoin3834778359236161008 as (
with aggView1001793921632474882 as (select id as v45, title as v60 from title as t)
select movie_id as v45, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView1001793921632474882 where cc.movie_id=aggView1001793921632474882.v45);
create or replace view aggJoin3514231985497933167 as (
with aggView5100244863848634492 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView5100244863848634492 where ci.person_id=aggView5100244863848634492.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1618700083520298657 as (
with aggView2615942148933196068 as (select v45, MIN(v59) as v59 from aggJoin3514231985497933167 group by v45,v59)
select movie_id as v45, info_type_id as v16, info as v26, v59 from movie_info as mi, aggView2615942148933196068 where mi.movie_id=aggView2615942148933196068.v45 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7653206368725251229 as (
with aggView1200396928351632076 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView1200396928351632076 where mk.keyword_id=aggView1200396928351632076.v20);
create or replace view aggJoin3405616999274412942 as (
with aggView627909216992555786 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select v45, v5, v60 from aggJoin3834778359236161008 join aggView627909216992555786 using(v7));
create or replace view aggJoin7514972041966080094 as (
with aggView2033889198509370314 as (select id as v16 from info_type as it1 where info= 'genres')
select v45, v26, v59 from aggJoin1618700083520298657 join aggView2033889198509370314 using(v16));
create or replace view aggJoin1995935400531285379 as (
with aggView1222676208991194653 as (select v45, MIN(v59) as v59, MIN(v26) as v57 from aggJoin7514972041966080094 group by v45,v59)
select v45, v5, v60 as v60, v59, v57 from aggJoin3405616999274412942 join aggView1222676208991194653 using(v45));
create or replace view aggJoin918454203502481023 as (
with aggView5455458607821221750 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45, v60, v59, v57 from aggJoin1995935400531285379 join aggView5455458607821221750 using(v5));
create or replace view aggJoin3977420860668423022 as (
with aggView8694539624659423763 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView8694539624659423763 where mi_idx.info_type_id=aggView8694539624659423763.v18);
create or replace view aggJoin1246151854894134112 as (
with aggView8275165758024939050 as (select v45, MIN(v31) as v58 from aggJoin3977420860668423022 group by v45)
select v45, v60 as v60, v59 as v59, v57 as v57, v58 from aggJoin918454203502481023 join aggView8275165758024939050 using(v45));
create or replace view aggJoin5501237200129744387 as (
with aggView1468399790327444569 as (select v45, MIN(v60) as v60, MIN(v59) as v59, MIN(v57) as v57, MIN(v58) as v58 from aggJoin1246151854894134112 group by v45,v59,v57,v60,v58)
select v60, v59, v57, v58 from aggJoin7653206368725251229 join aggView1468399790327444569 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin5501237200129744387;
