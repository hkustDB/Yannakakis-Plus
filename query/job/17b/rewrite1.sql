create or replace view aggJoin6440422766214967327 as (
with aggView1622957717760757693 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView1622957717760757693 where mc.movie_id=aggView1622957717760757693.v3);
create or replace view aggJoin90640562023848126 as (
with aggView7835954317067923890 as (select id as v20 from company_name as cn)
select v3 from aggJoin6440422766214967327 join aggView7835954317067923890 using(v20));
create or replace view aggJoin2062566346483952142 as (
with aggView6638891042566532850 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6638891042566532850 where mk.keyword_id=aggView6638891042566532850.v25);
create or replace view aggJoin6673297421906215324 as (
with aggView1919774143754937851 as (select v3 from aggJoin90640562023848126 group by v3)
select v3 from aggJoin2062566346483952142 join aggView1919774143754937851 using(v3));
create or replace view aggJoin6054919499767134543 as (
with aggView2275465047313862670 as (select v3 from aggJoin6673297421906215324 group by v3)
select person_id as v26 from cast_info as ci, aggView2275465047313862670 where ci.movie_id=aggView2275465047313862670.v3);
create or replace view aggJoin2095990150479738986 as (
with aggView766387388534642200 as (select v26 from aggJoin6054919499767134543 group by v26)
select name as v27 from name as n, aggView766387388534642200 where n.id=aggView766387388534642200.v26);
create or replace view aggJoin7843571934277164709 as (
with aggView6897848796877597560 as (select v27 from aggJoin2095990150479738986 group by v27)
select v27 from aggView6897848796877597560 where v27 LIKE 'Z%');
select MIN(v27) as v47 from aggJoin7843571934277164709;
