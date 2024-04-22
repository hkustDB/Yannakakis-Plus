create or replace view aggJoin383461942924129258 as (
with aggView5213699019432834410 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView5213699019432834410 where an.person_id=aggView5213699019432834410.v2);
create or replace view aggView1292780234176115925 as select v2, v3 from aggJoin383461942924129258 group by v2,v3;
create or replace view aggJoin1180375287525209683 as (
with aggView2322942873562494530 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView2322942873562494530 where mk.keyword_id=aggView2322942873562494530.v33);
create or replace view aggJoin619214736896118853 as (
with aggView8814094021811222298 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8814094021811222298 where mc.company_id=aggView8814094021811222298.v28);
create or replace view aggJoin7379351564542397736 as (
with aggView8118578876620237178 as (select v11 from aggJoin619214736896118853 group by v11)
select v11 from aggJoin1180375287525209683 join aggView8118578876620237178 using(v11));
create or replace view aggJoin8292639609151850568 as (
with aggView7727898223273492082 as (select v11 from aggJoin7379351564542397736 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView7727898223273492082 where t.id=aggView7727898223273492082.v11 and episode_nr<100);
create or replace view aggView2864668425859129799 as select v44, v11 from aggJoin8292639609151850568 group by v44,v11;
create or replace view aggJoin630482806236384724 as (
with aggView8672226987791761528 as (select v2, MIN(v3) as v55 from aggView1292780234176115925 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView8672226987791761528 where ci.person_id=aggView8672226987791761528.v2);
create or replace view aggJoin3296733420536349297 as (
with aggView8916876200457869122 as (select v11, MIN(v55) as v55 from aggJoin630482806236384724 group by v11,v55)
select v44, v55 from aggView2864668425859129799 join aggView8916876200457869122 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin3296733420536349297;
