create or replace view aggJoin3798191795169788950 as (
with aggView1647717884744162867 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView1647717884744162867 where ci.person_role_id=aggView1647717884744162867.v9);
create or replace view aggJoin8965756855753477391 as (
with aggView8597601500383164673 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin3798191795169788950 join aggView8597601500383164673 using(v38));
create or replace view aggJoin6129931937081937773 as (
with aggView5761411001293298689 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView5761411001293298689 where t.kind_id=aggView5761411001293298689.v28 and production_year>2000);
create or replace view aggJoin6384986482322886350 as (
with aggView6322253903412176584 as (select v47, MIN(v48) as v62 from aggJoin6129931937081937773 group by v47)
select movie_id as v47, info_type_id as v23, info as v33, v62 from movie_info_idx as mi_idx, aggView6322253903412176584 where mi_idx.movie_id=aggView6322253903412176584.v47 and info>'7.0');
create or replace view aggJoin2348143863654582512 as (
with aggView5570554159652516087 as (select id as v23 from info_type as it2 where info= 'rating')
select v47, v33, v62 from aggJoin6384986482322886350 join aggView5570554159652516087 using(v23));
create or replace view aggJoin5234663259872187994 as (
with aggView7690836774702300107 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView7690836774702300107 where cc.subject_id=aggView7690836774702300107.v5);
create or replace view aggJoin2529842704499148381 as (
with aggView8108466793037168262 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin5234663259872187994 join aggView8108466793037168262 using(v7));
create or replace view aggJoin8583479276954233138 as (
with aggView7655457032782110842 as (select v47 from aggJoin2529842704499148381 group by v47)
select v47, v33, v62 as v62 from aggJoin2348143863654582512 join aggView7655457032782110842 using(v47));
create or replace view aggJoin8874726220784757511 as (
with aggView2363827844580118719 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView2363827844580118719 where mk.keyword_id=aggView2363827844580118719.v25);
create or replace view aggJoin4504991197182864742 as (
with aggView2309687177293476313 as (select v47 from aggJoin8874726220784757511 group by v47)
select v47, v33, v62 as v62 from aggJoin8583479276954233138 join aggView2309687177293476313 using(v47));
create or replace view aggJoin294061513270031514 as (
with aggView9205446124367404409 as (select v47, MIN(v62) as v62, MIN(v33) as v60 from aggJoin4504991197182864742 group by v47,v62)
select v59 as v59, v61 as v61, v62, v60 from aggJoin8965756855753477391 join aggView9205446124367404409 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin294061513270031514;
