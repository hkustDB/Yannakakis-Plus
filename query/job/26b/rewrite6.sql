create or replace view aggView534485095777862646 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin7008849649314139249 as (
with aggView7635825837928677404 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView7635825837928677404 where t.kind_id=aggView7635825837928677404.v28 and production_year>2005);
create or replace view aggJoin5293503775060807722 as (
with aggView1975087121552522201 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView1975087121552522201 where mk.keyword_id=aggView1975087121552522201.v25);
create or replace view aggJoin8588328000456479252 as (
with aggView2033176095628155548 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView2033176095628155548 where mi_idx.info_type_id=aggView2033176095628155548.v23 and info>'8.0');
create or replace view aggView3455428032787026415 as select v47, v33 from aggJoin8588328000456479252 group by v47,v33;
create or replace view aggJoin8720443301095900050 as (
with aggView1489647815650633820 as (select v47 from aggJoin5293503775060807722 group by v47)
select movie_id as v47, subject_id as v5, status_id as v7 from complete_cast as cc, aggView1489647815650633820 where cc.movie_id=aggView1489647815650633820.v47);
create or replace view aggJoin4219162155832099811 as (
with aggView5956303574495301371 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v5 from aggJoin8720443301095900050 join aggView5956303574495301371 using(v7));
create or replace view aggJoin8689084247265449938 as (
with aggView6411604767622590296 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin4219162155832099811 join aggView6411604767622590296 using(v5));
create or replace view aggJoin7461124925315542509 as (
with aggView243254558701728838 as (select v47 from aggJoin8689084247265449938 group by v47)
select v47, v48, v51 from aggJoin7008849649314139249 join aggView243254558701728838 using(v47));
create or replace view aggView527222783918875248 as select v47, v48 from aggJoin7461124925315542509 group by v47,v48;
create or replace view aggJoin3826582608440362921 as (
with aggView7045675187771291119 as (select v9, MIN(v10) as v59 from aggView534485095777862646 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView7045675187771291119 where ci.person_role_id=aggView7045675187771291119.v9);
create or replace view aggJoin3874321816829106984 as (
with aggView8174834588129379809 as (select v47, MIN(v48) as v61 from aggView527222783918875248 group by v47)
select v38, v47, v59 as v59, v61 from aggJoin3826582608440362921 join aggView8174834588129379809 using(v47));
create or replace view aggJoin685315062612750397 as (
with aggView3086318067413978809 as (select id as v38 from name as n)
select v47, v59, v61 from aggJoin3874321816829106984 join aggView3086318067413978809 using(v38));
create or replace view aggJoin7083609952664688716 as (
with aggView3580756634484305797 as (select v47, MIN(v59) as v59, MIN(v61) as v61 from aggJoin685315062612750397 group by v47,v59,v61)
select v33, v59, v61 from aggView3455428032787026415 join aggView3580756634484305797 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin7083609952664688716;
