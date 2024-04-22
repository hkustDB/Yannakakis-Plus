create or replace view aggJoin5922625255704220985 as (
with aggView8127489527283511104 as (select id as v45, title as v60 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000)
select movie_id as v45, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView8127489527283511104 where cc.movie_id=aggView8127489527283511104.v45);
create or replace view aggJoin7471975418300447255 as (
with aggView1898835294555096321 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView1898835294555096321 where ci.person_id=aggView1898835294555096321.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6406308881195374318 as (
with aggView7466141039056434622 as (select v45, MIN(v59) as v59 from aggJoin7471975418300447255 group by v45,v59)
select movie_id as v45, info_type_id as v16, info as v26, v59 from movie_info as mi, aggView7466141039056434622 where mi.movie_id=aggView7466141039056434622.v45 and info IN ('Horror','Thriller'));
create or replace view aggJoin4420280467855575953 as (
with aggView2474631486454075543 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select v45, v5, v60 from aggJoin5922625255704220985 join aggView2474631486454075543 using(v7));
create or replace view aggJoin2936716204791757324 as (
with aggView3602183684659995877 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView3602183684659995877 where mk.keyword_id=aggView3602183684659995877.v20);
create or replace view aggJoin6866657291824252989 as (
with aggView4989220483160456168 as (select id as v16 from info_type as it1 where info= 'genres')
select v45, v26, v59 from aggJoin6406308881195374318 join aggView4989220483160456168 using(v16));
create or replace view aggJoin356776666310313321 as (
with aggView8514673172672657560 as (select v45, MIN(v59) as v59, MIN(v26) as v57 from aggJoin6866657291824252989 group by v45,v59)
select v45, v5, v60 as v60, v59, v57 from aggJoin4420280467855575953 join aggView8514673172672657560 using(v45));
create or replace view aggJoin4070212237510740958 as (
with aggView601622252825542092 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45, v60, v59, v57 from aggJoin356776666310313321 join aggView601622252825542092 using(v5));
create or replace view aggJoin2965071889604126762 as (
with aggView5025041068241284799 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView5025041068241284799 where mi_idx.info_type_id=aggView5025041068241284799.v18);
create or replace view aggJoin1150350228574275263 as (
with aggView1317053977603195356 as (select v45, MIN(v31) as v58 from aggJoin2965071889604126762 group by v45)
select v45, v60 as v60, v59 as v59, v57 as v57, v58 from aggJoin4070212237510740958 join aggView1317053977603195356 using(v45));
create or replace view aggJoin8980721606803483744 as (
with aggView1572687096087414286 as (select v45, MIN(v60) as v60, MIN(v59) as v59, MIN(v57) as v57, MIN(v58) as v58 from aggJoin1150350228574275263 group by v45,v58,v59,v60,v57)
select v60, v59, v57, v58 from aggJoin2936716204791757324 join aggView1572687096087414286 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin8980721606803483744;
