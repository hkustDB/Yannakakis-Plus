create or replace view aggJoin6758441425245723842 as (
with aggView7365716512928388426 as (select id as v31, title as v44 from title as t where production_year>2010)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView7365716512928388426 where ci.movie_id=aggView7365716512928388426.v31 and note LIKE '%(producer)%');
create or replace view aggJoin2878972174406801198 as (
with aggView6440441274231156965 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v1, v12, v44 from aggJoin6758441425245723842 join aggView6440441274231156965 using(v29));
create or replace view aggJoin1485351090727739894 as (
with aggView3802479918954845725 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView3802479918954845725 where mc.company_type_id=aggView3802479918954845725.v22);
create or replace view aggJoin3385604092533540779 as (
with aggView633040905480934520 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin1485351090727739894 join aggView633040905480934520 using(v15));
create or replace view aggJoin2604846732043457370 as (
with aggView707608241938109884 as (select v31 from aggJoin3385604092533540779 group by v31)
select v1, v12, v44 as v44 from aggJoin2878972174406801198 join aggView707608241938109884 using(v31));
create or replace view aggJoin84004867050616588 as (
with aggView4883577173577118032 as (select v1, MIN(v44) as v44 from aggJoin2604846732043457370 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView4883577173577118032 where chn.id=aggView4883577173577118032.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin84004867050616588;
