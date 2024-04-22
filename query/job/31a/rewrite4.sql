create or replace view aggView9144610424513358566 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin5690261841265409959 as (
with aggView9134043006609428242 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView9134043006609428242 where mk.keyword_id=aggView9134043006609428242.v19);
create or replace view aggJoin8899451030595721588 as (
with aggView8977101994199148013 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8977101994199148013 where mi_idx.info_type_id=aggView8977101994199148013.v17);
create or replace view aggJoin4399886181654069189 as (
with aggView30874096550097949 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView30874096550097949 where mi.info_type_id=aggView30874096550097949.v15);
create or replace view aggJoin4699191646917094603 as (
with aggView5912324095969813458 as (select v30, v49 from aggJoin4399886181654069189 group by v30,v49)
select v49, v30 from aggView5912324095969813458 where v30 IN ('Horror','Thriller'));
create or replace view aggJoin3977532980389343185 as (
with aggView660840421005787311 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView660840421005787311 where mc.company_id=aggView660840421005787311.v8);
create or replace view aggJoin4828501445150571977 as (
with aggView7926729269588949887 as (select v49 from aggJoin5690261841265409959 group by v49)
select v49, v35 from aggJoin8899451030595721588 join aggView7926729269588949887 using(v49));
create or replace view aggView389399706054459075 as select v49, v35 from aggJoin4828501445150571977 group by v49,v35;
create or replace view aggJoin8304261393356270358 as (
with aggView6036704134223015311 as (select v49 from aggJoin3977532980389343185 group by v49)
select id as v49, title as v50 from title as t, aggView6036704134223015311 where t.id=aggView6036704134223015311.v49);
create or replace view aggView6362639194876829411 as select v50, v49 from aggJoin8304261393356270358 group by v50,v49;
create or replace view aggJoin1104181398635414578 as (
with aggView714235850928728741 as (select v40, MIN(v41) as v63 from aggView9144610424513358566 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView714235850928728741 where ci.person_id=aggView714235850928728741.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8718365311635625505 as (
with aggView1230099170624564164 as (select v49, MIN(v30) as v61 from aggJoin4699191646917094603 group by v49)
select v50, v49, v61 from aggView6362639194876829411 join aggView1230099170624564164 using(v49));
create or replace view aggJoin2716636635625651075 as (
with aggView4250561507277748667 as (select v49, MIN(v35) as v62 from aggView389399706054459075 group by v49)
select v49, v5, v63 as v63, v62 from aggJoin1104181398635414578 join aggView4250561507277748667 using(v49));
create or replace view aggJoin3426832590128022319 as (
with aggView967959661499815177 as (select v49, MIN(v63) as v63, MIN(v62) as v62 from aggJoin2716636635625651075 group by v49,v63,v62)
select v50, v61 as v61, v63, v62 from aggJoin8718365311635625505 join aggView967959661499815177 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin3426832590128022319;
