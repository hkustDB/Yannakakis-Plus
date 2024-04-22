create or replace view aggJoin329848747663507772 as (
with aggView9094938574420312679 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView9094938574420312679 where ci.movie_id=aggView9094938574420312679.v3);
create or replace view aggJoin5144491294510771471 as (
with aggView3981231223535009695 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView3981231223535009695 where mc.company_id=aggView3981231223535009695.v20);
create or replace view aggJoin5186293926768897565 as (
with aggView9124566829585279072 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView9124566829585279072 where mk.keyword_id=aggView9124566829585279072.v25);
create or replace view aggJoin2071496717387052964 as (
with aggView4760683293349216500 as (select v3 from aggJoin5144491294510771471 group by v3)
select v3 from aggJoin5186293926768897565 join aggView4760683293349216500 using(v3));
create or replace view aggJoin7162090358604655785 as (
with aggView6286681425248467072 as (select v3 from aggJoin2071496717387052964 group by v3)
select v26 from aggJoin329848747663507772 join aggView6286681425248467072 using(v3));
create or replace view aggJoin701011968198652868 as (
with aggView3769946054065912704 as (select v26 from aggJoin7162090358604655785 group by v26)
select name as v27 from name as n, aggView3769946054065912704 where n.id=aggView3769946054065912704.v26);
create or replace view aggView4616991137134836035 as select v27 from aggJoin701011968198652868 group by v27;
select MIN(v27) as v47 from aggView4616991137134836035;
