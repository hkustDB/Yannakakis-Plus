create or replace view aggJoin4808947568314858645 as (
with aggView5979968926428508145 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView5979968926428508145 where mc.company_id=aggView5979968926428508145.v1);
create or replace view aggJoin4094169018287344667 as (
with aggView8895157290219176677 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin4808947568314858645 join aggView8895157290219176677 using(v8));
create or replace view aggJoin3474341410038138650 as (
with aggView2924860080213117331 as (select v22, MIN(v43) as v43 from aggJoin4094169018287344667 group by v22,v43)
select movie_id as v22, info_type_id as v10, info as v29, v43 from movie_info_idx as miidx, aggView2924860080213117331 where miidx.movie_id=aggView2924860080213117331.v22);
create or replace view aggJoin6829398623295930864 as (
with aggView546194466431872541 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView546194466431872541 where t.kind_id=aggView546194466431872541.v14);
create or replace view aggJoin6903608989504074586 as (
with aggView7540759239938629043 as (select v22, MIN(v32) as v45 from aggJoin6829398623295930864 group by v22)
select movie_id as v22, info_type_id as v12, v45 from movie_info as mi, aggView7540759239938629043 where mi.movie_id=aggView7540759239938629043.v22);
create or replace view aggJoin7648403559914842831 as (
with aggView750688853634290863 as (select id as v12 from info_type as it2 where info= 'release dates')
select v22, v45 from aggJoin6903608989504074586 join aggView750688853634290863 using(v12));
create or replace view aggJoin4535111233812693567 as (
with aggView115259085213122287 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29, v43 from aggJoin3474341410038138650 join aggView115259085213122287 using(v10));
create or replace view aggJoin7153750910032318257 as (
with aggView2830203550701559693 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin4535111233812693567 group by v22,v43)
select v45 as v45, v43, v44 from aggJoin7648403559914842831 join aggView2830203550701559693 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7153750910032318257;
