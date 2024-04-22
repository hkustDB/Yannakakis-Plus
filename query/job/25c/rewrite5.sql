create or replace view aggJoin2324275129507714152 as (
with aggView2651276871653621590 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView2651276871653621590 where ci.person_id=aggView2651276871653621590.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7982975375773059923 as (
with aggView8180287503007551456 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView8180287503007551456 where mi_idx.info_type_id=aggView8180287503007551456.v10);
create or replace view aggJoin5381084664639655892 as (
with aggView3971239019797277481 as (select v37, MIN(v51) as v51 from aggJoin2324275129507714152 group by v37,v51)
select movie_id as v37, info_type_id as v8, info as v18, v51 from movie_info as mi, aggView3971239019797277481 where mi.movie_id=aggView3971239019797277481.v37 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin3176398665539346105 as (
with aggView203760922766466580 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v51 from aggJoin5381084664639655892 join aggView203760922766466580 using(v8));
create or replace view aggJoin2633330923926702462 as (
with aggView9196427725312875105 as (select v37, MIN(v51) as v51, MIN(v18) as v49 from aggJoin3176398665539346105 group by v37,v51)
select id as v37, title as v38, v51, v49 from title as t, aggView9196427725312875105 where t.id=aggView9196427725312875105.v37);
create or replace view aggJoin4367993801730874744 as (
with aggView4201654913428654850 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v38) as v52 from aggJoin2633330923926702462 group by v37,v49,v51)
select v37, v23, v51, v49, v52 from aggJoin7982975375773059923 join aggView4201654913428654850 using(v37));
create or replace view aggJoin2905850962007167250 as (
with aggView2901287250324455491 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v52) as v52, MIN(v23) as v50 from aggJoin4367993801730874744 group by v37,v49,v52,v51)
select keyword_id as v12, v51, v49, v52, v50 from movie_keyword as mk, aggView2901287250324455491 where mk.movie_id=aggView2901287250324455491.v37);
create or replace view aggJoin6106114875426299025 as (
with aggView8241151121526731339 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v51, v49, v52, v50 from aggJoin2905850962007167250 join aggView8241151121526731339 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin6106114875426299025;
