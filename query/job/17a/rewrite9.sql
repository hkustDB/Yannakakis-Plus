create or replace view aggJoin5278834792381917825 as (
with aggView3908250333911375291 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView3908250333911375291 where mc.company_id=aggView3908250333911375291.v20);
create or replace view aggJoin8641928392417100918 as (
with aggView7166374551560116827 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7166374551560116827 where mk.keyword_id=aggView7166374551560116827.v25);
create or replace view aggJoin1037026066545859174 as (
with aggView5768449785755034703 as (select id as v3 from title as t)
select v3 from aggJoin5278834792381917825 join aggView5768449785755034703 using(v3));
create or replace view aggJoin6674009097211859883 as (
with aggView7014675805591112172 as (select v3 from aggJoin1037026066545859174 group by v3)
select v3 from aggJoin8641928392417100918 join aggView7014675805591112172 using(v3));
create or replace view aggJoin1941767510073482835 as (
with aggView8396553618718247126 as (select v3 from aggJoin6674009097211859883 group by v3)
select person_id as v26 from cast_info as ci, aggView8396553618718247126 where ci.movie_id=aggView8396553618718247126.v3);
create or replace view aggJoin8104252662402115588 as (
with aggView7399682177209947887 as (select v26 from aggJoin1941767510073482835 group by v26)
select name as v27 from name as n, aggView7399682177209947887 where n.id=aggView7399682177209947887.v26);
create or replace view aggJoin6918511282454382453 as (
with aggView7523563849786565067 as (select v27 from aggJoin8104252662402115588 group by v27)
select v27 from aggView7523563849786565067 where v27 LIKE 'B%');
select MIN(v27) as v47 from aggJoin6918511282454382453;
