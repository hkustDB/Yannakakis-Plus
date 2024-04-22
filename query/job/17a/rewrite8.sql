create or replace view aggJoin69592569310775398 as (
with aggView8779081215422203450 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView8779081215422203450 where mc.company_id=aggView8779081215422203450.v20);
create or replace view aggJoin3210794097457763223 as (
with aggView1090802358466467994 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView1090802358466467994 where ci.movie_id=aggView1090802358466467994.v3);
create or replace view aggJoin4557811872685830723 as (
with aggView3819247376272844202 as (select v3 from aggJoin69592569310775398 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView3819247376272844202 where mk.movie_id=aggView3819247376272844202.v3);
create or replace view aggJoin5669072167310729227 as (
with aggView5146382440232332809 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin4557811872685830723 join aggView5146382440232332809 using(v25));
create or replace view aggJoin5013210952587159080 as (
with aggView1121880146419430865 as (select v3 from aggJoin5669072167310729227 group by v3)
select v26 from aggJoin3210794097457763223 join aggView1121880146419430865 using(v3));
create or replace view aggJoin916332748723947033 as (
with aggView2745636058282128995 as (select v26 from aggJoin5013210952587159080 group by v26)
select name as v27 from name as n, aggView2745636058282128995 where n.id=aggView2745636058282128995.v26);
create or replace view aggJoin8153017726628270463 as (
with aggView291151240478922276 as (select v27 from aggJoin916332748723947033 group by v27)
select v27 from aggView291151240478922276 where v27 LIKE 'B%');
select MIN(v27) as v47 from aggJoin8153017726628270463;
