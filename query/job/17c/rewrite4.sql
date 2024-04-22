create or replace view aggJoin6756848002981065435 as (
with aggView3903410838514755312 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView3903410838514755312 where mk.keyword_id=aggView3903410838514755312.v25);
create or replace view aggJoin6061409131172910510 as (
with aggView3821332070879409846 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView3821332070879409846 where mc.company_id=aggView3821332070879409846.v20);
create or replace view aggJoin8512044069412342108 as (
with aggView2329687556573632147 as (select v3 from aggJoin6061409131172910510 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView2329687556573632147 where ci.movie_id=aggView2329687556573632147.v3);
create or replace view aggJoin6049396705562562086 as (
with aggView3882558043055705370 as (select id as v3 from title as t)
select v3 from aggJoin6756848002981065435 join aggView3882558043055705370 using(v3));
create or replace view aggJoin6120708110297011634 as (
with aggView5841261792986329247 as (select v3 from aggJoin6049396705562562086 group by v3)
select v26 from aggJoin8512044069412342108 join aggView5841261792986329247 using(v3));
create or replace view aggJoin4058096866017875523 as (
with aggView3523539938931150605 as (select v26 from aggJoin6120708110297011634 group by v26)
select name as v27 from name as n, aggView3523539938931150605 where n.id=aggView3523539938931150605.v26 and name LIKE 'X%');
create or replace view aggView1456024029305589465 as select v27 from aggJoin4058096866017875523 group by v27;
select MIN(v27) as v47 from aggView1456024029305589465;
