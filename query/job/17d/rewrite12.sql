create or replace view aggJoin6910902901841462995 as (
with aggView2838025145561945131 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView2838025145561945131 where ci.person_id=aggView2838025145561945131.v26);
create or replace view aggJoin4566071541485018675 as (
with aggView3594463092166532274 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView3594463092166532274 where mc.company_id=aggView3594463092166532274.v20);
create or replace view aggJoin5307779063418237885 as (
with aggView6962728379361644189 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6962728379361644189 where mk.keyword_id=aggView6962728379361644189.v25);
create or replace view aggJoin7384416762987631457 as (
with aggView4604621844246161553 as (select v3 from aggJoin5307779063418237885 group by v3)
select v3 from aggJoin4566071541485018675 join aggView4604621844246161553 using(v3));
create or replace view aggJoin2782044266361600357 as (
with aggView466033809469542437 as (select v3 from aggJoin7384416762987631457 group by v3)
select id as v3 from title as t, aggView466033809469542437 where t.id=aggView466033809469542437.v3);
create or replace view aggJoin2296844964643841295 as (
with aggView8924063338316982403 as (select v3 from aggJoin2782044266361600357 group by v3)
select v47 as v47 from aggJoin6910902901841462995 join aggView8924063338316982403 using(v3));
select MIN(v47) as v47 from aggJoin2296844964643841295;
