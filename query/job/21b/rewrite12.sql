create or replace view aggJoin4616138840410423743 as (
with aggView6345374333107001628 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6345374333107001628 where ml.link_type_id=aggView6345374333107001628.v13);
create or replace view aggJoin2346800706696011665 as (
with aggView4137454994168393970 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4137454994168393970 where mc.company_id=aggView4137454994168393970.v17);
create or replace view aggJoin3376529261615000767 as (
with aggView4678927641227869722 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4678927641227869722 where mk.keyword_id=aggView4678927641227869722.v27);
create or replace view aggJoin8632626289904405281 as (
with aggView6350930647075412691 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView6350930647075412691 where t.id=aggView6350930647075412691.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggJoin5913859484151394486 as (
with aggView4222503683922845722 as (select v29, MIN(v33) as v46 from aggJoin8632626289904405281 group by v29)
select v29, v45 as v45, v46 from aggJoin4616138840410423743 join aggView4222503683922845722 using(v29));
create or replace view aggJoin2623368870763344771 as (
with aggView6932285717479469960 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin2346800706696011665 join aggView6932285717479469960 using(v18));
create or replace view aggJoin3237323234959274186 as (
with aggView3049805726845090304 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin5913859484151394486 group by v29,v46,v45)
select v29, v44 as v44, v45, v46 from aggJoin2623368870763344771 join aggView3049805726845090304 using(v29));
create or replace view aggJoin6259340334180656540 as (
with aggView5705335590461800243 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin3237323234959274186 group by v29,v46,v45,v44)
select v44, v45, v46 from aggJoin3376529261615000767 join aggView5705335590461800243 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin6259340334180656540;
