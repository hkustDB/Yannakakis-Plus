create or replace view aggJoin7086205522926927257 as (
with aggView3335147926742434262 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView3335147926742434262 where ci.person_id=aggView3335147926742434262.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4208559887214648755 as (
with aggView6889864194831317727 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView6889864194831317727 where mk.keyword_id=aggView6889864194831317727.v20);
create or replace view aggJoin2199793134174995553 as (
with aggView4905501458041381133 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4905501458041381133 where cc.status_id=aggView4905501458041381133.v7);
create or replace view aggJoin6420963048883845230 as (
with aggView2896060371394343148 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView2896060371394343148 where mi.info_type_id=aggView2896060371394343148.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2820911300571716484 as (
with aggView2058270726325563538 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin2199793134174995553 join aggView2058270726325563538 using(v5));
create or replace view aggJoin6786325762577673296 as (
with aggView5183608321835805885 as (select v45 from aggJoin2820911300571716484 group by v45)
select v45, v13, v59 as v59 from aggJoin7086205522926927257 join aggView5183608321835805885 using(v45));
create or replace view aggJoin519835069383726916 as (
with aggView2742897744195076467 as (select v45, MIN(v59) as v59 from aggJoin6786325762577673296 group by v45,v59)
select id as v45, title as v46, v59 from title as t, aggView2742897744195076467 where t.id=aggView2742897744195076467.v45);
create or replace view aggJoin5128846612001607813 as (
with aggView1932425831673270728 as (select v45, MIN(v59) as v59, MIN(v46) as v60 from aggJoin519835069383726916 group by v45,v59)
select v45, v26, v59, v60 from aggJoin6420963048883845230 join aggView1932425831673270728 using(v45));
create or replace view aggJoin7222264514774238046 as (
with aggView7776690812026810115 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView7776690812026810115 where mi_idx.info_type_id=aggView7776690812026810115.v18);
create or replace view aggJoin5854507857491149657 as (
with aggView8804467423121040087 as (select v45, MIN(v31) as v58 from aggJoin7222264514774238046 group by v45)
select v45, v26, v59 as v59, v60 as v60, v58 from aggJoin5128846612001607813 join aggView8804467423121040087 using(v45));
create or replace view aggJoin2964624636377307207 as (
with aggView9121162851300018341 as (select v45, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58, MIN(v26) as v57 from aggJoin5854507857491149657 group by v45,v59,v60,v58)
select v59, v60, v58, v57 from aggJoin4208559887214648755 join aggView9121162851300018341 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2964624636377307207;
