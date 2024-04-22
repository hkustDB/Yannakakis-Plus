create or replace view aggJoin2463658048309854827 as (
with aggView7917304752888450055 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView7917304752888450055 where mi.info_type_id=aggView7917304752888450055.v21);
create or replace view aggView263324053068925051 as select v29, v22 from aggJoin2463658048309854827 group by v29,v22;
create or replace view aggJoin1536504774340122940 as (
with aggView7211218965339671041 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView7211218965339671041 where mc.company_id=aggView7211218965339671041.v1);
create or replace view aggJoin1129849401932399299 as (
with aggView3420805910443696653 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin1536504774340122940 join aggView3420805910443696653 using(v8));
create or replace view aggJoin7845556230187835017 as (
with aggView8275249023926906738 as (select v29 from aggJoin1129849401932399299 group by v29)
select movie_id as v29, info_type_id as v26 from movie_info_idx as mi_idx, aggView8275249023926906738 where mi_idx.movie_id=aggView8275249023926906738.v29);
create or replace view aggJoin9026216965946170947 as (
with aggView6204121403698943990 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29 from aggJoin7845556230187835017 join aggView6204121403698943990 using(v26));
create or replace view aggJoin5439164370770857634 as (
with aggView6735988426003007539 as (select v29 from aggJoin9026216965946170947 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView6735988426003007539 where t.id=aggView6735988426003007539.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggView5980199191892179842 as select v29, v30 from aggJoin5439164370770857634 group by v29,v30;
create or replace view aggJoin4061866829055556764 as (
with aggView7219906155091699703 as (select v29, MIN(v30) as v42 from aggView5980199191892179842 group by v29)
select v22, v42 from aggView263324053068925051 join aggView7219906155091699703 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin4061866829055556764;
