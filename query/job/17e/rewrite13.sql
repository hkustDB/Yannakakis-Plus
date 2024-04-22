create or replace view aggJoin5764352754898977056 as (
with aggView5773016395123008985 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView5773016395123008985 where ci.person_id=aggView5773016395123008985.v26);
create or replace view aggJoin42527994527844707 as (
with aggView723086153339288337 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView723086153339288337 where mc.company_id=aggView723086153339288337.v20);
create or replace view aggJoin1268462047022491205 as (
with aggView5440771302869472889 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5440771302869472889 where mk.keyword_id=aggView5440771302869472889.v25);
create or replace view aggJoin2043524964222473325 as (
with aggView5668152818609128640 as (select v3 from aggJoin1268462047022491205 group by v3)
select id as v3 from title as t, aggView5668152818609128640 where t.id=aggView5668152818609128640.v3);
create or replace view aggJoin7151194110741157958 as (
with aggView8182067710760387275 as (select v3 from aggJoin2043524964222473325 group by v3)
select v3 from aggJoin42527994527844707 join aggView8182067710760387275 using(v3));
create or replace view aggJoin6135710530218697476 as (
with aggView7440547200679609928 as (select v3 from aggJoin7151194110741157958 group by v3)
select v47 as v47 from aggJoin5764352754898977056 join aggView7440547200679609928 using(v3));
select MIN(v47) as v47 from aggJoin6135710530218697476;
