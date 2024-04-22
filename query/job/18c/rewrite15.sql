create or replace view aggJoin1010894933776460770 as (
with aggView3312602339144241661 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView3312602339144241661 where ci.person_id=aggView3312602339144241661.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4263976057585060162 as (
with aggView8216738529080817262 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView8216738529080817262 where mi.info_type_id=aggView8216738529080817262.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin3787161517556659422 as (
with aggView946482406176232412 as (select v31, MIN(v15) as v43 from aggJoin4263976057585060162 group by v31)
select v31, v5, v43 from aggJoin1010894933776460770 join aggView946482406176232412 using(v31));
create or replace view aggJoin1704475933726252325 as (
with aggView4511710289861745986 as (select v31, MIN(v43) as v43 from aggJoin3787161517556659422 group by v31,v43)
select movie_id as v31, info_type_id as v10, info as v20, v43 from movie_info_idx as mi_idx, aggView4511710289861745986 where mi_idx.movie_id=aggView4511710289861745986.v31);
create or replace view aggJoin5984810673772102844 as (
with aggView694295275570003656 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20, v43 from aggJoin1704475933726252325 join aggView694295275570003656 using(v10));
create or replace view aggJoin6554667841611828719 as (
with aggView8968467926888477364 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin5984810673772102844 group by v31,v43)
select title as v32, v43, v44 from title as t, aggView8968467926888477364 where t.id=aggView8968467926888477364.v31);
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin6554667841611828719;
