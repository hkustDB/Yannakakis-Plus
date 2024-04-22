create or replace view aggView1516197497973404955 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin1865752507880741760 as (
with aggView4269504445063778553 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4269504445063778553 where t.kind_id=aggView4269504445063778553.v28 and production_year>2005);
create or replace view aggView5358973232825867747 as select v47, v48 from aggJoin1865752507880741760 group by v47,v48;
create or replace view aggJoin5187211467046445409 as (
with aggView3123611624856349439 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView3123611624856349439 where mi_idx.info_type_id=aggView3123611624856349439.v23);
create or replace view aggJoin3301839735794565723 as (
with aggView4966645634292120794 as (select v47, v33 from aggJoin5187211467046445409 group by v47,v33)
select v47, v33 from aggView4966645634292120794 where v33>'8.0');
create or replace view aggJoin1919605899574100562 as (
with aggView4737611911982000436 as (select v47, MIN(v33) as v60 from aggJoin3301839735794565723 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v60 from cast_info as ci, aggView4737611911982000436 where ci.movie_id=aggView4737611911982000436.v47);
create or replace view aggJoin9199489480508529909 as (
with aggView8500354320736082661 as (select v47, MIN(v48) as v61 from aggView5358973232825867747 group by v47)
select v38, v47, v9, v60 as v60, v61 from aggJoin1919605899574100562 join aggView8500354320736082661 using(v47));
create or replace view aggJoin991516356214572965 as (
with aggView8361155224195478572 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView8361155224195478572 where mk.keyword_id=aggView8361155224195478572.v25);
create or replace view aggJoin7610105509002416830 as (
with aggView6692538607233740131 as (select v47 from aggJoin991516356214572965 group by v47)
select movie_id as v47, subject_id as v5, status_id as v7 from complete_cast as cc, aggView6692538607233740131 where cc.movie_id=aggView6692538607233740131.v47);
create or replace view aggJoin3592184014907668876 as (
with aggView2387639020737806724 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v5 from aggJoin7610105509002416830 join aggView2387639020737806724 using(v7));
create or replace view aggJoin4619679299749773972 as (
with aggView6565593183560219894 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin3592184014907668876 join aggView6565593183560219894 using(v5));
create or replace view aggJoin2960786536329489428 as (
with aggView4833204600647977272 as (select v47 from aggJoin4619679299749773972 group by v47)
select v38, v9, v60 as v60, v61 as v61 from aggJoin9199489480508529909 join aggView4833204600647977272 using(v47));
create or replace view aggJoin8774099572417634999 as (
with aggView8966893867102190388 as (select id as v38 from name as n)
select v9, v60, v61 from aggJoin2960786536329489428 join aggView8966893867102190388 using(v38));
create or replace view aggJoin5319059292915815521 as (
with aggView4326895777146408933 as (select v9, MIN(v60) as v60, MIN(v61) as v61 from aggJoin8774099572417634999 group by v9,v61,v60)
select v10, v60, v61 from aggView1516197497973404955 join aggView4326895777146408933 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin5319059292915815521;
