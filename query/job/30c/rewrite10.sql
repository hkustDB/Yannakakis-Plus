create or replace view aggJoin2142334227379819935 as (
with aggView4460662748516075125 as (select id as v45, title as v60 from title as t)
select movie_id as v45, info_type_id as v16, info as v26, v60 from movie_info as mi, aggView4460662748516075125 where mi.movie_id=aggView4460662748516075125.v45 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2145653578432048025 as (
with aggView7029493652311620528 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView7029493652311620528 where ci.person_id=aggView7029493652311620528.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4974201936135692658 as (
with aggView3082340836016680213 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView3082340836016680213 where mk.keyword_id=aggView3082340836016680213.v20);
create or replace view aggJoin8492650347464028480 as (
with aggView3495653410307111779 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView3495653410307111779 where cc.status_id=aggView3495653410307111779.v7);
create or replace view aggJoin4232799144687660243 as (
with aggView8666838938912005428 as (select id as v16 from info_type as it1 where info= 'genres')
select v45, v26, v60 from aggJoin2142334227379819935 join aggView8666838938912005428 using(v16));
create or replace view aggJoin1555577279417578143 as (
with aggView8697536258617660450 as (select v45, MIN(v60) as v60, MIN(v26) as v57 from aggJoin4232799144687660243 group by v45,v60)
select v45, v13, v59 as v59, v60, v57 from aggJoin2145653578432048025 join aggView8697536258617660450 using(v45));
create or replace view aggJoin9053014261733245680 as (
with aggView6427388750907552310 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin8492650347464028480 join aggView6427388750907552310 using(v5));
create or replace view aggJoin1116029680097848252 as (
with aggView6998684382239288140 as (select v45 from aggJoin9053014261733245680 group by v45)
select v45 from aggJoin4974201936135692658 join aggView6998684382239288140 using(v45));
create or replace view aggJoin4935061433413637760 as (
with aggView6359184678172288667 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView6359184678172288667 where mi_idx.info_type_id=aggView6359184678172288667.v18);
create or replace view aggJoin171906194914745574 as (
with aggView2295776243307116730 as (select v45, MIN(v31) as v58 from aggJoin4935061433413637760 group by v45)
select v45, v13, v59 as v59, v60 as v60, v57 as v57, v58 from aggJoin1555577279417578143 join aggView2295776243307116730 using(v45));
create or replace view aggJoin7439209418797999867 as (
with aggView416870737158035648 as (select v45, MIN(v59) as v59, MIN(v60) as v60, MIN(v57) as v57, MIN(v58) as v58 from aggJoin171906194914745574 group by v45,v59,v57,v60,v58)
select v59, v60, v57, v58 from aggJoin1116029680097848252 join aggView416870737158035648 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin7439209418797999867;
