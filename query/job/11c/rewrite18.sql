create or replace view aggJoin1694195039790087124 as (
with aggView8737346319296704830 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, company_id as v17, company_type_id as v18, note as v19, v41 from movie_companies as mc, aggView8737346319296704830 where mc.movie_id=aggView8737346319296704830.v24);
create or replace view aggJoin9109365834139394408 as (
with aggView8069988632957436310 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select v24, v18, v19, v41, v39 from aggJoin1694195039790087124 join aggView8069988632957436310 using(v17));
create or replace view aggJoin1284899181536168538 as (
with aggView3117784855094362984 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView3117784855094362984 where mk.keyword_id=aggView3117784855094362984.v22);
create or replace view aggJoin1025385334704775188 as (
with aggView6729366058742742663 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v41, v39 from aggJoin9109365834139394408 join aggView6729366058742742663 using(v18));
create or replace view aggJoin8448933176303084912 as (
with aggView4093039106769317580 as (select v24, MIN(v41) as v41, MIN(v39) as v39, MIN(v19) as v40 from aggJoin1025385334704775188 group by v24,v39,v41)
select movie_id as v24, link_type_id as v13, v41, v39, v40 from movie_link as ml, aggView4093039106769317580 where ml.movie_id=aggView4093039106769317580.v24);
create or replace view aggJoin1802158702184540604 as (
with aggView8503501276276541045 as (select id as v13 from link_type as lt)
select v24, v41, v39, v40 from aggJoin8448933176303084912 join aggView8503501276276541045 using(v13));
create or replace view aggJoin4206796438257898936 as (
with aggView961276616876134254 as (select v24, MIN(v41) as v41, MIN(v39) as v39, MIN(v40) as v40 from aggJoin1802158702184540604 group by v24,v39,v40,v41)
select v41, v39, v40 from aggJoin1284899181536168538 join aggView961276616876134254 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin4206796438257898936;
