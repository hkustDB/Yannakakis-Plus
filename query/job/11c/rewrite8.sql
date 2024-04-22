create or replace view aggJoin7348234270475803626 as (
with aggView4312201954159784736 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView4312201954159784736 where mc.company_id=aggView4312201954159784736.v17);
create or replace view aggJoin7089740613698610680 as (
with aggView747849899879759502 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView747849899879759502 where mk.keyword_id=aggView747849899879759502.v22);
create or replace view aggJoin5766777465374066633 as (
with aggView5640006814254953553 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin7348234270475803626 join aggView5640006814254953553 using(v18));
create or replace view aggJoin4205568349102009422 as (
with aggView5530382426065243968 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin5766777465374066633 group by v24,v39)
select movie_id as v24, link_type_id as v13, v39, v40 from movie_link as ml, aggView5530382426065243968 where ml.movie_id=aggView5530382426065243968.v24);
create or replace view aggJoin2161992573118561323 as (
with aggView7318733290903188072 as (select id as v13 from link_type as lt)
select v24, v39, v40 from aggJoin4205568349102009422 join aggView7318733290903188072 using(v13));
create or replace view aggJoin6085798573180079799 as (
with aggView5620424592729610003 as (select v24, MIN(v39) as v39, MIN(v40) as v40 from aggJoin2161992573118561323 group by v24,v39,v40)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView5620424592729610003 where t.id=aggView5620424592729610003.v24 and production_year>1950);
create or replace view aggJoin5041902212685767332 as (
with aggView3061420428874555404 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin6085798573180079799 group by v24,v39,v40)
select v39, v40, v41 from aggJoin7089740613698610680 join aggView3061420428874555404 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5041902212685767332;
