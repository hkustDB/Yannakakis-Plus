create or replace view aggJoin866848344033576862 as (
with aggView3701538451970649991 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView3701538451970649991 where ci.person_id=aggView3701538451970649991.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5541783587549343611 as (
with aggView4283416034789838109 as (select id as v37, title as v52 from title as t)
select movie_id as v37, keyword_id as v12, v52 from movie_keyword as mk, aggView4283416034789838109 where mk.movie_id=aggView4283416034789838109.v37);
create or replace view aggJoin8258998923144681 as (
with aggView4602482059694894241 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView4602482059694894241 where mi_idx.info_type_id=aggView4602482059694894241.v10);
create or replace view aggJoin2127414385972329040 as (
with aggView4410744949859127183 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v52 from aggJoin5541783587549343611 join aggView4410744949859127183 using(v12));
create or replace view aggJoin2676149732206330200 as (
with aggView2449920386796049843 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView2449920386796049843 where mi.info_type_id=aggView2449920386796049843.v8 and info= 'Horror');
create or replace view aggJoin7878066936249133140 as (
with aggView3313401948999746082 as (select v37, MIN(v18) as v49 from aggJoin2676149732206330200 group by v37)
select v37, v5, v51 as v51, v49 from aggJoin866848344033576862 join aggView3313401948999746082 using(v37));
create or replace view aggJoin5818322048844140066 as (
with aggView9022197025739412092 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin7878066936249133140 group by v37,v51,v49)
select v37, v23, v51, v49 from aggJoin8258998923144681 join aggView9022197025739412092 using(v37));
create or replace view aggJoin4378107591816060443 as (
with aggView6562939541943729161 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v23) as v50 from aggJoin5818322048844140066 group by v37,v51,v49)
select v52 as v52, v51, v49, v50 from aggJoin2127414385972329040 join aggView6562939541943729161 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin4378107591816060443;
