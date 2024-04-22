create or replace view aggJoin90962897687667035 as (
with aggView7304841980247835706 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView7304841980247835706 where ci.person_id=aggView7304841980247835706.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5465887672594935195 as (
with aggView1055342302868419171 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView1055342302868419171 where mi.info_type_id=aggView1055342302868419171.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2847205655753852684 as (
with aggView3275190118994305604 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3275190118994305604 where mi_idx.info_type_id=aggView3275190118994305604.v10);
create or replace view aggJoin4608304557790894146 as (
with aggView7676112844398042898 as (select v31 from aggJoin90962897687667035 group by v31)
select v31, v15 from aggJoin5465887672594935195 join aggView7676112844398042898 using(v31));
create or replace view aggJoin8737708448729297723 as (
with aggView9139814778894396900 as (select v31, MIN(v15) as v43 from aggJoin4608304557790894146 group by v31)
select v31, v20, v43 from aggJoin2847205655753852684 join aggView9139814778894396900 using(v31));
create or replace view aggJoin713276265199707176 as (
with aggView2784921163810514931 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin8737708448729297723 group by v31,v43)
select title as v32, v43, v44 from title as t, aggView2784921163810514931 where t.id=aggView2784921163810514931.v31);
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin713276265199707176;
