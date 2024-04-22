create or replace view aggJoin3526488629743713422 as (
with aggView1737095232557419406 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView1737095232557419406 where mi.info_type_id=aggView1737095232557419406.v21);
create or replace view aggJoin6131598441370375154 as (
with aggView6892604887353076413 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView6892604887353076413 where mc.company_id=aggView6892604887353076413.v1);
create or replace view aggJoin3463054889551530135 as (
with aggView841109167449235289 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView841109167449235289 where mi_idx.info_type_id=aggView841109167449235289.v26);
create or replace view aggJoin8284046043986101750 as (
with aggView4197668654697059186 as (select v29 from aggJoin3463054889551530135 group by v29)
select v29, v22 from aggJoin3526488629743713422 join aggView4197668654697059186 using(v29));
create or replace view aggView7085909422025492534 as select v29, v22 from aggJoin8284046043986101750 group by v29,v22;
create or replace view aggJoin118628210065999714 as (
with aggView1760818224606124388 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin6131598441370375154 join aggView1760818224606124388 using(v8));
create or replace view aggJoin2881224893141736585 as (
with aggView2737021379650840542 as (select v29 from aggJoin118628210065999714 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView2737021379650840542 where t.id=aggView2737021379650840542.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggView8064021761525661105 as select v29, v30 from aggJoin2881224893141736585 group by v29,v30;
create or replace view aggJoin2391890308173708537 as (
with aggView703444521115988373 as (select v29, MIN(v22) as v41 from aggView7085909422025492534 group by v29)
select v30, v41 from aggView8064021761525661105 join aggView703444521115988373 using(v29));
select MIN(v41) as v41,MIN(v30) as v42 from aggJoin2391890308173708537;
