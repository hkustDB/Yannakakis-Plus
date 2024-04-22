create or replace view aggJoin1951365695046727509 as (
with aggView2498057188586842421 as (select title as v28, id as v24 from title as t where production_year= 1998)
select v24, v28 from aggView2498057188586842421 where v28 LIKE '%Money%');
create or replace view aggView4596139066668198864 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8423400115484676277 as (
with aggView7956506662255965147 as (select v24, MIN(v28) as v41 from aggJoin1951365695046727509 group by v24)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView7956506662255965147 where ml.movie_id=aggView7956506662255965147.v24);
create or replace view aggJoin3867802297459227273 as (
with aggView3931282238844293254 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select v24, v41, v40 from aggJoin8423400115484676277 join aggView3931282238844293254 using(v13));
create or replace view aggJoin3107449261620536188 as (
with aggView5748683037387570563 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView5748683037387570563 where mk.keyword_id=aggView5748683037387570563.v22);
create or replace view aggJoin1358938606741312855 as (
with aggView5193482598605524110 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin3867802297459227273 group by v24,v40,v41)
select movie_id as v24, company_id as v17, company_type_id as v18, v41, v40 from movie_companies as mc, aggView5193482598605524110 where mc.movie_id=aggView5193482598605524110.v24);
create or replace view aggJoin3223881499665730343 as (
with aggView2489397965001840913 as (select v24 from aggJoin3107449261620536188 group by v24)
select v17, v18, v41 as v41, v40 as v40 from aggJoin1358938606741312855 join aggView2489397965001840913 using(v24));
create or replace view aggJoin2069839588029984325 as (
with aggView862221486436761219 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v41, v40 from aggJoin3223881499665730343 join aggView862221486436761219 using(v18));
create or replace view aggJoin6536157049884773473 as (
with aggView7510587209971761834 as (select v17, MIN(v41) as v41, MIN(v40) as v40 from aggJoin2069839588029984325 group by v17,v40,v41)
select v2, v41, v40 from aggView4596139066668198864 join aggView7510587209971761834 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin6536157049884773473;
