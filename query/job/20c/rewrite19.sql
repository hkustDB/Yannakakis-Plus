create or replace view aggJoin7169435677695249237 as (
with aggView5066400816322762020 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView5066400816322762020 where ci.person_id=aggView5066400816322762020.v31);
create or replace view aggJoin6946649311322950426 as (
with aggView5928770401813551297 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin7169435677695249237 join aggView5928770401813551297 using(v9));
create or replace view aggJoin3660959267510222457 as (
with aggView5132556675366848067 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView5132556675366848067 where t.kind_id=aggView5132556675366848067.v26 and production_year>2000);
create or replace view aggJoin8073694601901498952 as (
with aggView9184088826793731386 as (select v40, MIN(v41) as v53 from aggJoin3660959267510222457 group by v40)
select v40, v52 as v52, v53 from aggJoin6946649311322950426 join aggView9184088826793731386 using(v40));
create or replace view aggJoin6705626250909453821 as (
with aggView7953265102819997499 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView7953265102819997499 where cc.status_id=aggView7953265102819997499.v7);
create or replace view aggJoin7564733157622007485 as (
with aggView5823637843626055606 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView5823637843626055606 where mk.keyword_id=aggView5823637843626055606.v23);
create or replace view aggJoin2371665353359777753 as (
with aggView7609933639800704852 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin6705626250909453821 join aggView7609933639800704852 using(v5));
create or replace view aggJoin3813200287224881993 as (
with aggView5190480366665914205 as (select v40 from aggJoin2371665353359777753 group by v40)
select v40 from aggJoin7564733157622007485 join aggView5190480366665914205 using(v40));
create or replace view aggJoin1124778604571978134 as (
with aggView1484133360498050620 as (select v40 from aggJoin3813200287224881993 group by v40)
select v52 as v52, v53 as v53 from aggJoin8073694601901498952 join aggView1484133360498050620 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1124778604571978134;
