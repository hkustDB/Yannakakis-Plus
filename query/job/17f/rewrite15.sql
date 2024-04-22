create or replace view aggJoin4291630812602495437 as (
with aggView6928876411000418944 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView6928876411000418944 where ci.person_id=aggView6928876411000418944.v26);
create or replace view aggJoin8356088875216920576 as (
with aggView3154132711236263176 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView3154132711236263176 where mk.keyword_id=aggView3154132711236263176.v25);
create or replace view aggJoin5735340386529571147 as (
with aggView5859378058035471960 as (select v3 from aggJoin8356088875216920576 group by v3)
select id as v3 from title as t, aggView5859378058035471960 where t.id=aggView5859378058035471960.v3);
create or replace view aggJoin6721060120750870268 as (
with aggView8916398029627157548 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8916398029627157548 where mc.company_id=aggView8916398029627157548.v20);
create or replace view aggJoin966787141886182856 as (
with aggView5657323883614384583 as (select v3 from aggJoin5735340386529571147 group by v3)
select v3 from aggJoin6721060120750870268 join aggView5657323883614384583 using(v3));
create or replace view aggJoin4340227042656318505 as (
with aggView3974373935749459190 as (select v3 from aggJoin966787141886182856 group by v3)
select v47 as v47 from aggJoin4291630812602495437 join aggView3974373935749459190 using(v3));
select MIN(v47) as v47 from aggJoin4340227042656318505;
