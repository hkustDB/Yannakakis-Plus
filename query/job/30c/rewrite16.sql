create or replace view aggJoin9013977402553590334 as (
with aggView1432655613958350567 as (select id as v45, title as v60 from title as t)
select person_id as v36, movie_id as v45, note as v13, v60 from cast_info as ci, aggView1432655613958350567 where ci.movie_id=aggView1432655613958350567.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3673446261137570353 as (
with aggView8167928143784425812 as (select id as v36, name as v59 from name as n where gender= 'm')
select v45, v13, v60, v59 from aggJoin9013977402553590334 join aggView8167928143784425812 using(v36));
create or replace view aggJoin8486315053656439612 as (
with aggView5336340865246124159 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView5336340865246124159 where mk.keyword_id=aggView5336340865246124159.v20);
create or replace view aggJoin9113130279727650352 as (
with aggView8099138774137494632 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView8099138774137494632 where cc.status_id=aggView8099138774137494632.v7);
create or replace view aggJoin201913658895274071 as (
with aggView4736173993507816400 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView4736173993507816400 where mi.info_type_id=aggView4736173993507816400.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7644845797077208719 as (
with aggView3347248829849143274 as (select v45, MIN(v26) as v57 from aggJoin201913658895274071 group by v45)
select v45, v13, v60 as v60, v59 as v59, v57 from aggJoin3673446261137570353 join aggView3347248829849143274 using(v45));
create or replace view aggJoin5616536000172448344 as (
with aggView3550630820718529928 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin9113130279727650352 join aggView3550630820718529928 using(v5));
create or replace view aggJoin5051210127787902269 as (
with aggView5497293987902434466 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView5497293987902434466 where mi_idx.info_type_id=aggView5497293987902434466.v18);
create or replace view aggJoin841897274707217752 as (
with aggView5383481104410449788 as (select v45, MIN(v31) as v58 from aggJoin5051210127787902269 group by v45)
select v45, v58 from aggJoin5616536000172448344 join aggView5383481104410449788 using(v45));
create or replace view aggJoin1649975167384547594 as (
with aggView2575201232826778164 as (select v45, MIN(v58) as v58 from aggJoin841897274707217752 group by v45,v58)
select v45, v13, v60 as v60, v59 as v59, v57 as v57, v58 from aggJoin7644845797077208719 join aggView2575201232826778164 using(v45));
create or replace view aggJoin4133175399885146650 as (
with aggView4799955462496092419 as (select v45, MIN(v60) as v60, MIN(v59) as v59, MIN(v57) as v57, MIN(v58) as v58 from aggJoin1649975167384547594 group by v45,v59,v57,v60,v58)
select v60, v59, v57, v58 from aggJoin8486315053656439612 join aggView4799955462496092419 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin4133175399885146650;
