create or replace view aggJoin4592480464464593906 as (
with aggView7745715371059973748 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7745715371059973748 where ml.link_type_id=aggView7745715371059973748.v13);
create or replace view aggJoin2175294239144810137 as (
with aggView4460909335033531579 as (select id as v29, title as v46 from title as t where production_year<=2000 and production_year>=1950)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView4460909335033531579 where mc.movie_id=aggView4460909335033531579.v29);
create or replace view aggJoin5733871987742726900 as (
with aggView7544014942996558780 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select v29, v18, v46, v44 from aggJoin2175294239144810137 join aggView7544014942996558780 using(v17));
create or replace view aggJoin3054891718747219015 as (
with aggView901634630399585789 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView901634630399585789 where mk.keyword_id=aggView901634630399585789.v27);
create or replace view aggJoin8269491758634697611 as (
with aggView4399864669250287237 as (select v29, MIN(v45) as v45 from aggJoin4592480464464593906 group by v29,v45)
select v29, v45 from aggJoin3054891718747219015 join aggView4399864669250287237 using(v29));
create or replace view aggJoin3799264181934815561 as (
with aggView2430117950825587755 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v46, v44 from aggJoin5733871987742726900 join aggView2430117950825587755 using(v18));
create or replace view aggJoin6266959221133861537 as (
with aggView1426585413078073706 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin3799264181934815561 group by v29,v46,v44)
select movie_id as v29, info as v23, v46, v44 from movie_info as mi, aggView1426585413078073706 where mi.movie_id=aggView1426585413078073706.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin8252733021255567017 as (
with aggView5783006578291794557 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin6266959221133861537 group by v29,v46,v44)
select v45 as v45, v46, v44 from aggJoin8269491758634697611 join aggView5783006578291794557 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin8252733021255567017;
