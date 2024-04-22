create or replace view aggView5679808328020254815 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8056332944267855957 as (
with aggView4761921446234884521 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4761921446234884521 where mk.keyword_id=aggView4761921446234884521.v27);
create or replace view aggJoin7354883329846304265 as (
with aggView4602882093665196926 as (select v29 from aggJoin8056332944267855957 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView4602882093665196926 where t.id=aggView4602882093665196926.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggView8954563179381400142 as select v29, v33 from aggJoin7354883329846304265 group by v29,v33;
create or replace view aggJoin3850105700805475932 as (
with aggView6248296764914050046 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6248296764914050046 where ml.link_type_id=aggView6248296764914050046.v13);
create or replace view aggJoin1622461254970435717 as (
with aggView7670519070038884296 as (select v29, MIN(v45) as v45 from aggJoin3850105700805475932 group by v29,v45)
select v29, v33, v45 from aggView8954563179381400142 join aggView7670519070038884296 using(v29));
create or replace view aggJoin7073031677350857683 as (
with aggView32617095512816190 as (select v29, MIN(v45) as v45, MIN(v33) as v46 from aggJoin1622461254970435717 group by v29,v45)
select movie_id as v29, company_id as v17, company_type_id as v18, v45, v46 from movie_companies as mc, aggView32617095512816190 where mc.movie_id=aggView32617095512816190.v29);
create or replace view aggJoin7705609621884583151 as (
with aggView8674493895863001151 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v17, v18, v45 as v45, v46 as v46 from aggJoin7073031677350857683 join aggView8674493895863001151 using(v29));
create or replace view aggJoin2054229743977432242 as (
with aggView33898235260899331 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v45, v46 from aggJoin7705609621884583151 join aggView33898235260899331 using(v18));
create or replace view aggJoin1510040307690086518 as (
with aggView3871831408899957187 as (select v17, MIN(v45) as v45, MIN(v46) as v46 from aggJoin2054229743977432242 group by v17,v46,v45)
select v2, v45, v46 from aggView5679808328020254815 join aggView3871831408899957187 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin1510040307690086518;
