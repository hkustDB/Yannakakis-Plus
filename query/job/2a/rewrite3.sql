create or replace view aggJoin3536678710418396950 as (
with aggView5850960978088653802 as (select id as v12, title as v31 from title as t)
select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5850960978088653802 where mc.movie_id=aggView5850960978088653802.v12);
create or replace view aggJoin9171665291391670267 as (
with aggView5719385138063326369 as (select id as v1 from company_name as cn where country_code= '[de]')
select v12, v31 from aggJoin3536678710418396950 join aggView5719385138063326369 using(v1));
create or replace view aggJoin5444898716644504583 as (
with aggView4049141496690058549 as (select v12, MIN(v31) as v31 from aggJoin9171665291391670267 group by v12,v31)
select keyword_id as v18, v31 from movie_keyword as mk, aggView4049141496690058549 where mk.movie_id=aggView4049141496690058549.v12);
create or replace view aggJoin8402130087989239847 as (
with aggView1824451855774059016 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin5444898716644504583 join aggView1824451855774059016 using(v18));
select MIN(v31) as v31 from aggJoin8402130087989239847;
