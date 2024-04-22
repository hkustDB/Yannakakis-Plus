create or replace view aggView321196015874092828 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin7608042430094036123 as (
with aggView4397383695923592267 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView4397383695923592267 where mk.keyword_id=aggView4397383695923592267.v20);
create or replace view aggJoin8497198244349233801 as (
with aggView1698171178830705622 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1698171178830705622 where cc.status_id=aggView1698171178830705622.v7);
create or replace view aggJoin8955354680478067515 as (
with aggView1128941153109802356 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView1128941153109802356 where mi.info_type_id=aggView1128941153109802356.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView9127015473234496013 as select v45, v26 from aggJoin8955354680478067515 group by v45,v26;
create or replace view aggJoin2700970420291892303 as (
with aggView7486047430224594894 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin8497198244349233801 join aggView7486047430224594894 using(v5));
create or replace view aggJoin5413006803118074574 as (
with aggView2309216436985755594 as (select v45 from aggJoin2700970420291892303 group by v45)
select v45 from aggJoin7608042430094036123 join aggView2309216436985755594 using(v45));
create or replace view aggJoin7664001087979170333 as (
with aggView8180324822761541310 as (select v45 from aggJoin5413006803118074574 group by v45)
select id as v45, title as v46 from title as t, aggView8180324822761541310 where t.id=aggView8180324822761541310.v45);
create or replace view aggView8402821460379967941 as select v45, v46 from aggJoin7664001087979170333 group by v45,v46;
create or replace view aggJoin4117234473198152823 as (
with aggView5291021616498002300 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView5291021616498002300 where mi_idx.info_type_id=aggView5291021616498002300.v18);
create or replace view aggView6686656176276003362 as select v45, v31 from aggJoin4117234473198152823 group by v45,v31;
create or replace view aggJoin6932964443341783212 as (
with aggView9164161018404450854 as (select v36, MIN(v37) as v59 from aggView321196015874092828 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView9164161018404450854 where ci.person_id=aggView9164161018404450854.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5321000702244185375 as (
with aggView7861188190994535281 as (select v45, MIN(v26) as v57 from aggView9127015473234496013 group by v45)
select v45, v13, v59 as v59, v57 from aggJoin6932964443341783212 join aggView7861188190994535281 using(v45));
create or replace view aggJoin47866838103477674 as (
with aggView3229275460709788880 as (select v45, MIN(v59) as v59, MIN(v57) as v57 from aggJoin5321000702244185375 group by v45,v59,v57)
select v45, v31, v59, v57 from aggView6686656176276003362 join aggView3229275460709788880 using(v45));
create or replace view aggJoin4607122298521465091 as (
with aggView5914091118481431661 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v31) as v58 from aggJoin47866838103477674 group by v45,v59,v57)
select v46, v59, v57, v58 from aggView8402821460379967941 join aggView5914091118481431661 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v46) as v60 from aggJoin4607122298521465091;
