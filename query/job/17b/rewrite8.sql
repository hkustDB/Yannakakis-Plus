create or replace view aggJoin3799532133594139635 as (
with aggView1335549840808971322 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView1335549840808971322 where mc.movie_id=aggView1335549840808971322.v3);
create or replace view aggJoin2798496315968458224 as (
with aggView6754574748573435017 as (select id as v20 from company_name as cn)
select v3 from aggJoin3799532133594139635 join aggView6754574748573435017 using(v20));
create or replace view aggJoin5137567294924289337 as (
with aggView6641090784723940669 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6641090784723940669 where mk.keyword_id=aggView6641090784723940669.v25);
create or replace view aggJoin8374529937930835621 as (
with aggView3731159595616789263 as (select v3 from aggJoin5137567294924289337 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView3731159595616789263 where ci.movie_id=aggView3731159595616789263.v3);
create or replace view aggJoin4170908686340768424 as (
with aggView6389085212095712840 as (select v3 from aggJoin2798496315968458224 group by v3)
select v26 from aggJoin8374529937930835621 join aggView6389085212095712840 using(v3));
create or replace view aggJoin7849062253486528722 as (
with aggView352536126746053194 as (select v26 from aggJoin4170908686340768424 group by v26)
select name as v27 from name as n, aggView352536126746053194 where n.id=aggView352536126746053194.v26 and name LIKE 'Z%');
create or replace view aggView5057441203934405161 as select v27 from aggJoin7849062253486528722 group by v27;
select MIN(v27) as v47 from aggView5057441203934405161;
