create or replace view aggView2532574085235045673 as select name as v41, id as v40 from name as n;
create or replace view aggJoin6716248086738943873 as (
with aggView8743022072126432032 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8743022072126432032 where mk.keyword_id=aggView8743022072126432032.v19);
create or replace view aggJoin7882808329953991242 as (
with aggView6289115753507322658 as (select v49 from aggJoin6716248086738943873 group by v49)
select id as v49, title as v50 from title as t, aggView6289115753507322658 where t.id=aggView6289115753507322658.v49);
create or replace view aggView4573760772340399927 as select v49, v50 from aggJoin7882808329953991242 group by v49,v50;
create or replace view aggJoin4736585314691356579 as (
with aggView7494251125828083452 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView7494251125828083452 where mc.company_id=aggView7494251125828083452.v8);
create or replace view aggJoin68390594990262184 as (
with aggView7165826997481652102 as (select v49 from aggJoin4736585314691356579 group by v49)
select movie_id as v49, info_type_id as v17, info as v35 from movie_info_idx as mi_idx, aggView7165826997481652102 where mi_idx.movie_id=aggView7165826997481652102.v49);
create or replace view aggJoin9032047582592948174 as (
with aggView9217757198034941031 as (select id as v17 from info_type as it2 where info= 'votes')
select v49, v35 from aggJoin68390594990262184 join aggView9217757198034941031 using(v17));
create or replace view aggView8220022272312904127 as select v49, v35 from aggJoin9032047582592948174 group by v49,v35;
create or replace view aggJoin3463933484888264472 as (
with aggView8142983479686765793 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView8142983479686765793 where mi.info_type_id=aggView8142983479686765793.v15);
create or replace view aggJoin3195908523916153024 as (
with aggView7984241348046638439 as (select v49, v30 from aggJoin3463933484888264472 group by v49,v30)
select v49, v30 from aggView7984241348046638439 where v30 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin986429428943466343 as (
with aggView3504999445391376810 as (select v49, MIN(v50) as v64 from aggView4573760772340399927 group by v49)
select person_id as v40, movie_id as v49, note as v5, v64 from cast_info as ci, aggView3504999445391376810 where ci.movie_id=aggView3504999445391376810.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3482012008907191144 as (
with aggView4631951343693900613 as (select v40, MIN(v41) as v63 from aggView2532574085235045673 group by v40)
select v49, v5, v64 as v64, v63 from aggJoin986429428943466343 join aggView4631951343693900613 using(v40));
create or replace view aggJoin7920905226756563949 as (
with aggView2736569593988008998 as (select v49, MIN(v64) as v64, MIN(v63) as v63 from aggJoin3482012008907191144 group by v49,v63,v64)
select v49, v35, v64, v63 from aggView8220022272312904127 join aggView2736569593988008998 using(v49));
create or replace view aggJoin5588140922784453405 as (
with aggView4643425376975664965 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v35) as v62 from aggJoin7920905226756563949 group by v49,v63,v64)
select v30, v64, v63, v62 from aggJoin3195908523916153024 join aggView4643425376975664965 using(v49));
select MIN(v30) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin5588140922784453405;
