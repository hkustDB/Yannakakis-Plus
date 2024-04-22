create or replace view aggView8205960744558488106 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin789923013685393310 as (
with aggView5852855732731233621 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5852855732731233621 where mi_idx.info_type_id=aggView5852855732731233621.v23);
create or replace view aggView6702347347410443993 as select v33, v47 from aggJoin789923013685393310 group by v33,v47;
create or replace view aggJoin1190450880299752349 as (
with aggView5180150162250765521 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView5180150162250765521 where t.kind_id=aggView5180150162250765521.v28 and production_year>2000);
create or replace view aggView6632541722262832452 as select v48, v47 from aggJoin1190450880299752349 group by v48,v47;
create or replace view aggJoin5437530643565673060 as (
with aggView3575517079052479163 as (select v47, MIN(v33) as v60 from aggView6702347347410443993 group by v47)
select v48, v47, v60 from aggView6632541722262832452 join aggView3575517079052479163 using(v47));
create or replace view aggJoin3962910181567937177 as (
with aggView6239851400695854950 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin5437530643565673060 group by v47,v60)
select person_id as v38, movie_id as v47, person_role_id as v9, v60, v61 from cast_info as ci, aggView6239851400695854950 where ci.movie_id=aggView6239851400695854950.v47);
create or replace view aggJoin2503344015115040984 as (
with aggView3230672132516236665 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView3230672132516236665 where cc.status_id=aggView3230672132516236665.v7);
create or replace view aggJoin425014797939671200 as (
with aggView8294157886942373185 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin2503344015115040984 join aggView8294157886942373185 using(v5));
create or replace view aggJoin5360529844818687439 as (
with aggView4375234100834950100 as (select v47 from aggJoin425014797939671200 group by v47)
select movie_id as v47, keyword_id as v25 from movie_keyword as mk, aggView4375234100834950100 where mk.movie_id=aggView4375234100834950100.v47);
create or replace view aggJoin8249069075622749172 as (
with aggView7829052436722050724 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47 from aggJoin5360529844818687439 join aggView7829052436722050724 using(v25));
create or replace view aggJoin8685612811084121449 as (
with aggView859003863768292623 as (select v47 from aggJoin8249069075622749172 group by v47)
select v38, v9, v60 as v60, v61 as v61 from aggJoin3962910181567937177 join aggView859003863768292623 using(v47));
create or replace view aggJoin7929326860895322433 as (
with aggView847529023059746561 as (select id as v38 from name as n)
select v9, v60, v61 from aggJoin8685612811084121449 join aggView847529023059746561 using(v38));
create or replace view aggJoin1300313437996125157 as (
with aggView9028908412182994396 as (select v9, MIN(v60) as v60, MIN(v61) as v61 from aggJoin7929326860895322433 group by v9,v61,v60)
select v10, v60, v61 from aggView8205960744558488106 join aggView9028908412182994396 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1300313437996125157;
