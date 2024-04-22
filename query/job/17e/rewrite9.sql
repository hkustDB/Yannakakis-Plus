create or replace view aggJoin1090338835276471365 as (
with aggView5585383788530961607 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView5585383788530961607 where mc.company_id=aggView5585383788530961607.v20);
create or replace view aggJoin1909393585678784875 as (
with aggView352764984503981589 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView352764984503981589 where mk.keyword_id=aggView352764984503981589.v25);
create or replace view aggJoin6609002644558206300 as (
with aggView6967905842675905170 as (select v3 from aggJoin1909393585678784875 group by v3)
select v3 from aggJoin1090338835276471365 join aggView6967905842675905170 using(v3));
create or replace view aggJoin392924660730057553 as (
with aggView1172050769509896642 as (select v3 from aggJoin6609002644558206300 group by v3)
select id as v3 from title as t, aggView1172050769509896642 where t.id=aggView1172050769509896642.v3);
create or replace view aggJoin1448633804417866241 as (
with aggView8796378068946645091 as (select v3 from aggJoin392924660730057553 group by v3)
select person_id as v26 from cast_info as ci, aggView8796378068946645091 where ci.movie_id=aggView8796378068946645091.v3);
create or replace view aggJoin1132196754529117367 as (
with aggView3607442403726130580 as (select v26 from aggJoin1448633804417866241 group by v26)
select name as v27 from name as n, aggView3607442403726130580 where n.id=aggView3607442403726130580.v26);
create or replace view aggView8903239580551330861 as select v27 from aggJoin1132196754529117367 group by v27;
select MIN(v27) as v47 from aggView8903239580551330861;
