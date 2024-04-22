create or replace view aggView9093729320568822420 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin1314340774713032106 as (
with aggView6851221751454361294 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView6851221751454361294 where mk.keyword_id=aggView6851221751454361294.v20);
create or replace view aggJoin4834894289317369024 as (
with aggView2258742812894835312 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView2258742812894835312 where mi.info_type_id=aggView2258742812894835312.v16);
create or replace view aggJoin4291169206731773766 as (
with aggView1073478470677534644 as (select v45, v26 from aggJoin4834894289317369024 group by v45,v26)
select v45, v26 from aggView1073478470677534644 where v26 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin463907350859208245 as (
with aggView3630646465803861616 as (select v45 from aggJoin1314340774713032106 group by v45)
select id as v45, title as v46 from title as t, aggView3630646465803861616 where t.id=aggView3630646465803861616.v45);
create or replace view aggView1918150329340233070 as select v45, v46 from aggJoin463907350859208245 group by v45,v46;
create or replace view aggJoin9132173068897337551 as (
with aggView5982666689909651768 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView5982666689909651768 where mi_idx.info_type_id=aggView5982666689909651768.v18);
create or replace view aggView818758352979450896 as select v45, v31 from aggJoin9132173068897337551 group by v45,v31;
create or replace view aggJoin7742331242027661907 as (
with aggView5608228703514549404 as (select v45, MIN(v26) as v57 from aggJoin4291169206731773766 group by v45)
select v45, v31, v57 from aggView818758352979450896 join aggView5608228703514549404 using(v45));
create or replace view aggJoin8706850327453791594 as (
with aggView2516822038093011225 as (select v36, MIN(v37) as v59 from aggView9093729320568822420 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView2516822038093011225 where ci.person_id=aggView2516822038093011225.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7040529922542316671 as (
with aggView8703315667610919110 as (select v45, MIN(v57) as v57, MIN(v31) as v58 from aggJoin7742331242027661907 group by v45,v57)
select v45, v13, v59 as v59, v57, v58 from aggJoin8706850327453791594 join aggView8703315667610919110 using(v45));
create or replace view aggJoin7601399434050810364 as (
with aggView4111132171729566589 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4111132171729566589 where cc.status_id=aggView4111132171729566589.v7);
create or replace view aggJoin2317113301526213678 as (
with aggView7997927643847831726 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin7601399434050810364 join aggView7997927643847831726 using(v5));
create or replace view aggJoin3986998175837937915 as (
with aggView1834841844142504868 as (select v45 from aggJoin2317113301526213678 group by v45)
select v45, v13, v59 as v59, v57 as v57, v58 as v58 from aggJoin7040529922542316671 join aggView1834841844142504868 using(v45));
create or replace view aggJoin4898086874134540057 as (
with aggView4426318570042514277 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v58) as v58 from aggJoin3986998175837937915 group by v45,v59,v57,v58)
select v46, v59, v57, v58 from aggView1918150329340233070 join aggView4426318570042514277 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v46) as v60 from aggJoin4898086874134540057;
