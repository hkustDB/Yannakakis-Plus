create or replace view aggJoin4843396068331670466 as (
with aggView3127263145567231216 as (select id as v24, name as v50 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%')
select person_id as v24, name as v3, v50 from aka_name as an, aggView3127263145567231216 where an.person_id=aggView3127263145567231216.v24 and name LIKE '%a%');
create or replace view aggJoin4168067181264646018 as (
with aggView2349732634548273464 as (select v24, MIN(v50) as v50 from aggJoin4843396068331670466 group by v24,v50)
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView2349732634548273464 where ci.person_id=aggView2349732634548273464.v24);
create or replace view aggJoin4572210892982948186 as (
with aggView7146404031755503411 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView7146404031755503411 where pi.info_type_id=aggView7146404031755503411.v16 and note= 'Volker Boehm');
create or replace view aggJoin1381026810233105935 as (
with aggView8189572402875761231 as (select v24 from aggJoin4572210892982948186 group by v24)
select v38, v50 as v50 from aggJoin4168067181264646018 join aggView8189572402875761231 using(v24));
create or replace view aggJoin3692023906602392931 as (
with aggView804049498653575302 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView804049498653575302 where ml.link_type_id=aggView804049498653575302.v18);
create or replace view aggJoin5484095831199143388 as (
with aggView5615250399870839145 as (select v38 from aggJoin3692023906602392931 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView5615250399870839145 where t.id=aggView5615250399870839145.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggJoin3987431879615096826 as (
with aggView4231807364722748123 as (select v38, MIN(v39) as v51 from aggJoin5484095831199143388 group by v38)
select v50 as v50, v51 from aggJoin1381026810233105935 join aggView4231807364722748123 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin3987431879615096826;
