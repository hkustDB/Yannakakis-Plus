create or replace view aggView2629378605602443457 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin3255442210964160937 as (
with aggView1207158809683589434 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView1207158809683589434 where mi_idx.info_type_id=aggView1207158809683589434.v10);
create or replace view aggView8146440752538863915 as select v23, v37 from aggJoin3255442210964160937 group by v23,v37;
create or replace view aggJoin2413015347691804929 as (
with aggView2884234078838659792 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView2884234078838659792 where mi.info_type_id=aggView2884234078838659792.v8);
create or replace view aggJoin4519560270445200246 as (
with aggView3048005079716047464 as (select v18, v37 from aggJoin2413015347691804929 group by v18,v37)
select v37, v18 from aggView3048005079716047464 where v18= 'Horror');
create or replace view aggJoin2552814593975186391 as (
with aggView2876444476431551886 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView2876444476431551886 where mk.keyword_id=aggView2876444476431551886.v12);
create or replace view aggJoin6208789407377462636 as (
with aggView734778942279028084 as (select v37 from aggJoin2552814593975186391 group by v37)
select id as v37, title as v38 from title as t, aggView734778942279028084 where t.id=aggView734778942279028084.v37);
create or replace view aggView189035902674201483 as select v38, v37 from aggJoin6208789407377462636 group by v38,v37;
create or replace view aggJoin3199778449896517830 as (
with aggView8797387218264263931 as (select v37, MIN(v23) as v50 from aggView8146440752538863915 group by v37)
select v38, v37, v50 from aggView189035902674201483 join aggView8797387218264263931 using(v37));
create or replace view aggJoin4018698308900980181 as (
with aggView2578902299846577446 as (select v28, MIN(v29) as v51 from aggView2629378605602443457 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView2578902299846577446 where ci.person_id=aggView2578902299846577446.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8604809110240855131 as (
with aggView2021503263902319742 as (select v37, MIN(v18) as v49 from aggJoin4519560270445200246 group by v37)
select v38, v37, v50 as v50, v49 from aggJoin3199778449896517830 join aggView2021503263902319742 using(v37));
create or replace view aggJoin2051977818811384094 as (
with aggView9004324942603437418 as (select v37, MIN(v51) as v51 from aggJoin4018698308900980181 group by v37,v51)
select v38, v50 as v50, v49 as v49, v51 from aggJoin8604809110240855131 join aggView9004324942603437418 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v38) as v52 from aggJoin2051977818811384094;
