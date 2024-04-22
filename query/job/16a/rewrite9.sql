create or replace view aggView6634635825822428239 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView2519510577671710452 as select id as v11, title as v44 from title as t where episode_nr>=50 and episode_nr<100;
create or replace view aggJoin1455652293794229808 as (
with aggView2025340643313539923 as (select v11, MIN(v44) as v56 from aggView2519510577671710452 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView2025340643313539923 where ci.movie_id=aggView2025340643313539923.v11);
create or replace view aggJoin2690302023275292831 as (
with aggView3124791967858920468 as (select id as v2 from name as n)
select v2, v11, v56 from aggJoin1455652293794229808 join aggView3124791967858920468 using(v2));
create or replace view aggJoin8801440607364290069 as (
with aggView2408690816301297980 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView2408690816301297980 where mc.company_id=aggView2408690816301297980.v28);
create or replace view aggJoin770510665492648234 as (
with aggView3844184016013232832 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView3844184016013232832 where mk.keyword_id=aggView3844184016013232832.v33);
create or replace view aggJoin7027701926368123721 as (
with aggView9195631417964513697 as (select v11 from aggJoin8801440607364290069 group by v11)
select v11 from aggJoin770510665492648234 join aggView9195631417964513697 using(v11));
create or replace view aggJoin6460420336476513864 as (
with aggView8419554264732203135 as (select v11 from aggJoin7027701926368123721 group by v11)
select v2, v56 as v56 from aggJoin2690302023275292831 join aggView8419554264732203135 using(v11));
create or replace view aggJoin5836616664058327408 as (
with aggView7920454706798630852 as (select v2, MIN(v56) as v56 from aggJoin6460420336476513864 group by v2,v56)
select v3, v56 from aggView6634635825822428239 join aggView7920454706798630852 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin5836616664058327408;
