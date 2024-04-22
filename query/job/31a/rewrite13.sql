create or replace view aggJoin4746780069205443938 as (
with aggView6995731103775049890 as (select id as v49, title as v64 from title as t)
select movie_id as v49, info_type_id as v15, info as v30, v64 from movie_info as mi, aggView6995731103775049890 where mi.movie_id=aggView6995731103775049890.v49 and info IN ('Horror','Thriller'));
create or replace view aggJoin9103799559987886759 as (
with aggView3401703883650211374 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView3401703883650211374 where ci.person_id=aggView3401703883650211374.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6059658416311150962 as (
with aggView95052446014797754 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView95052446014797754 where mi_idx.info_type_id=aggView95052446014797754.v17);
create or replace view aggJoin2917345673520739564 as (
with aggView5679352213513032781 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView5679352213513032781 where mk.keyword_id=aggView5679352213513032781.v19);
create or replace view aggJoin7673836306487385516 as (
with aggView6325453204386680211 as (select id as v15 from info_type as it1 where info= 'genres')
select v49, v30, v64 from aggJoin4746780069205443938 join aggView6325453204386680211 using(v15));
create or replace view aggJoin8157585042037404715 as (
with aggView5326668327144337454 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView5326668327144337454 where mc.company_id=aggView5326668327144337454.v8);
create or replace view aggJoin5758037389677274853 as (
with aggView7247673695848118088 as (select v49 from aggJoin8157585042037404715 group by v49)
select v49, v30, v64 as v64 from aggJoin7673836306487385516 join aggView7247673695848118088 using(v49));
create or replace view aggJoin8521230828897123661 as (
with aggView8202132356473389323 as (select v49, MIN(v64) as v64, MIN(v30) as v61 from aggJoin5758037389677274853 group by v49,v64)
select v49, v35, v64, v61 from aggJoin6059658416311150962 join aggView8202132356473389323 using(v49));
create or replace view aggJoin8046394360403117955 as (
with aggView223517633539728560 as (select v49, MIN(v64) as v64, MIN(v61) as v61, MIN(v35) as v62 from aggJoin8521230828897123661 group by v49,v64,v61)
select v49, v64, v61, v62 from aggJoin2917345673520739564 join aggView223517633539728560 using(v49));
create or replace view aggJoin4687137515416772906 as (
with aggView4106549845037243060 as (select v49, MIN(v63) as v63 from aggJoin9103799559987886759 group by v49,v63)
select v64 as v64, v61 as v61, v62 as v62, v63 from aggJoin8046394360403117955 join aggView4106549845037243060 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin4687137515416772906;
