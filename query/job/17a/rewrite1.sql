create or replace view aggJoin1397012480611336389 as (
with aggView2788501962567503023 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView2788501962567503023 where mc.company_id=aggView2788501962567503023.v20);
create or replace view aggJoin3478593370858512782 as (
with aggView577435458628782109 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView577435458628782109 where mk.keyword_id=aggView577435458628782109.v25);
create or replace view aggJoin1871911011003842657 as (
with aggView6062843037949820020 as (select v3 from aggJoin3478593370858512782 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView6062843037949820020 where ci.movie_id=aggView6062843037949820020.v3);
create or replace view aggJoin4168334101065666785 as (
with aggView1078929501524263980 as (select id as v3 from title as t)
select v3 from aggJoin1397012480611336389 join aggView1078929501524263980 using(v3));
create or replace view aggJoin5953204095156992397 as (
with aggView8287426881736674249 as (select v3 from aggJoin4168334101065666785 group by v3)
select v26 from aggJoin1871911011003842657 join aggView8287426881736674249 using(v3));
create or replace view aggJoin4927838715312699338 as (
with aggView8848097273783991512 as (select v26 from aggJoin5953204095156992397 group by v26)
select name as v27 from name as n, aggView8848097273783991512 where n.id=aggView8848097273783991512.v26);
create or replace view aggJoin3218196788760561370 as (
with aggView2963775482394208133 as (select v27 from aggJoin4927838715312699338 group by v27)
select v27 from aggView2963775482394208133 where v27 LIKE 'B%');
select MIN(v27) as v47 from aggJoin3218196788760561370;
