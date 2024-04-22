create or replace view aggJoin4885652703153836314 as (
with aggView8275026470211473291 as (select id as v3 from title as t)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView8275026470211473291 where mk.movie_id=aggView8275026470211473291.v3);
create or replace view aggJoin5364792828768289909 as (
with aggView6948791599365107203 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView6948791599365107203 where mc.company_id=aggView6948791599365107203.v20);
create or replace view aggJoin2572812209726085060 as (
with aggView2466374000033883181 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin4885652703153836314 join aggView2466374000033883181 using(v25));
create or replace view aggJoin7176060673469642817 as (
with aggView4984058697794111572 as (select v3 from aggJoin2572812209726085060 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView4984058697794111572 where ci.movie_id=aggView4984058697794111572.v3);
create or replace view aggJoin7678104365530193481 as (
with aggView1088578461174481541 as (select v3 from aggJoin5364792828768289909 group by v3)
select v26 from aggJoin7176060673469642817 join aggView1088578461174481541 using(v3));
create or replace view aggJoin6510615591218102590 as (
with aggView783455394153738154 as (select v26 from aggJoin7678104365530193481 group by v26)
select name as v27 from name as n, aggView783455394153738154 where n.id=aggView783455394153738154.v26 and name LIKE 'Z%');
create or replace view aggView8920437434114834546 as select v27 from aggJoin6510615591218102590 group by v27;
select MIN(v27) as v47 from aggView8920437434114834546;
