create or replace view aggJoin5285084758377555048 as (
with aggView5036822084030702508 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView5036822084030702508 where ci.person_id=aggView5036822084030702508.v26);
create or replace view aggJoin6275778558551308495 as (
with aggView4169465372764885802 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4169465372764885802 where mk.keyword_id=aggView4169465372764885802.v25);
create or replace view aggJoin4117333793528470301 as (
with aggView3004992179321839821 as (select v3 from aggJoin6275778558551308495 group by v3)
select id as v3 from title as t, aggView3004992179321839821 where t.id=aggView3004992179321839821.v3);
create or replace view aggJoin7736812152878629586 as (
with aggView1733717100089233611 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1733717100089233611 where mc.company_id=aggView1733717100089233611.v20);
create or replace view aggJoin6824244788158766645 as (
with aggView825972297993113148 as (select v3 from aggJoin7736812152878629586 group by v3)
select v3 from aggJoin4117333793528470301 join aggView825972297993113148 using(v3));
create or replace view aggJoin1956056421034996346 as (
with aggView8036241654549776915 as (select v3 from aggJoin6824244788158766645 group by v3)
select v47 as v47 from aggJoin5285084758377555048 join aggView8036241654549776915 using(v3));
select MIN(v47) as v47 from aggJoin1956056421034996346;
