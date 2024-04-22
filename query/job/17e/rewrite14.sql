create or replace view aggJoin8697241425380603665 as (
with aggView7097410504181950003 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView7097410504181950003 where ci.person_id=aggView7097410504181950003.v26);
create or replace view aggJoin4667921552909097719 as (
with aggView6350888631068067336 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView6350888631068067336 where mc.movie_id=aggView6350888631068067336.v3);
create or replace view aggJoin7929362146564154768 as (
with aggView2126250348896091502 as (select id as v20 from company_name as cn where country_code= '[us]')
select v3 from aggJoin4667921552909097719 join aggView2126250348896091502 using(v20));
create or replace view aggJoin4872640293185315274 as (
with aggView8289975646805364901 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8289975646805364901 where mk.keyword_id=aggView8289975646805364901.v25);
create or replace view aggJoin5341966305062625168 as (
with aggView1166305315091532255 as (select v3 from aggJoin7929362146564154768 group by v3)
select v3 from aggJoin4872640293185315274 join aggView1166305315091532255 using(v3));
create or replace view aggJoin1971017200189245351 as (
with aggView219577021784763210 as (select v3 from aggJoin5341966305062625168 group by v3)
select v47 as v47 from aggJoin8697241425380603665 join aggView219577021784763210 using(v3));
select MIN(v47) as v47 from aggJoin1971017200189245351;
