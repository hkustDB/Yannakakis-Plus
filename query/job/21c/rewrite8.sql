create or replace view aggView2564672516593840961 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin5956795283606652203 as (
with aggView4579427153365902877 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4579427153365902877 where mk.keyword_id=aggView4579427153365902877.v27);
create or replace view aggJoin4785190002876084370 as (
with aggView7315626084291574720 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v29 from aggJoin5956795283606652203 join aggView7315626084291574720 using(v29));
create or replace view aggJoin6361051156689134246 as (
with aggView2986157187762563220 as (select v29 from aggJoin4785190002876084370 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView2986157187762563220 where t.id=aggView2986157187762563220.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView2359325172362577389 as select v33, v29 from aggJoin6361051156689134246 group by v33,v29;
create or replace view aggJoin7059174974420712865 as (
with aggView5663178404182579467 as (select v29, MIN(v33) as v46 from aggView2359325172362577389 group by v29)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView5663178404182579467 where mc.movie_id=aggView5663178404182579467.v29);
create or replace view aggJoin6787420631445320602 as (
with aggView3982539458311164420 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView3982539458311164420 where ml.link_type_id=aggView3982539458311164420.v13);
create or replace view aggJoin5421806597793501006 as (
with aggView3570889358508286968 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v17, v46 from aggJoin7059174974420712865 join aggView3570889358508286968 using(v18));
create or replace view aggJoin3232601147767726187 as (
with aggView7060038315631926986 as (select v29, MIN(v45) as v45 from aggJoin6787420631445320602 group by v29,v45)
select v17, v46 as v46, v45 from aggJoin5421806597793501006 join aggView7060038315631926986 using(v29));
create or replace view aggJoin241300488433719995 as (
with aggView1844371683778149654 as (select v17, MIN(v46) as v46, MIN(v45) as v45 from aggJoin3232601147767726187 group by v17,v45,v46)
select v2, v46, v45 from aggView2564672516593840961 join aggView1844371683778149654 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin241300488433719995;
