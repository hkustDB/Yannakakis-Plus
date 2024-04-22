create or replace view aggView3367940548623717454 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggView4869900719859018578 as select id as v38, name as v39 from name as n;
create or replace view aggJoin5460324870135678677 as (
with aggView6036591186508696808 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView6036591186508696808 where t.kind_id=aggView6036591186508696808.v28 and production_year>2000);
create or replace view aggJoin2966565528816780427 as (
with aggView6362406356804114400 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView6362406356804114400 where mi_idx.info_type_id=aggView6362406356804114400.v23 and info>'7.0');
create or replace view aggView1311360789248568012 as select v33, v47 from aggJoin2966565528816780427 group by v33,v47;
create or replace view aggJoin4372324091847831833 as (
with aggView1699313399127182067 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView1699313399127182067 where cc.subject_id=aggView1699313399127182067.v5);
create or replace view aggJoin4806214434452451935 as (
with aggView7739997898500577937 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin4372324091847831833 join aggView7739997898500577937 using(v7));
create or replace view aggJoin5930536991790036138 as (
with aggView42467870635466955 as (select v47 from aggJoin4806214434452451935 group by v47)
select v47, v48, v51 from aggJoin5460324870135678677 join aggView42467870635466955 using(v47));
create or replace view aggView4152356335453407230 as select v48, v47 from aggJoin5930536991790036138 group by v48,v47;
create or replace view aggJoin5513757464933310760 as (
with aggView5762166283942740778 as (select v47, MIN(v48) as v62 from aggView4152356335453407230 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v62 from cast_info as ci, aggView5762166283942740778 where ci.movie_id=aggView5762166283942740778.v47);
create or replace view aggJoin3988294876473297917 as (
with aggView8696581924416963947 as (select v38, MIN(v39) as v61 from aggView4869900719859018578 group by v38)
select v47, v9, v62 as v62, v61 from aggJoin5513757464933310760 join aggView8696581924416963947 using(v38));
create or replace view aggJoin5641846157058886725 as (
with aggView613034176540828575 as (select v47, MIN(v33) as v60 from aggView1311360789248568012 group by v47)
select v47, v9, v62 as v62, v61 as v61, v60 from aggJoin3988294876473297917 join aggView613034176540828575 using(v47));
create or replace view aggJoin1698163926639401390 as (
with aggView8944244306232291369 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView8944244306232291369 where mk.keyword_id=aggView8944244306232291369.v25);
create or replace view aggJoin6282956582883593405 as (
with aggView8458962401178322144 as (select v47 from aggJoin1698163926639401390 group by v47)
select v9, v62 as v62, v61 as v61, v60 as v60 from aggJoin5641846157058886725 join aggView8458962401178322144 using(v47));
create or replace view aggJoin6575318489608685541 as (
with aggView7205263661326511472 as (select v9, MIN(v62) as v62, MIN(v61) as v61, MIN(v60) as v60 from aggJoin6282956582883593405 group by v9,v61,v60,v62)
select v10, v62, v61, v60 from aggView3367940548623717454 join aggView7205263661326511472 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin6575318489608685541;
