create or replace view aggJoin3161977661010178461 as (
with aggView2025209357617649110 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView2025209357617649110 where ci.person_id=aggView2025209357617649110.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin668803430705991921 as (
with aggView3890107686781124023 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView3890107686781124023 where mi_idx.info_type_id=aggView3890107686781124023.v10);
create or replace view aggJoin8174580004276606470 as (
with aggView3256222023554136984 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView3256222023554136984 where mk.keyword_id=aggView3256222023554136984.v12);
create or replace view aggJoin2793733121404826040 as (
with aggView8417134162367963541 as (select v37, MIN(v51) as v51 from aggJoin3161977661010178461 group by v37,v51)
select v37, v23, v51 from aggJoin668803430705991921 join aggView8417134162367963541 using(v37));
create or replace view aggJoin1987561638459297858 as (
with aggView8490760698964851763 as (select v37, MIN(v51) as v51, MIN(v23) as v50 from aggJoin2793733121404826040 group by v37,v51)
select movie_id as v37, info_type_id as v8, info as v18, v51, v50 from movie_info as mi, aggView8490760698964851763 where mi.movie_id=aggView8490760698964851763.v37 and info= 'Horror');
create or replace view aggJoin7023101445158909992 as (
with aggView3638573768886353118 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v51, v50 from aggJoin1987561638459297858 join aggView3638573768886353118 using(v8));
create or replace view aggJoin6105478561414346560 as (
with aggView4205225058874080969 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v18) as v49 from aggJoin7023101445158909992 group by v37,v51,v50)
select id as v37, title as v38, v51, v50, v49 from title as t, aggView4205225058874080969 where t.id=aggView4205225058874080969.v37);
create or replace view aggJoin6020457961610337749 as (
with aggView6756775689954308120 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v49) as v49, MIN(v38) as v52 from aggJoin6105478561414346560 group by v37,v51,v49,v50)
select v51, v50, v49, v52 from aggJoin8174580004276606470 join aggView6756775689954308120 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin6020457961610337749;
