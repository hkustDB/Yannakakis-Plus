create or replace view aggView6421273146545469525 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin2943367336716736047 as (
with aggView4991161265715313630 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4991161265715313630 where mk.keyword_id=aggView4991161265715313630.v27);
create or replace view aggJoin5868568976054287865 as (
with aggView845832317266361896 as (select v29 from aggJoin2943367336716736047 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView845832317266361896 where t.id=aggView845832317266361896.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView3335211295768821961 as select v33, v29 from aggJoin5868568976054287865 group by v33,v29;
create or replace view aggJoin4838120446798316740 as (
with aggView3060955086063522311 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView3060955086063522311 where ml.link_type_id=aggView3060955086063522311.v13);
create or replace view aggJoin1608598084461043679 as (
with aggView4457621154494100057 as (select v29, MIN(v33) as v46 from aggView3335211295768821961 group by v29)
select v29, v45 as v45, v46 from aggJoin4838120446798316740 join aggView4457621154494100057 using(v29));
create or replace view aggJoin4266097823459384049 as (
with aggView4356085478011595734 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select movie_id as v29, company_id as v17, company_type_id as v18 from movie_companies as mc, aggView4356085478011595734 where mc.movie_id=aggView4356085478011595734.v29);
create or replace view aggJoin1440302190876543151 as (
with aggView7047551946959238878 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v17 from aggJoin4266097823459384049 join aggView7047551946959238878 using(v18));
create or replace view aggJoin165133462625857054 as (
with aggView429555259817731112 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin1608598084461043679 group by v29,v45,v46)
select v17, v45, v46 from aggJoin1440302190876543151 join aggView429555259817731112 using(v29));
create or replace view aggJoin5428381605719522029 as (
with aggView2955923861968947483 as (select v17, MIN(v45) as v45, MIN(v46) as v46 from aggJoin165133462625857054 group by v17,v45,v46)
select v2, v45, v46 from aggView6421273146545469525 join aggView2955923861968947483 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin5428381605719522029;
