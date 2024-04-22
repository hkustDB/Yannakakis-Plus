create or replace view aggJoin7190974938219835558 as (
with aggView6080169671386417899 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView6080169671386417899 where mc.company_id=aggView6080169671386417899.v20);
create or replace view aggJoin3679031709484736824 as (
with aggView4166992419141016080 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView4166992419141016080 where ci.movie_id=aggView4166992419141016080.v3);
create or replace view aggJoin5427915385586664689 as (
with aggView8857127046435460048 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8857127046435460048 where mk.keyword_id=aggView8857127046435460048.v25);
create or replace view aggJoin3344340876453724258 as (
with aggView5946515324026455707 as (select v3 from aggJoin5427915385586664689 group by v3)
select v3 from aggJoin7190974938219835558 join aggView5946515324026455707 using(v3));
create or replace view aggJoin407135856041325231 as (
with aggView8580577360702752403 as (select v3 from aggJoin3344340876453724258 group by v3)
select v26 from aggJoin3679031709484736824 join aggView8580577360702752403 using(v3));
create or replace view aggJoin8005281079136233047 as (
with aggView1188078868023214517 as (select v26 from aggJoin407135856041325231 group by v26)
select name as v27 from name as n, aggView1188078868023214517 where n.id=aggView1188078868023214517.v26);
create or replace view aggJoin3470411683748381394 as (
with aggView514264350526250403 as (select v27 from aggJoin8005281079136233047 group by v27)
select v27 from aggView514264350526250403 where v27 LIKE '%Bert%');
select MIN(v27) as v47 from aggJoin3470411683748381394;
