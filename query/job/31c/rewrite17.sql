create or replace view aggView1819756996950865740 as select name as v41, id as v40 from name as n;
create or replace view aggView3486449739160183842 as select id as v49, title as v50 from title as t;
create or replace view aggJoin1363709514582146178 as (
with aggView4751097188206422164 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView4751097188206422164 where mi.info_type_id=aggView4751097188206422164.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView3040638503294203201 as select v49, v30 from aggJoin1363709514582146178 group by v49,v30;
create or replace view aggJoin3631212110830374575 as (
with aggView8438519215271313282 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8438519215271313282 where mi_idx.info_type_id=aggView8438519215271313282.v17);
create or replace view aggView560857339466143968 as select v49, v35 from aggJoin3631212110830374575 group by v49,v35;
create or replace view aggJoin5988870847794814715 as (
with aggView2773883858032126093 as (select v49, MIN(v35) as v62 from aggView560857339466143968 group by v49)
select person_id as v40, movie_id as v49, note as v5, v62 from cast_info as ci, aggView2773883858032126093 where ci.movie_id=aggView2773883858032126093.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4619624643158750292 as (
with aggView1048364324108758452 as (select v49, MIN(v30) as v61 from aggView3040638503294203201 group by v49)
select v49, v50, v61 from aggView3486449739160183842 join aggView1048364324108758452 using(v49));
create or replace view aggJoin8710862742813558885 as (
with aggView616203362110710931 as (select v49, MIN(v61) as v61, MIN(v50) as v64 from aggJoin4619624643158750292 group by v49,v61)
select v40, v49, v5, v62 as v62, v61, v64 from aggJoin5988870847794814715 join aggView616203362110710931 using(v49));
create or replace view aggJoin7694492445951909986 as (
with aggView6160694016107350413 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView6160694016107350413 where mk.keyword_id=aggView6160694016107350413.v19);
create or replace view aggJoin1504111905707971927 as (
with aggView2365198605633174449 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView2365198605633174449 where mc.company_id=aggView2365198605633174449.v8);
create or replace view aggJoin2592489363765169212 as (
with aggView6002942718508385122 as (select v49 from aggJoin1504111905707971927 group by v49)
select v40, v49, v5, v62 as v62, v61 as v61, v64 as v64 from aggJoin8710862742813558885 join aggView6002942718508385122 using(v49));
create or replace view aggJoin1818315304975890808 as (
with aggView1522652203929758581 as (select v49 from aggJoin7694492445951909986 group by v49)
select v40, v5, v62 as v62, v61 as v61, v64 as v64 from aggJoin2592489363765169212 join aggView1522652203929758581 using(v49));
create or replace view aggJoin4593168907690337487 as (
with aggView8878198901688095516 as (select v40, MIN(v62) as v62, MIN(v61) as v61, MIN(v64) as v64 from aggJoin1818315304975890808 group by v40,v64,v61,v62)
select v41, v62, v61, v64 from aggView1819756996950865740 join aggView8878198901688095516 using(v40));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin4593168907690337487;
