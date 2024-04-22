create or replace view aggJoin165798834942454836 as (
with aggView5841421332501635914 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView5841421332501635914 where mc.company_id=aggView5841421332501635914.v17);
create or replace view aggJoin4081261959465531130 as (
with aggView8583666573501598979 as (select id as v24, title as v41 from title as t where title LIKE '%Money%' and production_year= 1998)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView8583666573501598979 where ml.movie_id=aggView8583666573501598979.v24);
create or replace view aggJoin6377501134320665383 as (
with aggView2418285384362964866 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select v24, v41, v40 from aggJoin4081261959465531130 join aggView2418285384362964866 using(v13));
create or replace view aggJoin1804895936386812491 as (
with aggView455411446370718175 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView455411446370718175 where mk.keyword_id=aggView455411446370718175.v22);
create or replace view aggJoin6318076262045069138 as (
with aggView7649768357994938444 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin6377501134320665383 group by v24,v40,v41)
select v24, v18, v39 as v39, v41, v40 from aggJoin165798834942454836 join aggView7649768357994938444 using(v24));
create or replace view aggJoin2117390391435079192 as (
with aggView7506856557965047739 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v41, v40 from aggJoin6318076262045069138 join aggView7506856557965047739 using(v18));
create or replace view aggJoin8464018333828701419 as (
with aggView6567105204488876057 as (select v24, MIN(v39) as v39, MIN(v41) as v41, MIN(v40) as v40 from aggJoin2117390391435079192 group by v24,v39,v40,v41)
select v39, v41, v40 from aggJoin1804895936386812491 join aggView6567105204488876057 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin8464018333828701419;
