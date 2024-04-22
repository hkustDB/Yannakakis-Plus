create or replace view aggJoin7460924955886514606 as (
with aggView6844692705274329922 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView6844692705274329922 where ci.person_id=aggView6844692705274329922.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6675192471259264004 as (
with aggView4814921653084266508 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView4814921653084266508 where mi.info_type_id=aggView4814921653084266508.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1494727042254137467 as (
with aggView2463154176447091016 as (select v31, MIN(v15) as v43 from aggJoin6675192471259264004 group by v31)
select movie_id as v31, info_type_id as v10, info as v20, v43 from movie_info_idx as mi_idx, aggView2463154176447091016 where mi_idx.movie_id=aggView2463154176447091016.v31);
create or replace view aggJoin8778805292515041697 as (
with aggView2924187489136163838 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20, v43 from aggJoin1494727042254137467 join aggView2924187489136163838 using(v10));
create or replace view aggJoin8661727508246066319 as (
with aggView2059896482293850134 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin8778805292515041697 group by v31,v43)
select v31, v5, v43, v44 from aggJoin7460924955886514606 join aggView2059896482293850134 using(v31));
create or replace view aggJoin3423843378700193960 as (
with aggView4944783282244062986 as (select v31, MIN(v43) as v43, MIN(v44) as v44 from aggJoin8661727508246066319 group by v31,v44,v43)
select title as v32, v43, v44 from title as t, aggView4944783282244062986 where t.id=aggView4944783282244062986.v31);
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin3423843378700193960;
