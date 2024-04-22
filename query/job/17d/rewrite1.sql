create or replace view aggJoin5790508278052793282 as (
with aggView1666383466357341485 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1666383466357341485 where mc.company_id=aggView1666383466357341485.v20);
create or replace view aggJoin824502843808747689 as (
with aggView5986801042188270993 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5986801042188270993 where mk.keyword_id=aggView5986801042188270993.v25);
create or replace view aggJoin3351076421409134844 as (
with aggView3293539445014967499 as (select v3 from aggJoin824502843808747689 group by v3)
select id as v3 from title as t, aggView3293539445014967499 where t.id=aggView3293539445014967499.v3);
create or replace view aggJoin8302831477163553915 as (
with aggView8129936881222424112 as (select v3 from aggJoin5790508278052793282 group by v3)
select v3 from aggJoin3351076421409134844 join aggView8129936881222424112 using(v3));
create or replace view aggJoin2292221678641203369 as (
with aggView1828284725386317992 as (select v3 from aggJoin8302831477163553915 group by v3)
select person_id as v26 from cast_info as ci, aggView1828284725386317992 where ci.movie_id=aggView1828284725386317992.v3);
create or replace view aggJoin4499219869448086144 as (
with aggView5628387801780602841 as (select v26 from aggJoin2292221678641203369 group by v26)
select name as v27 from name as n, aggView5628387801780602841 where n.id=aggView5628387801780602841.v26);
create or replace view aggJoin4999479940105472327 as (
with aggView5592707204122827010 as (select v27 from aggJoin4499219869448086144 group by v27)
select v27 from aggView5592707204122827010 where v27 LIKE '%Bert%');
select MIN(v27) as v47 from aggJoin4999479940105472327;
