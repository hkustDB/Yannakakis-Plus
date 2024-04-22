create or replace view aggJoin7528954766192467482 as (
with aggView6427846087590108221 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView6427846087590108221 where an.person_id=aggView6427846087590108221.v2);
create or replace view aggView7891189426642200673 as select v2, v3 from aggJoin7528954766192467482 group by v2,v3;
create or replace view aggJoin5296980106370240456 as (
with aggView4390234077015831447 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4390234077015831447 where mk.keyword_id=aggView4390234077015831447.v33);
create or replace view aggJoin5436805666717474632 as (
with aggView6558418448303794308 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6558418448303794308 where mc.company_id=aggView6558418448303794308.v28);
create or replace view aggJoin4893299921595220434 as (
with aggView4643251067238383730 as (select v11 from aggJoin5436805666717474632 group by v11)
select v11 from aggJoin5296980106370240456 join aggView4643251067238383730 using(v11));
create or replace view aggJoin2251291401581244145 as (
with aggView2023095069585084589 as (select v11 from aggJoin4893299921595220434 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2023095069585084589 where t.id=aggView2023095069585084589.v11 and episode_nr<100);
create or replace view aggView7918509783741868914 as select v44, v11 from aggJoin2251291401581244145 group by v44,v11;
create or replace view aggJoin1346022043648622957 as (
with aggView4038941211310738652 as (select v11, MIN(v44) as v56 from aggView7918509783741868914 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView4038941211310738652 where ci.movie_id=aggView4038941211310738652.v11);
create or replace view aggJoin4886114426394423676 as (
with aggView4707428627753035196 as (select v2, MIN(v56) as v56 from aggJoin1346022043648622957 group by v2,v56)
select v3, v56 from aggView7891189426642200673 join aggView4707428627753035196 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin4886114426394423676;
